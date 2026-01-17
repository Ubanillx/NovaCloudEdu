package com.novacloudedu.backend.book;

import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.infrastructure.parser.TxtBookParser;
import org.junit.jupiter.api.*;

import java.io.File;
import java.nio.file.Paths;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@DisplayName("TXT文档解析器测试")
class TxtBookParserTest {

    private TxtBookParser parser;
    private String testFilePath;

    @BeforeEach
    void setUp() {
        parser = new TxtBookParser();
        String projectRoot = System.getProperty("user.dir");
        testFilePath = Paths.get(projectRoot, "test-flie", "斗破苍穹.txt").toString();
    }

    @Test
    @Order(1)
    @DisplayName("检查解析器支持的文件类型")
    void testSupports() {
        assertTrue(parser.supports(FileType.TXT));
        assertFalse(parser.supports(FileType.EPUB));
        assertFalse(parser.supports(FileType.DOCX));
        assertFalse(parser.supports(FileType.PDF));
    }

    @Test
    @Order(2)
    @DisplayName("解析TXT文件 - 成功")
    void parseTxtFile_Success() {
        File testFile = new File(testFilePath);
        
        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        String fileUrl = "file://" + testFilePath;
        ParsedBook result = parser.parse(fileUrl);

        assertNotNull(result);
        assertNotNull(result.getTitle());
        assertNotNull(result.getChapters());
        assertTrue(result.getChapters().size() > 0);

        System.out.println("解析结果:");
        System.out.println("书名: " + result.getTitle());
        System.out.println("作者: " + result.getAuthor());
        System.out.println("章节数: " + result.getChapters().size());

        ParsedBook.ParsedChapter firstChapter = result.getChapters().get(0);
        assertNotNull(firstChapter.getTitle());
        assertNotNull(firstChapter.getContent());
        assertTrue(firstChapter.getContent().length() > 0);

        System.out.println("第一章标题: " + firstChapter.getTitle());
        System.out.println("第一章内容长度: " + firstChapter.getContent().length());
    }

    @Test
    @Order(3)
    @DisplayName("解析TXT文件 - 章节索引正确")
    void parseTxtFile_ChapterIndexCorrect() {
        File testFile = new File(testFilePath);
        
        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        String fileUrl = "file://" + testFilePath;
        ParsedBook result = parser.parse(fileUrl);

        for (int i = 0; i < result.getChapters().size(); i++) {
            ParsedBook.ParsedChapter chapter = result.getChapters().get(i);
            assertEquals(i, chapter.getChapterIndex());
        }
    }

    @Test
    @Order(4)
    @DisplayName("解析TXT文件 - 内容包含HTML标签")
    void parseTxtFile_ContentContainsHtml() {
        File testFile = new File(testFilePath);
        
        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        String fileUrl = "file://" + testFilePath;
        ParsedBook result = parser.parse(fileUrl);

        ParsedBook.ParsedChapter firstChapter = result.getChapters().get(0);
        String content = firstChapter.getContent();

        assertTrue(content.contains("<div"));
        assertTrue(content.contains("<p>"));
        assertTrue(content.contains("</p>"));
        assertTrue(content.contains("</div>"));
    }
}
