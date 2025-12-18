package com.novacloudedu.backend.infrastructure.neo4j.repository;

import com.novacloudedu.backend.infrastructure.neo4j.node.TagNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TagNodeRepository extends Neo4jRepository<TagNode, String> {

    Optional<TagNode> findByName(String name);
}
