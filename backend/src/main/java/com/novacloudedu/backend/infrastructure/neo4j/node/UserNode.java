package com.novacloudedu.backend.infrastructure.neo4j.node;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

import java.util.HashSet;
import java.util.Set;

@Node("User")
@Data
@NoArgsConstructor
public class UserNode {

    @Id
    private Long id;

    private String username;

    @Relationship(type = "STUDIED", direction = Relationship.Direction.OUTGOING)
    private Set<WordNode> studiedWords = new HashSet<>();

    @Relationship(type = "COLLECTED_WORD", direction = Relationship.Direction.OUTGOING)
    private Set<WordNode> collectedWords = new HashSet<>();

    @Relationship(type = "READ", direction = Relationship.Direction.OUTGOING)
    private Set<ArticleNode> readArticles = new HashSet<>();

    @Relationship(type = "LIKED", direction = Relationship.Direction.OUTGOING)
    private Set<ArticleNode> likedArticles = new HashSet<>();

    @Relationship(type = "COLLECTED_ARTICLE", direction = Relationship.Direction.OUTGOING)
    private Set<ArticleNode> collectedArticles = new HashSet<>();

    public UserNode(Long id, String username) {
        this.id = id;
        this.username = username;
    }
}
