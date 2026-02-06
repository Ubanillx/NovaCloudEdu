package com.novacloudedu.backend.domain.scraper.valueobject;

import lombok.Getter;

/**
 * 文章来源枚举
 */
@Getter
public enum ArticleSource {
    DOGO_NEWS("dogonews", "Dogo News", "https://www.dogonews.com"),
    SCIENCE_NEWS_FOR_STUDENTS("snexplores", "Science News for Students", "https://www.snexplores.org"),
    TIME_FOR_KIDS("timeforkids", "TIME for Kids", "https://timeforkids.com"),
    BBC_BITESIZE("bbc_bitesize", "BBC Bitesize", "https://www.bbc.co.uk/bitesize"),
    NAT_GEO_KIDS("natgeokids", "National Geographic Kids", "https://kids.nationalgeographic.com"),
    FUNBRAIN("funbrain", "Funbrain", "https://www.funbrain.com"),
    CUSTOM("custom", "自定义来源", "");

    private final String code;
    private final String displayName;
    private final String baseUrl;

    ArticleSource(String code, String displayName, String baseUrl) {
        this.code = code;
        this.displayName = displayName;
        this.baseUrl = baseUrl;
    }

    public static ArticleSource fromCode(String code) {
        for (ArticleSource source : values()) {
            if (source.code.equalsIgnoreCase(code)) {
                return source;
            }
        }
        return CUSTOM;
    }

    public static ArticleSource fromUrl(String url) {
        if (url == null) return CUSTOM;
        for (ArticleSource source : values()) {
            if (source != CUSTOM && url.contains(source.baseUrl.replace("https://", "").replace("http://", ""))) {
                return source;
            }
        }
        return CUSTOM;
    }
}
