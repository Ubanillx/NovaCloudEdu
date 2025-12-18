package com.novacloudedu.backend.infrastructure.neo4j.node;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;

@Node("Tag")
@Data
@NoArgsConstructor
public class TagNode {

    @Id
    private String name;

    public TagNode(String name) {
        this.name = name;
    }
}
