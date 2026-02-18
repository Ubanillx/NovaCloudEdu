package com.novacloudedu.backend.config;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.springframework.stereotype.Component;

import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class Neo4jConstraintInitializer {

    private final Driver neo4jDriver;

    private static final List<String> CONSTRAINT_QUERIES = List.of(
            "CREATE CONSTRAINT user_id_unique IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE",
            "CREATE CONSTRAINT word_id_unique IF NOT EXISTS FOR (w:Word) REQUIRE w.id IS UNIQUE",
            "CREATE CONSTRAINT article_id_unique IF NOT EXISTS FOR (a:Article) REQUIRE a.id IS UNIQUE",
            "CREATE CONSTRAINT category_name_unique IF NOT EXISTS FOR (c:Category) REQUIRE c.name IS UNIQUE",
            "CREATE CONSTRAINT tag_name_unique IF NOT EXISTS FOR (t:Tag) REQUIRE t.name IS UNIQUE",
            "CREATE CONSTRAINT difficulty_level_unique IF NOT EXISTS FOR (d:Difficulty) REQUIRE d.level IS UNIQUE"
    );

    private static final List<String> INDEX_QUERIES = List.of(
            "CREATE INDEX user_username_index IF NOT EXISTS FOR (u:User) ON (u.username)",
            "CREATE INDEX word_word_index IF NOT EXISTS FOR (w:Word) ON (w.word)",
            "CREATE INDEX word_category_index IF NOT EXISTS FOR (w:Word) ON (w.category)",
            "CREATE INDEX word_difficulty_index IF NOT EXISTS FOR (w:Word) ON (w.difficulty)",
            "CREATE INDEX article_title_index IF NOT EXISTS FOR (a:Article) ON (a.title)",
            "CREATE INDEX article_category_index IF NOT EXISTS FOR (a:Article) ON (a.category)",
            "CREATE INDEX article_difficulty_index IF NOT EXISTS FOR (a:Article) ON (a.difficulty)",
            "CREATE INDEX article_view_count_index IF NOT EXISTS FOR (a:Article) ON (a.viewCount)",
            "CREATE INDEX article_like_count_index IF NOT EXISTS FOR (a:Article) ON (a.likeCount)"
    );

    @PostConstruct
    public void initializeConstraints() {
        log.info("开始初始化Neo4j约束和索引...");
        
        try (Session session = neo4jDriver.session()) {
            int constraintCount = 0;
            for (String query : CONSTRAINT_QUERIES) {
                try {
                    session.run(query);
                    constraintCount++;
                    log.debug("创建约束成功: {}", query.substring(0, Math.min(50, query.length())));
                } catch (Exception e) {
                    log.warn("创建约束失败: {}, error: {}", query, e.getMessage());
                }
            }
            
            int indexCount = 0;
            for (String query : INDEX_QUERIES) {
                try {
                    session.run(query);
                    indexCount++;
                    log.debug("创建索引成功: {}", query.substring(0, Math.min(50, query.length())));
                } catch (Exception e) {
                    log.warn("创建索引失败: {}, error: {}", query, e.getMessage());
                }
            }
            
            log.info("Neo4j约束和索引初始化完成: 约束={}, 索引={}", constraintCount, indexCount);
        } catch (Exception e) {
            log.error("Neo4j约束和索引初始化失败: {}", e.getMessage(), e);
        }
    }
}
