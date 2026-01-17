package com.novacloudedu.backend.domain.book.service;

import com.novacloudedu.backend.domain.book.valueobject.FileType;

public interface BookParser {

    boolean supports(FileType fileType);

    ParsedBook parse(String fileUrl);
}
