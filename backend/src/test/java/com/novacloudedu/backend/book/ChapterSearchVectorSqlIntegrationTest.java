package com.novacloudedu.backend.book;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertTrue;

@DisplayName("章节搜索向量 SQL 集成测试")
class ChapterSearchVectorSqlIntegrationTest {

    private static final String FUNCTION_MARKER = "CREATE OR REPLACE FUNCTION build_safe_chapter_search_vector";
    private static final String TRIGGER_MARKER = "CREATE OR REPLACE FUNCTION update_chapter_search_vector";
    private static final int MAX_TSVECTOR_BYTES = 1048575;

    @Test
    @DisplayName("超长章节内容仍可写入并生成搜索向量")
    void oversizedChapterContentStillBuildsSearchVector() throws Exception {
        DbConfig dbConfig = DbConfig.load();
        Assumptions.assumeTrue(dbConfig.isAvailable(), "PostgreSQL test database unavailable");

        try (Connection connection = DriverManager.getConnection(dbConfig.url(), dbConfig.username(), dbConfig.password())) {
            connection.setAutoCommit(false);

            try (Statement statement = connection.createStatement()) {
                String schemaSql = Files.readString(Path.of("sql", "40_book.sql"), StandardCharsets.UTF_8);
                maybeExecute(statement, schemaSql, FUNCTION_MARKER);
                statement.execute(extractStatement(schemaSql, TRIGGER_MARKER));

                statement.executeUpdate("""
                        INSERT INTO chapter (
                            book_id,
                            title,
                            chapter_index,
                            word_count,
                            content,
                            content_hash,
                            create_time,
                            update_time
                        )
                        SELECT
                            999999003,
                            'oversized trigger test',
                            0,
                            0,
                            oversized.content,
                            md5(oversized.content),
                            now(),
                            now()
                        FROM (
                            SELECT string_agg('token' || gs::text, ' ') AS content
                            FROM generate_series(1, 200000) gs
                        ) oversized
                        """);

                try (ResultSet resultSet = statement.executeQuery("""
                        SELECT
                            content_search_vector IS NOT NULL AS has_vector,
                            pg_column_size(content_search_vector) AS vector_size,
                            content_search_vector @@ plainto_tsquery('simple', 'token1') AS matches_prefix_token
                        FROM chapter
                        WHERE book_id = 999999003
                          AND chapter_index = 0
                        """)) {
                    assertTrue(resultSet.next(), "expected inserted chapter row");
                    assertTrue(resultSet.getBoolean("has_vector"), "expected content_search_vector to be populated");
                    assertTrue(resultSet.getInt("vector_size") <= MAX_TSVECTOR_BYTES,
                            "expected content_search_vector to stay within PostgreSQL size limit");
                    assertTrue(resultSet.getBoolean("matches_prefix_token"),
                            "expected indexed vector to preserve searchable prefix content");
                }
            } finally {
                connection.rollback();
            }
        }
    }

    private static String extractStatement(String sql, String marker) {
        int start = sql.indexOf(marker);
        if (start < 0) {
            throw new IllegalArgumentException("Could not find SQL marker: " + marker);
        }

        int end = sql.indexOf("$$ LANGUAGE plpgsql;", start);
        if (end < 0) {
            throw new IllegalArgumentException("Could not find statement terminator for marker: " + marker);
        }

        return sql.substring(start, end + "$$ LANGUAGE plpgsql;".length());
    }

    private static void maybeExecute(Statement statement, String sql, String marker) throws SQLException {
        if (sql.contains(marker)) {
            statement.execute(extractStatement(sql, marker));
        }
    }

    private record DbConfig(String url, String username, String password) {

        static DbConfig load() throws IOException {
            Map<String, String> dotenv = loadDotenv();
            String host = firstNonBlank(System.getenv("DB_HOST"), dotenv.get("DB_HOST"), "localhost");
            String port = firstNonBlank(System.getenv("DB_PORT"), dotenv.get("DB_PORT"), "5433");
            String database = firstNonBlank(System.getenv("DB_NAME"), dotenv.get("DB_NAME"), "novacloudedu");
            String username = firstNonBlank(System.getenv("DB_USERNAME"), dotenv.get("DB_USERNAME"), "nova");
            String password = firstNonBlank(System.getenv("DB_PASSWORD"), dotenv.get("DB_PASSWORD"), "");
            String url = "jdbc:postgresql://" + host + ":" + port + "/" + database + "?stringtype=unspecified";
            return new DbConfig(url, username, password);
        }

        boolean isAvailable() {
            try (Connection ignored = DriverManager.getConnection(url, username, password)) {
                return true;
            } catch (SQLException ignored) {
                return false;
            }
        }

        private static Map<String, String> loadDotenv() throws IOException {
            Path dotenvPath = Path.of(".env");
            if (!Files.exists(dotenvPath)) {
                return Map.of();
            }

            Map<String, String> values = new HashMap<>();
            for (String rawLine : Files.readAllLines(dotenvPath, StandardCharsets.UTF_8)) {
                String line = rawLine.replace("\r", "").trim();
                if (line.isEmpty() || line.startsWith("#") || !line.contains("=")) {
                    continue;
                }
                int separator = line.indexOf('=');
                String key = line.substring(0, separator).trim();
                String value = line.substring(separator + 1).trim();
                values.put(key, stripQuotes(value));
            }
            return values;
        }

        private static String stripQuotes(String value) {
            if (value.length() >= 2) {
                char first = value.charAt(0);
                char last = value.charAt(value.length() - 1);
                if ((first == '\'' && last == '\'') || (first == '"' && last == '"')) {
                    return value.substring(1, value.length() - 1);
                }
            }
            return value;
        }

        private static String firstNonBlank(String... values) {
            for (String value : values) {
                if (value != null && !value.isBlank()) {
                    return value;
                }
            }
            return "";
        }
    }
}
