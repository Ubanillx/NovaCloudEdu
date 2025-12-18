package com.novacloudedu.backend.infrastructure.neo4j.repository;

import com.novacloudedu.backend.infrastructure.neo4j.node.UserNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.neo4j.repository.query.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserNodeRepository extends Neo4jRepository<UserNode, Long> {

    Optional<UserNode> findByUsername(String username);

    @Query("MATCH (u:User {id: $userId})-[:STUDIED]->(w:Word)<-[:STUDIED]-(similar:User) " +
           "WHERE u.id <> similar.id " +
           "RETURN similar, count(w) as commonWords " +
           "ORDER BY commonWords DESC " +
           "LIMIT $limit")
    List<UserNode> findSimilarUsersByStudiedWords(@Param("userId") Long userId, @Param("limit") int limit);

    @Query("MATCH (u:User {id: $userId})-[:READ]->(a:Article)<-[:READ]-(similar:User) " +
           "WHERE u.id <> similar.id " +
           "RETURN similar, count(a) as commonArticles " +
           "ORDER BY commonArticles DESC " +
           "LIMIT $limit")
    List<UserNode> findSimilarUsersByReadArticles(@Param("userId") Long userId, @Param("limit") int limit);
}
