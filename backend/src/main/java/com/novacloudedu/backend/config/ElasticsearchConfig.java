package com.novacloudedu.backend.config;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.indices.ExistsRequest;
import co.elastic.clients.json.jackson.JacksonJsonpMapper;
import co.elastic.clients.transport.ElasticsearchTransport;
import co.elastic.clients.transport.rest_client.RestClientTransport;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.autoconfigure.elasticsearch.ElasticsearchProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.StringReader;
import java.util.List;

@Slf4j
@Configuration
@RequiredArgsConstructor
@ConditionalOnProperty(name = "search.elasticsearch.enabled", havingValue = "true")
public class ElasticsearchConfig {

    private final ElasticsearchProperties elasticsearchProperties;
    private final SearchProperties searchProperties;

    @Bean
    public ElasticsearchClient elasticsearchClient() {
        List<String> uris = elasticsearchProperties.getUris();
        String uri = (uris != null && !uris.isEmpty()) ? uris.get(0) : "http://localhost:9200";

        String host = uri.replaceAll("https?://", "").split(":")[0];
        int port = 9200;
        try {
            String portStr = uri.replaceAll("https?://", "").split(":")[1];
            port = Integer.parseInt(portStr);
        } catch (Exception ignored) {
        }

        RestClient restClient = RestClient.builder(new HttpHost(host, port, "http")).build();

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

        ElasticsearchTransport transport = new RestClientTransport(restClient, new JacksonJsonpMapper(objectMapper));
        return new ElasticsearchClient(transport);
    }

    @PostConstruct
    public void initIndices() {
        if (!searchProperties.isEnabled()) {
            return;
        }
        // 索引初始化在 Bean 创建后异步执行，避免阻塞启动
        new Thread(() -> {
            try {
                Thread.sleep(5000); // 等待 ES 连接就绪
                ElasticsearchClient client = elasticsearchClient();
                createBookIndex(client);
                createChapterIndex(client);
                createPostIndex(client);
                log.info("Elasticsearch 索引初始化完成");
            } catch (Exception e) {
                log.warn("Elasticsearch 索引初始化失败（ES 可能未启动）: {}", e.getMessage());
            }
        }, "es-index-init").start();
    }

    private void createBookIndex(ElasticsearchClient client) throws Exception {
        String indexName = searchProperties.getBookIndex();
        boolean exists = client.indices().exists(ExistsRequest.of(e -> e.index(indexName))).value();
        if (exists) {
            log.info("索引 {} 已存在，跳过创建", indexName);
            return;
        }

        String settings = """
                {
                  "settings": {
                    "number_of_shards": 1,
                    "number_of_replicas": 0,
                    "analysis": {
                      "analyzer": {
                        "ik_pinyin_analyzer": {
                          "tokenizer": "ik_max_word",
                          "filter": ["pinyin_filter", "lowercase"]
                        },
                        "pinyin_only_analyzer": {
                          "tokenizer": "keyword",
                          "filter": ["pinyin_filter", "lowercase"]
                        }
                      },
                      "filter": {
                        "pinyin_filter": {
                          "type": "pinyin",
                          "keep_full_pinyin": true,
                          "keep_first_letter": true,
                          "keep_joined_full_pinyin": true,
                          "keep_original": true,
                          "limit_first_letter_length": 16,
                          "remove_duplicated_term": true
                        }
                      }
                    }
                  },
                  "mappings": {
                    "properties": {
                      "id":            { "type": "long" },
                      "title":         { "type": "text", "analyzer": "ik_max_word", "search_analyzer": "ik_smart",
                                          "fields": {
                                            "keyword": { "type": "keyword" },
                                            "pinyin":  { "type": "text", "analyzer": "ik_pinyin_analyzer", "search_analyzer": "ik_pinyin_analyzer" },
                                            "suggest": { "type": "completion", "analyzer": "ik_pinyin_analyzer" }
                                          }
                                        },
                      "author":        { "type": "text", "analyzer": "ik_max_word", "search_analyzer": "ik_smart",
                                          "fields": {
                                            "keyword": { "type": "keyword" },
                                            "pinyin":  { "type": "text", "analyzer": "ik_pinyin_analyzer" },
                                            "suggest": { "type": "completion", "analyzer": "ik_pinyin_analyzer" }
                                          }
                                        },
                      "fileType":      { "type": "keyword" },
                      "status":        { "type": "integer" },
                      "totalChapters": { "type": "integer" },
                      "wordCount":     { "type": "integer" },
                      "coverUrl":      { "type": "keyword", "index": false },
                      "createTime":    { "type": "date", "format": "strict_date_optional_time||yyyy-MM-dd HH:mm:ss||epoch_millis" }
                    }
                  }
                }
                """;

        client.indices().create(c -> c.index(indexName).withJson(new StringReader(settings)));
        log.info("索引 {} 创建成功", indexName);
    }

