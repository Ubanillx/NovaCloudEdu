package com.novacloudedu.backend.infrastructure.neo4j.repository;

import com.novacloudedu.backend.infrastructure.neo4j.node.WordNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.neo4j.repository.query.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WordNodeRepository extends Neo4jRepository<WordNode, Long> {

    List<WordNode> findByCategory(String category);

    List<WordNode> findByDifficulty(Integer difficulty);

    @Query("MATCH (u:User {id: $userId})-[:STUDIED]->(w:Word)<-[:STUDIED]-(similar:User)-[:STUDIED]->(recommend:Word) " +
           "WHERE NOT (u)-[:STUDIED]->(recommend) " +
           "RETURN recommend, count(similar) as score " +
           "ORDER BY score DESC " +
           "LIMIT $limit")
    List<WordNode> recommendWordsByCollaborativeFiltering(@Param("userId") Long userId, @Param("limit") int limit);

    @Query("MATCH (u:User {id: $userId})-[:STUDIED]->(w:Word)-[:BELONGS_TO]->(c:Category)<-[:BELONGS_TO]-(recommend:Word) " +
           "WHERE NOT (u)-[:STUDIED]->(recommend) " +
           "RETURN recommend, count(w) as score " +
           "ORDER BY score DESC " +
           "LIMIT $limit")
    List<WordNode> recommendWordsBySameCategory(@Param("userId") Long userId, @Param("limit") int limit);

    @Query("MATCH (u:User {id: $userId})-[:STUDIED]->(w:Word)-[:HAS_DIFFICULTY]->(d:Difficulty)<-[:HAS_DIFFICULTY]-(recommend:Word) " +
           "WHERE NOT (u)-[:STUDIED]->(recommend) " +
           "RETURN recommend, count(w) as score " +
           "ORDER BY score DESC " +
           "LIMIT $limit")
    List<WordNode> recommendWordsBySameDifficulty(@Param("userId") Long userId, @Param("limit") int limit);

    @Query("MATCH (w:Word) " +
           "WHERE NOT (:User {id: $userId})-[:STUDIED]->(w) " +
           "RETURN w " +
           "ORDER BY w.id DESC " +
           "LIMIT $limit")
    List<WordNode> findUnstudiedWords(@Param("userId") Long userId, @Param("limit") int limit);
}
