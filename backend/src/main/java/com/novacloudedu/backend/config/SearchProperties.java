package com.novacloudedu.backend.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "search.elasticsearch")
public class SearchProperties {

    private boolean enabled = false;

    private String bookIndex = "nova_books";

    private String chapterIndex = "nova_chapters";

    private String postIndex = "nova_posts";

    private String highlightPreTag = "<em class=\"search-highlight\">";

    private String highlightPostTag = "</em>";

    private int maxResultWindow = 10000;

    private int suggestSize = 10;

    private int fragmentSize = 150;

    private int numberOfFragments = 3;
}
