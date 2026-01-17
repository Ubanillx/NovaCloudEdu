package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;
import com.novacloudedu.backend.infrastructure.persistence.converter.BookConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.BookMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.BookPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class BookRepositoryImpl implements BookRepository {

    private final BookMapper bookMapper;
    private final BookConverter bookConverter;

    @Override
    public Book save(Book book) {
        BookPO po = bookConverter.toBookPO(book);
        if (po.getId() == null) {
            bookMapper.insert(po);
            book.assignId(BookId.of(po.getId()));
        } else {
            bookMapper.updateById(po);
        }
        return book;
    }

    @Override
    public Optional<Book> findById(BookId id) {
        BookPO po = bookMapper.selectById(id.value());
        return Optional.ofNullable(po).map(bookConverter::toBook);
    }

    @Override
    public List<Book> findByStatus(BookStatus status, int page, int size) {
        Page<BookPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<BookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BookPO::getStatus, status.getCode())
                .orderByDesc(BookPO::getCreateTime);
        Page<BookPO> result = bookMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(bookConverter::toBook)
                .collect(Collectors.toList());
    }

    @Override
    public List<Book> findAll(int page, int size) {
        Page<BookPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<BookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(BookPO::getCreateTime);
        Page<BookPO> result = bookMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(bookConverter::toBook)
                .collect(Collectors.toList());
    }

    @Override
    public List<Book> searchByKeyword(String keyword, int page, int size) {
        Page<BookPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<BookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w.like(BookPO::getTitle, keyword)
                        .or()
                        .like(BookPO::getAuthor, keyword))
                .orderByDesc(BookPO::getCreateTime);
        Page<BookPO> result = bookMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(bookConverter::toBook)
                .collect(Collectors.toList());
    }

    @Override
    public long count() {
        return bookMapper.selectCount(null);
    }

    @Override
    public long countByStatus(BookStatus status) {
        LambdaQueryWrapper<BookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BookPO::getStatus, status.getCode());
        return bookMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(BookId id) {
        bookMapper.deleteById(id.value());
    }
}
