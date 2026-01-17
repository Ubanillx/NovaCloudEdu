package com.novacloudedu.backend.book;

import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@DisplayName("书籍Controller集成测试")
class BookControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    private static Long uploadedBookId;

    @Test
    @Order(1)
    @DisplayName("上传书籍 - TXT文件")
    @WithMockUser(roles = "ADMIN")
    @Transactional
    void uploadBook_TxtFile() throws Exception {
        String testFilePath = Paths.get(System.getProperty("user.dir"), 
                "test-flie", "斗破苍穹.txt").toString();
        File testFile = new File(testFilePath);

        if (!testFile.exists()) {
            System.out.println("测试文件不存在，跳过测试: " + testFilePath);
            return;
        }

        byte[] content = Files.readAllBytes(testFile.toPath());
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "斗破苍穹.txt",
                "text/plain",
                content
        );

        mockMvc.perform(multipart("/api/books/upload")
                        .file(file)
                        .param("title", "斗破苍穹")
                        .param("author", "天蚕土豆")
                        .param("adminId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.title").value("斗破苍穹"))
                .andExpect(jsonPath("$.data.author").value("天蚕土豆"));

        System.out.println("✓ TXT文件上传成功");
    }

    @Test
    @Order(2)
    @DisplayName("获取书籍列表")
    void listBooks() throws Exception {
        mockMvc.perform(get("/api/books")
                        .param("page", "1")
                        .param("size", "20"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());

        System.out.println("✓ 获取书籍列表成功");
    }

    @Test
    @Order(3)
    @DisplayName("搜索书籍")
    void searchBooks() throws Exception {
        mockMvc.perform(get("/api/books/search")
                        .param("keyword", "斗破")
                        .param("page", "1")
                        .param("size", "20"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());

        System.out.println("✓ 搜索书籍成功");
    }

    @Test
    @Order(4)
    @DisplayName("获取章节列表")
    void getChapters() throws Exception {
        if (uploadedBookId == null) {
            System.out.println("跳过测试：没有已上传的书籍");
            return;
        }

        mockMvc.perform(get("/api/books/" + uploadedBookId + "/chapters"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());

        System.out.println("✓ 获取章节列表成功");
    }

    @Test
    @Order(5)
    @DisplayName("获取章节内容")
    void getChapterContent() throws Exception {
        if (uploadedBookId == null) {
            System.out.println("跳过测试：没有已上传的书籍");
            return;
        }

        mockMvc.perform(get("/api/books/" + uploadedBookId + "/chapters/0"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.title").exists())
                .andExpect(jsonPath("$.data.content").exists());

        System.out.println("✓ 获取章节内容成功");
    }

    @Test
    @Order(6)
    @DisplayName("添加到书架")
    void addToShelf() throws Exception {
        if (uploadedBookId == null) {
            System.out.println("跳过测试：没有已上传的书籍");
            return;
        }

        mockMvc.perform(post("/api/reading/shelf")
                        .param("userId", "1")
                        .param("bookId", uploadedBookId.toString()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));

        System.out.println("✓ 添加到书架成功");
    }

    @Test
    @Order(7)
    @DisplayName("更新阅读进度")
    void updateProgress() throws Exception {
        if (uploadedBookId == null) {
            System.out.println("跳过测试：没有已上传的书籍");
            return;
        }

        String json = String.format(
                "{\"userId\":1,\"bookId\":%d,\"chapterIndex\":0,\"position\":100}",
                uploadedBookId
        );

        mockMvc.perform(put("/api/reading/progress")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));

        System.out.println("✓ 更新阅读进度成功");
    }

    @Test
    @Order(8)
    @DisplayName("获取用户书架")
    void getUserShelf() throws Exception {
        mockMvc.perform(get("/api/reading/shelf/1")
                        .param("page", "1")
                        .param("size", "20"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());

        System.out.println("✓ 获取用户书架成功");
    }
}
