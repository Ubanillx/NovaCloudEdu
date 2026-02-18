package com.novacloudedu.backend.book;

import com.novacloudedu.backend.application.book.command.UpdateReadingProgressCommand;
import com.novacloudedu.backend.application.service.ReadingProgressApplicationService;
import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.entity.UserBookShelf;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.UserBookShelfRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@DisplayName("并发阅读测试")
class ConcurrentReadingTest {

    @Mock
    private UserBookShelfRepository userBookShelfRepository;

    @Mock
    private BookRepository bookRepository;

    @InjectMocks
    private ReadingProgressApplicationService readingProgressApplicationService;

    private Book createReadyBook(Long id) {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                null,
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );
        book.assignId(BookId.of(id));
        book.startParsing();
        book.completeProcessing(100, 500000);
        return book;
    }

    @Test
    @Order(1)
    @DisplayName("并发更新阅读进度 - 单用户多线程")
    void testConcurrentProgressUpdate_SingleUser() throws InterruptedException {
        Book book = createReadyBook(1L);
        UserBookShelf shelf = UserBookShelf.create(UserId.of(1L), BookId.of(1L));

        when(bookRepository.findById(BookId.of(1L))).thenReturn(Optional.of(book));
        when(userBookShelfRepository.findByUserIdAndBookId(any(), any())).thenReturn(Optional.of(shelf));
        when(userBookShelfRepository.save(any())).thenAnswer(invocation -> invocation.getArgument(0));

        int threadCount = 10;
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        CountDownLatch latch = new CountDownLatch(threadCount);
        AtomicInteger successCount = new AtomicInteger(0);
        AtomicInteger failureCount = new AtomicInteger(0);

        for (int i = 0; i < threadCount; i++) {
            final int chapterIndex = i;
            executor.submit(() -> {
                try {
                    UpdateReadingProgressCommand command = new UpdateReadingProgressCommand();
                    command.setUserId(1L);
                    command.setBookId(1L);
                    command.setChapterIndex(chapterIndex);
                    command.setPosition(100 * chapterIndex);

                    readingProgressApplicationService.updateProgress(command);
                    successCount.incrementAndGet();
                } catch (Exception e) {
                    failureCount.incrementAndGet();
                    System.err.println("线程执行失败: " + e.getMessage());
                } finally {
                    latch.countDown();
                }
            });
        }

        boolean completed = latch.await(30, TimeUnit.SECONDS);
        executor.shutdown();

        System.out.println("=== 并发更新测试结果 ===");
        System.out.println("总线程数: " + threadCount);
        System.out.println("成功: " + successCount.get());
        System.out.println("失败: " + failureCount.get());

        assertTrue(completed, "测试超时");
        assertTrue(successCount.get() > 0, "至少应有部分请求成功");
    }

    @Test
    @Order(2)
    @DisplayName("并发添加书架 - 多用户")
    void testConcurrentAddToShelf_MultipleUsers() throws InterruptedException {
        Book book = createReadyBook(1L);

        when(bookRepository.findById(BookId.of(1L))).thenReturn(Optional.of(book));
        when(userBookShelfRepository.findByUserIdAndBookId(any(), any())).thenReturn(Optional.empty());
        when(userBookShelfRepository.save(any())).thenAnswer(invocation -> invocation.getArgument(0));

        int userCount = 20;
        ExecutorService executor = Executors.newFixedThreadPool(userCount);
        CountDownLatch latch = new CountDownLatch(userCount);
        AtomicInteger successCount = new AtomicInteger(0);

        for (int i = 0; i < userCount; i++) {
            final long userId = i + 1;
            executor.submit(() -> {
                try {
                    readingProgressApplicationService.addToShelf(userId, 1L);
                    successCount.incrementAndGet();
                } catch (Exception e) {
                    System.err.println("用户 " + userId + " 添加失败: " + e.getMessage());
                } finally {
                    latch.countDown();
                }
            });
        }

        boolean completed = latch.await(30, TimeUnit.SECONDS);
        executor.shutdown();

        System.out.println("=== 并发添加书架测试结果 ===");
        System.out.println("总用户数: " + userCount);
        System.out.println("成功添加: " + successCount.get());

        assertTrue(completed, "测试超时");
        assertEquals(userCount, successCount.get(), "所有用户都应成功添加");
    }

    @Test
    @Order(3)
    @DisplayName("高并发压力测试")
    void testHighConcurrencyStress() throws InterruptedException {
        Book book = createReadyBook(1L);

        when(bookRepository.findById(BookId.of(1L))).thenReturn(Optional.of(book));
        when(userBookShelfRepository.findByUserIdAndBookId(any(), any()))
                .thenAnswer(invocation -> Optional.of(UserBookShelf.create(
                        invocation.getArgument(0), 
                        invocation.getArgument(1)
                )));
        when(userBookShelfRepository.save(any())).thenAnswer(invocation -> invocation.getArgument(0));

        int requestCount = 100;
        ExecutorService executor = Executors.newFixedThreadPool(20);
        CountDownLatch latch = new CountDownLatch(requestCount);
        AtomicInteger successCount = new AtomicInteger(0);
        List<Long> responseTimes = new CopyOnWriteArrayList<>();

        long startTime = System.currentTimeMillis();

        for (int i = 0; i < requestCount; i++) {
            final int index = i;
            executor.submit(() -> {
                try {
                    long reqStart = System.nanoTime();
                    
                    UpdateReadingProgressCommand command = new UpdateReadingProgressCommand();
                    command.setUserId((long) (index % 10 + 1));
                    command.setBookId(1L);
                    command.setChapterIndex(index % 100);
                    command.setPosition(index * 100);

                    readingProgressApplicationService.updateProgress(command);
                    
                    long reqEnd = System.nanoTime();
                    responseTimes.add((reqEnd - reqStart) / 1000000); // 转换为毫秒
                    
                    successCount.incrementAndGet();
                } catch (Exception e) {
                    System.err.println("请求失败: " + e.getMessage());
                } finally {
                    latch.countDown();
                }
            });
        }

        boolean completed = latch.await(60, TimeUnit.SECONDS);
        executor.shutdown();
        
        long endTime = System.currentTimeMillis();
        long totalTime = endTime - startTime;

        System.out.println("=== 高并发压力测试结果 ===");
        System.out.println("总请求数: " + requestCount);
        System.out.println("成功请求: " + successCount.get());
        System.out.println("总耗时: " + totalTime + " ms");
        System.out.println("平均响应时间: " + (responseTimes.stream().mapToLong(Long::longValue).average().orElse(0)) + " ms");
        System.out.println("最大响应时间: " + (responseTimes.stream().mapToLong(Long::longValue).max().orElse(0)) + " ms");
        System.out.println("最小响应时间: " + (responseTimes.stream().mapToLong(Long::longValue).min().orElse(0)) + " ms");
        System.out.println("吞吐量: " + (successCount.get() * 1000.0 / totalTime) + " req/s");

        assertTrue(completed, "测试超时");
        assertTrue(successCount.get() > requestCount * 0.95, "成功率应大于95%");
    }
}
