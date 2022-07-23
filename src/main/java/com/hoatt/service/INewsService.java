package com.hoatt.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.hoatt.dto.NewsDTO;

public interface INewsService {
	List<NewsDTO> findAll(Pageable pageable);
	int getTotalItem();
	NewsDTO findById(long id);
	NewsDTO save(NewsDTO dto);
	void delete(long[] ids);
	List<NewsDTO> searchNews(String query);
}
