package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;

import java.util.List;
import java.util.Optional;

public interface BookRepository {

    Book save(Book book);

    Optional<Book> findById(BookId id);

    List<Book> findByStatus(BookStatus status, int page, int size);

    List<Book> findAll(int page, int size);

    List<Book> searchByKeyword(String keyword, int page, int size);

    long count();

    long countByStatus(BookStatus status);

    void deleteById(BookId id);
}
