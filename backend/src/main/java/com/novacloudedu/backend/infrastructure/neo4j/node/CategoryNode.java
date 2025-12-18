package com.novacloudedu.backend.infrastructure.neo4j.node;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;

@Node("Category")
@Data
@NoArgsConstructor
public class CategoryNode {

    @Id
    private String name;

    private String type;

    public CategoryNode(String name, String type) {
        this.name = name;
        this.type = type;
    }
}
