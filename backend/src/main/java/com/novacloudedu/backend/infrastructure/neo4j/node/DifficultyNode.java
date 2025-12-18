package com.novacloudedu.backend.infrastructure.neo4j.node;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;

@Node("Difficulty")
@Data
@NoArgsConstructor
public class DifficultyNode {

    @Id
    private Integer level;

    private String description;

    public DifficultyNode(Integer level, String description) {
        this.level = level;
        this.description = description;
    }
}
