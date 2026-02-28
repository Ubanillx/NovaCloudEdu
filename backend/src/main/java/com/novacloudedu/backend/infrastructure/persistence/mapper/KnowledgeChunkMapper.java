package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.KnowledgeChunkPO;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

/**
 * 知识库分块Mapper
 */
@Mapper
public interface KnowledgeChunkMapper extends BaseMapper<KnowledgeChunkPO> {

    @Insert("INSERT INTO knowledge_chunk (knowledge_base_id, document_id, content, chunk_index, parent_chunk_id, is_parent_chunk, section_title, embedding, metadata, create_time, is_delete) " +
            "VALUES (#{knowledgeBaseId}, #{documentId}, #{content}, #{chunkIndex}, #{parentChunkId}, #{isParentChunk}, #{sectionTitle}, #{embedding}::vector, #{metadata}::jsonb, NOW(), 0)")
    void insertChunk(@Param("knowledgeBaseId") Long knowledgeBaseId,
                     @Param("documentId") Long documentId,
                     @Param("content") String content,
                     @Param("chunkIndex") int chunkIndex,
                     @Param("parentChunkId") Long parentChunkId,
                     @Param("isParentChunk") Boolean isParentChunk,
                     @Param("sectionTitle") String sectionTitle,
                     @Param("embedding") String embedding,
                     @Param("metadata") String metadata);

    @Select("SELECT id, knowledge_base_id, document_id, content, metadata, " +
            "1 - (embedding <=> #{queryEmbedding}::vector) as similarity " +
            "FROM knowledge_chunk " +
            "WHERE knowledge_base_id = #{knowledgeBaseId} AND is_delete = 0 " +
            "ORDER BY embedding <=> #{queryEmbedding}::vector " +
            "LIMIT #{topK}")
    List<Map<String, Object>> searchSimilar(@Param("knowledgeBaseId") Long knowledgeBaseId,
                                            @Param("queryEmbedding") String queryEmbedding,
                                            @Param("topK") int topK);

    @Select("<script>" +
            "<![CDATA[" +
            "SELECT id, knowledge_base_id, document_id, content, metadata, " +
            "1 - (embedding <=> #{queryEmbedding}::vector) as similarity " +
            "FROM knowledge_chunk " +
            "WHERE knowledge_base_id IN " +
            "]]>" +
            "<foreach item='id' collection='knowledgeBaseIds' open='(' separator=',' close=')'>" +
            "#{id}" +
            "</foreach> " +
            "<![CDATA[" +
            "AND is_delete = 0 " +
            "ORDER BY embedding <=> #{queryEmbedding}::vector " +
            "LIMIT #{topK}" +
            "]]>" +
            "</script>")
    List<Map<String, Object>> searchSimilarInMultiple(@Param("knowledgeBaseIds") List<Long> knowledgeBaseIds,
                                                      @Param("queryEmbedding") String queryEmbedding,
                                                      @Param("topK") int topK);

    @Update("UPDATE knowledge_chunk SET is_delete = 1 WHERE document_id = #{documentId}")
    void deleteByDocumentId(@Param("documentId") Long documentId);

    @Update("UPDATE knowledge_chunk SET is_delete = 1 WHERE knowledge_base_id = #{knowledgeBaseId}")
    void deleteByKnowledgeBaseId(@Param("knowledgeBaseId") Long knowledgeBaseId);

    @Select("SELECT COUNT(*) FROM knowledge_chunk WHERE knowledge_base_id = #{knowledgeBaseId} AND is_delete = 0")
    long countByKnowledgeBaseId(@Param("knowledgeBaseId") Long knowledgeBaseId);

    @Select("SELECT id, knowledge_base_id, document_id, content, chunk_index, parent_chunk_id, is_parent_chunk, section_title, metadata, create_time " +
            "FROM knowledge_chunk " +
            "WHERE document_id = #{documentId} AND is_delete = 0 " +
            "ORDER BY chunk_index ASC " +
            "LIMIT #{size} OFFSET #{offset}")
    List<Map<String, Object>> findByDocumentId(@Param("documentId") Long documentId,
                                                @Param("offset") int offset,
                                                @Param("size") int size);

    @Select("SELECT COUNT(*) FROM knowledge_chunk WHERE document_id = #{documentId} AND is_delete = 0")
    long countByDocumentId(@Param("documentId") Long documentId);

    @Insert("<script>" +
            "INSERT INTO knowledge_chunk (knowledge_base_id, document_id, content, chunk_index, parent_chunk_id, is_parent_chunk, section_title, embedding, metadata, create_time, is_delete) VALUES " +
            "<foreach item='item' collection='chunks' separator=','>" +
            "(#{item.knowledgeBaseId}, #{item.documentId}, #{item.content}, #{item.chunkIndex}, #{item.parentChunkId}, #{item.isParentChunk}, #{item.sectionTitle}, #{item.embedding}::vector, #{item.metadata}::jsonb, NOW(), 0)" +
            "</foreach>" +
            "</script>")
    void batchInsertChunks(@Param("chunks") List<Map<String, Object>> chunks);

    @Select("<script>" +
            "<![CDATA[" +
            "SELECT id, knowledge_base_id, document_id, content, metadata, " +
            "ts_rank(to_tsvector('simple', content), plainto_tsquery('simple', #{query})) as similarity " +
            "FROM knowledge_chunk " +
            "WHERE knowledge_base_id IN " +
            "]]>" +
            "<foreach item='id' collection='knowledgeBaseIds' open='(' separator=',' close=')'>" +
            "#{id}" +
            "</foreach> " +
            "<![CDATA[" +
            "AND is_delete = 0 " +
            "AND to_tsvector('simple', content) @@ plainto_tsquery('simple', #{query}) " +
            "ORDER BY similarity DESC " +
            "LIMIT #{topK}" +
            "]]>" +
            "</script>")
    List<Map<String, Object>> fullTextSearchInMultiple(@Param("knowledgeBaseIds") List<Long> knowledgeBaseIds,
                                                       @Param("query") String query,
                                                       @Param("topK") int topK);

    @Select("<script>" +
            "<![CDATA[" +
            "SELECT id, knowledge_base_id, document_id, content, metadata, " +
            "similarity(content, #{query}) as similarity " +
            "FROM knowledge_chunk " +
            "WHERE knowledge_base_id IN " +
            "]]>" +
            "<foreach item='id' collection='knowledgeBaseIds' open='(' separator=',' close=')'>" +
            "#{id}" +
            "</foreach> " +
            "<![CDATA[" +
            "AND is_delete = 0 " +
            "AND content % #{query} " +
            "ORDER BY similarity DESC " +
            "LIMIT #{topK}" +
            "]]>" +
            "</script>")
    List<Map<String, Object>> trigramSearchInMultiple(@Param("knowledgeBaseIds") List<Long> knowledgeBaseIds,
                                                      @Param("query") String query,
                                                      @Param("topK") int topK);
}
