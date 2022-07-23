package com.hoatt.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hoatt.entity.CategoryEntity;

public interface ICategoryReposiroty extends JpaRepository<CategoryEntity, Long> {
	CategoryEntity findOneByCode(String code);
}