    private void createChapterIndex(ElasticsearchClient client) throws Exception {
        String indexName = searchProperties.getChapterIndex();
        boolean exists = client.indices().exists(ExistsRequest.of(e -> e.index(indexName))).value();
        if (exists) {
            log.info("索引 {} 已存在，跳过创建", indexName);
            return;
        }

        String settings = """
                {
                  "settings": {
                    "number_of_shards": 1,
                    "number_of_replicas": 0,
                    "analysis": {
                      "analyzer": {
                        "ik_pinyin_analyzer": {
                          "tokenizer": "ik_max_word",
                          "filter": ["pinyin_filter", "lowercase"]
                        }
                      },
                      "filter": {
                        "pinyin_filter": {
                          "type": "pinyin",
                          "keep_full_pinyin": true,
                          "keep_first_letter": true,
                          "keep_joined_full_pinyin": true,
                          "keep_original": true,
                          "limit_first_letter_length": 16,
                          "remove_duplicated_term": true
                        }
                      }
                    }
                  },
                  "mappings": {
                    "properties": {
                      "id":            { "type": "long" },
                      "bookId":        { "type": "long" },
                      "bookTitle":     { "type": "text", "analyzer": "ik_smart" },
                      "title":         { "type": "text", "analyzer": "ik_max_word", "search_analyzer": "ik_smart",
                                          "fields": { "keyword": { "type": "keyword" } }
                                        },
                      "chapterIndex":  { "type": "integer" },
                      "content":       { "type": "text", "analyzer": "ik_max_word", "search_analyzer": "ik_smart" },
                      "wordCount":     { "type": "integer" }
                    }
                  }
                }
                """;

        client.indices().create(c -> c.index(indexName).withJson(new StringReader(settings)));
        log.info("索引 {} 创建成功", indexName);
    }

    private void createPostIndex(ElasticsearchClient client) throws Exception {
        String indexName = searchProperties.getPostIndex();
        boolean exists = client.indices().exists(ExistsRequest.of(e -> e.index(indexName))).value();
        if (exists) {
            log.info("索引 {} 已存在，跳过创建", indexName);
            return;
        }

        String settings = """
                {
                  "settings": {
                    "number_of_shards": 1,
                    "number_of_replicas": 0,
                    "analysis": {
                      "analyzer": {
                        "ik_pinyin_analyzer": {
                          "tokenizer": "ik_max_word",
                          "filter": ["pinyin_filter", "lowercase"]
                        }
                      },
                      "filter": {
                        "pinyin_filter": {
                          "type": "pinyin",
                          "keep_full_pinyin": true,
                          "keep_first_letter": true,
                          "keep_joined_full_pinyin": true,
                          "keep_original": true,
                          "limit_first_letter_length": 16,
                          "remove_duplicated_term": true
                        }
                      }
                    }
                  },
                  "mappings": {
                    "properties": {
                      "id":          { "type": "long" },
                      "title":       { "type": "text", "analyzer": "ik_max_word", "search_analyzer": "ik_smart",
                                        "fields": {
                                          "keyword": { "type": "keyword" },
                                          "pinyin":  { "type": "text", "analyzer": "ik_pinyin_analyzer" },
                                          "suggest": { "type": "completion", "analyzer": "ik_pinyin_analyzer" }
                                        }
                                      },
                      "content":     { "type": "text", "analyzer": "ik_max_word", "search_analyzer": "ik_smart" },
                      "tags":        { "type": "keyword" },
                      "postType":    { "type": "keyword" },
                      "userId":      { "type": "long" },
                      "thumbNum":    { "type": "integer" },
                      "favourNum":   { "type": "integer" },
                      "commentNum":  { "type": "integer" },
                      "createTime":  { "type": "date", "format": "strict_date_optional_time||yyyy-MM-dd HH:mm:ss||epoch_millis" }
                    }
                  }
                }
                """;

        client.indices().create(c -> c.index(indexName).withJson(new StringReader(settings)));
        log.info("索引 {} 创建成功", indexName);
    }
}
