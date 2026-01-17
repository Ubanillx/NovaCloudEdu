package com.novacloudedu.backend.book;

import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.infrastructure.parser.*;
import org.junit.jupiter.api.*;

import java.io.File;
import java.nio.file.Paths;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@DisplayName("文档解析器性能测试")
class BookParserPerformanceTest {

    private static final long ACCEPTABLE_PARSE_TIME_MS = 30000; // 30秒

    @Test
    @Order(1)
    @DisplayName("TXT解析性能测试 - 大文件")
    void testTxtParserPerformance() {
        String projectRoot = System.getProperty("user.dir");
        String testFilePath = Paths.get(projectRoot, "test-flie", "斗破苍穹.txt").toString();
        File testFile = new File(testFilePath);
        
        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        TxtBookParser parser = new TxtBookParser();
        String fileUrl = "file://" + testFilePath;
        
        long startTime = System.currentTimeMillis();
        ParsedBook result = parser.parse(fileUrl);
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;

        System.out.println("=== TXT解析性能测试 ===");
        System.out.println("文件大小: " + (testFile.length() / 1024 / 1024) + " MB");
        System.out.println("解析时间: " + duration + " ms");
        System.out.println("章节数: " + result.getChapters().size());
        System.out.println("平均每章耗时: " + (duration / result.getChapters().size()) + " ms");

        assertTrue(duration < ACCEPTABLE_PARSE_TIME_MS, 
                "解析时间过长: " + duration + "ms，超过限制 " + ACCEPTABLE_PARSE_TIME_MS + "ms");
    }

    @Test
    @Order(2)
    @DisplayName("PDF解析性能测试 - 大文件")
    void testPdfParserPerformance() {
        String projectRoot = System.getProperty("user.dir");
        String testFilePath = Paths.get(projectRoot, "test-flie", "数据库系统概论（第5版） .pdf").toString();
        File testFile = new File(testFilePath);
        
        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        PdfBookParser parser = new PdfBookParser();
        String fileUrl = "file://" + testFilePath;
        
        long startTime = System.currentTimeMillis();
        ParsedBook result = parser.parse(fileUrl);
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;

        System.out.println("=== PDF解析性能测试 ===");
        System.out.println("文件大小: " + (testFile.length() / 1024 / 1024) + " MB");
        System.out.println("解析时间: " + duration + " ms");
        System.out.println("章节数: " + result.getChapters().size());
        System.out.println("平均每章耗时: " + (duration / result.getChapters().size()) + " ms");

        assertTrue(duration < ACCEPTABLE_PARSE_TIME_MS, 
                "解析时间过长: " + duration + "ms，超过限制 " + ACCEPTABLE_PARSE_TIME_MS + "ms");
    }

    @Test
    @Order(3)
    @DisplayName("Word解析性能测试")
    void testWordParserPerformance() {
        String projectRoot = System.getProperty("user.dir");
        String testFilePath = Paths.get(projectRoot, "test-flie", "智云星课文档.docx").toString();
        File testFile = new File(testFilePath);
        
        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        WordBookParser parser = new WordBookParser();
        String fileUrl = "file://" + testFilePath;
        
        long startTime = System.currentTimeMillis();
        ParsedBook result = parser.parse(fileUrl);
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;

        System.out.println("=== Word解析性能测试 ===");
        System.out.println("文件大小: " + (testFile.length() / 1024 / 1024) + " MB");
        System.out.println("解析时间: " + duration + " ms");
        System.out.println("章节数: " + result.getChapters().size());
        if (result.getChapters().size() > 0) {
            System.out.println("平均每章耗时: " + (duration / result.getChapters().size()) + " ms");
        }

        assertTrue(duration < ACCEPTABLE_PARSE_TIME_MS, 
                "解析时间过长: " + duration + "ms，超过限制 " + ACCEPTABLE_PARSE_TIME_MS + "ms");
    }

    @Test
    @Order(4)
    @DisplayName("EPUB解析性能测试")
    void testEpubParserPerformance() {
        String projectRoot = System.getProperty("user.dir");
        String testFilePath = Paths.get(projectRoot, "test-flie", "机器学习公式详解 .epub").toString();
        File testFile = new File(testFilePath);
        
        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        EpubBookParser parser = new EpubBookParser();
        String fileUrl = "file://" + testFilePath;
        
        long startTime = System.currentTimeMillis();
        ParsedBook result = parser.parse(fileUrl);
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;

        System.out.println("=== EPUB解析性能测试 ===");
        System.out.println("文件大小: " + (testFile.length() / 1024 / 1024) + " MB");
        System.out.println("解析时间: " + duration + " ms");
        System.out.println("章节数: " + result.getChapters().size());
        if (result.getChapters().size() > 0) {
            System.out.println("平均每章耗时: " + (duration / result.getChapters().size()) + " ms");
        }

        assertTrue(duration < ACCEPTABLE_PARSE_TIME_MS, 
                "解析时间过长: " + duration + "ms，超过限制 " + ACCEPTABLE_PARSE_TIME_MS + "ms");
    }

    @Test
    @Order(5)
    @DisplayName("内存使用测试")
    void testMemoryUsage() {
        Runtime runtime = Runtime.getRuntime();
        runtime.gc();
        
        long memoryBefore = runtime.totalMemory() - runtime.freeMemory();
        
        String projectRoot = System.getProperty("user.dir");
        String testFilePath = Paths.get(projectRoot, "test-flie", "斗破苍穹.txt").toString();
        File testFile = new File(testFilePath);
        
        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        TxtBookParser parser = new TxtBookParser();
        String fileUrl = "file://" + testFilePath;
        ParsedBook result = parser.parse(fileUrl);
        
        long memoryAfter = runtime.totalMemory() - runtime.freeMemory();
        long memoryUsed = (memoryAfter - memoryBefore) / 1024 / 1024;

        System.out.println("=== 内存使用测试 ===");
        System.out.println("解析前内存: " + (memoryBefore / 1024 / 1024) + " MB");
        System.out.println("解析后内存: " + (memoryAfter / 1024 / 1024) + " MB");
        System.out.println("内存增长: " + memoryUsed + " MB");
        System.out.println("章节数: " + result.getChapters().size());

        assertTrue(memoryUsed < 500, "内存使用过多: " + memoryUsed + " MB");
    }
}
