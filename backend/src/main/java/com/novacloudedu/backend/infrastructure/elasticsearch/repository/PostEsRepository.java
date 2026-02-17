package com.novacloudedu.backend.infrastructure.elasticsearch.repository;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.*;
import co.elastic.clients.elasticsearch.core.bulk.BulkOperation;
import com.novacloudedu.backend.config.SearchProperties;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.PostDocument;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.util.List;

@Slf4j
@Repository
@RequiredArgsConstructor
@ConditionalOnProperty(name = "search.elasticsearch.enabled", havingValue = "true")
public class PostEsRepository {

    private final ElasticsearchClient client;
    private final SearchProperties searchProperties;

    public void save(PostDocument doc) {
        try {
            client.index(IndexRequest.of(i -> i
                    .index(searchProperties.getPostIndex())
                    .id(String.valueOf(doc.getId()))
                    .document(doc)));
        } catch (IOException e) {
            log.error("索引帖子文档失败: postId={}", doc.getId(), e);
        }
    }

    public void bulkSave(List<PostDocument> docs) {
        if (docs.isEmpty()) return;
        try {
            List<BulkOperation> operations = docs.stream()
                    .map(doc -> BulkOperation.of(op -> op
                            .index(idx -> idx
                                    .index(searchProperties.getPostIndex())
                                    .id(String.valueOf(doc.getId()))
                                    .document(doc))))
                    .toList();
            BulkResponse response = client.bulk(BulkRequest.of(b -> b.operations(operations)));
            if (response.errors()) {
                log.error("批量索引帖子文档部分失败");
            }
        } catch (IOException e) {
            log.error("批量索引帖子文档失败", e);
        }
    }

    public void deleteById(Long id) {
        try {
            client.delete(DeleteRequest.of(d -> d
                    .index(searchProperties.getPostIndex())
                    .id(String.valueOf(id))));
        } catch (IOException e) {
            log.error("删除帖子文档失败: postId={}", id, e);
        }
    }
}
