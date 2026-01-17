package com.novacloudedu.backend.domain.book.service;

import com.novacloudedu.backend.domain.book.valueobject.FileType;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookParserManager {

    private final List<BookParser> parsers;

    public BookParserManager(List<BookParser> parsers) {
        this.parsers = parsers;
    }

    public ParsedBook parse(String fileUrl, FileType fileType) {
        return parsers.stream()
                .filter(parser -> parser.supports(fileType))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("不支持的文件类型: " + fileType))
                .parse(fileUrl);
    }
}
