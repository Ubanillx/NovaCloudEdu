package com.novacloudedu.backend.infrastructure.neo4j.repository;

import com.novacloudedu.backend.infrastructure.neo4j.node.CategoryNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryNodeRepository extends Neo4jRepository<CategoryNode, String> {

    Optional<CategoryNode> findByName(String name);

    List<CategoryNode> findByType(String type);
}
