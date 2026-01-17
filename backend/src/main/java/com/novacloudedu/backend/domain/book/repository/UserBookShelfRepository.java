package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.UserBookShelf;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface UserBookShelfRepository {

    UserBookShelf save(UserBookShelf shelf);

    Optional<UserBookShelf> findByUserIdAndBookId(UserId userId, BookId bookId);

    List<UserBookShelf> findByUserId(UserId userId, int page, int size);

    List<UserBookShelf> findByUserIdOrderByLastReadTime(UserId userId, int page, int size);

    long countByUserId(UserId userId);

    void delete(UserId userId, BookId bookId);
}
