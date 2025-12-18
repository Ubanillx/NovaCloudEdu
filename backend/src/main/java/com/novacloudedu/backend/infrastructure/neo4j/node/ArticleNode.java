package com.novacloudedu.backend.infrastructure.neo4j.node;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

import java.util.HashSet;
import java.util.Set;

@Node("Article")
@Data
@NoArgsConstructor
public class ArticleNode {

    @Id
    private Long id;

    private String title;

    private String summary;

    private Integer difficulty;

    private String category;

    private Integer viewCount;

    private Integer likeCount;

    @Relationship(type = "BELONGS_TO", direction = Relationship.Direction.OUTGOING)
    private CategoryNode categoryNode;

    @Relationship(type = "HAS_DIFFICULTY", direction = Relationship.Direction.OUTGOING)
    private DifficultyNode difficultyNode;

    @Relationship(type = "HAS_TAG", direction = Relationship.Direction.OUTGOING)
    private Set<TagNode> tags = new HashSet<>();

    public ArticleNode(Long id, String title, String summary, Integer difficulty, String category) {
        this.id = id;
        this.title = title;
        this.summary = summary;
        this.difficulty = difficulty;
        this.category = category;
    }
}
