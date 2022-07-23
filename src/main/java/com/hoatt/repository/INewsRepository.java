package com.hoatt.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hoatt.entity.NewsEntity;

public interface INewsRepository extends JpaRepository<NewsEntity, Long> {
	@Query("SELECT n FROM NewsEntity n WHERE " +
            "n.title LIKE CONCAT('%',:query, '%')" +
            "OR n.shortDescription LIKE CONCAT('%', :query, '%')")
    List<NewsEntity> searchNews(@Param("query") String query);
}
