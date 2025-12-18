package com.novacloudedu.backend.infrastructure.neo4j.repository;

import com.novacloudedu.backend.infrastructure.neo4j.node.ArticleNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.neo4j.repository.query.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleNodeRepository extends Neo4jRepository<ArticleNode, Long> {

    List<ArticleNode> findByCategory(String category);

    List<ArticleNode> findByDifficulty(Integer difficulty);

    @Query("MATCH (u:User {id: $userId})-[:READ]->(a:Article)<-[:READ]-(similar:User)-[:READ]->(recommend:Article) " +
           "WHERE NOT (u)-[:READ]->(recommend) " +
           "RETURN recommend, count(similar) as score " +
           "ORDER BY score DESC " +
           "LIMIT $limit")
    List<ArticleNode> recommendArticlesByCollaborativeFiltering(@Param("userId") Long userId, @Param("limit") int limit);

    @Query("MATCH (u:User {id: $userId})-[:READ]->(a:Article)-[:BELONGS_TO]->(c:Category)<-[:BELONGS_TO]-(recommend:Article) " +
           "WHERE NOT (u)-[:READ]->(recommend) " +
           "RETURN recommend, count(a) as score " +
           "ORDER BY score DESC " +
           "LIMIT $limit")
    List<ArticleNode> recommendArticlesBySameCategory(@Param("userId") Long userId, @Param("limit") int limit);

    @Query("MATCH (u:User {id: $userId})-[:READ]->(a:Article)-[:HAS_TAG]->(t:Tag)<-[:HAS_TAG]-(recommend:Article) " +
           "WHERE NOT (u)-[:READ]->(recommend) " +
           "RETURN recommend, count(t) as score " +
           "ORDER BY score DESC " +
           "LIMIT $limit")
    List<ArticleNode> recommendArticlesBySameTag(@Param("userId") Long userId, @Param("limit") int limit);

    @Query("MATCH (u:User {id: $userId})-[:LIKED]->(a:Article)<-[:LIKED]-(similar:User)-[:LIKED]->(recommend:Article) " +
           "WHERE NOT (u)-[:LIKED]->(recommend) AND NOT (u)-[:READ]->(recommend) " +
           "RETURN recommend, count(similar) as score " +
           "ORDER BY score DESC " +
           "LIMIT $limit")
    List<ArticleNode> recommendArticlesByLikedUsers(@Param("userId") Long userId, @Param("limit") int limit);

    @Query("MATCH (a:Article) " +
           "WHERE NOT (:User {id: $userId})-[:READ]->(a) " +
           "RETURN a " +
           "ORDER BY a.likeCount DESC, a.viewCount DESC " +
           "LIMIT $limit")
    List<ArticleNode> findPopularUnreadArticles(@Param("userId") Long userId, @Param("limit") int limit);
}
