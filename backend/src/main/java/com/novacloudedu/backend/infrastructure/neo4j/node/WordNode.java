package com.novacloudedu.backend.infrastructure.neo4j.node;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

@Node("Word")
@Data
@NoArgsConstructor
public class WordNode {

    @Id
    private Long id;

    private String word;

    private String translation;

    private Integer difficulty;

    private String category;

    @Relationship(type = "BELONGS_TO", direction = Relationship.Direction.OUTGOING)
    private CategoryNode categoryNode;

    @Relationship(type = "HAS_DIFFICULTY", direction = Relationship.Direction.OUTGOING)
    private DifficultyNode difficultyNode;

    public WordNode(Long id, String word, String translation, Integer difficulty, String category) {
        this.id = id;
        this.word = word;
        this.translation = translation;
        this.difficulty = difficulty;
        this.category = category;
    }
}
