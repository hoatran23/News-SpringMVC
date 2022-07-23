package com.hoatt.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hoatt.converter.NewsConverter;
import com.hoatt.dto.NewsDTO;
import com.hoatt.entity.NewsEntity;
import com.hoatt.repository.INewsRepository;
import com.hoatt.service.INewsService;

@Service
public class NewsServiceImpl implements INewsService{
	
	@Autowired
	private NewsConverter newsConverter;
	
	@Autowired
	private INewsRepository newsRepository;
	
	@Override
	public List<NewsDTO> findAll(Pageable pageable) {
		List<NewsDTO> newsDTOs = new ArrayList<>();
		List<NewsEntity> newsEntities = newsRepository.findAll(pageable).getContent();
		for (NewsEntity item: newsEntities) {
			NewsDTO newsDTO = newsConverter.convertEntityToDTO(item);
			newsDTOs.add(newsDTO);
		}
		return newsDTOs;
	}
	
	@Override
	public int getTotalItem() {
		return (int) newsRepository.count();
	}
	
	@Override
	public NewsDTO findById(long id) {
		NewsEntity entity = newsRepository.findOne(id);
		return newsConverter.convertEntityToDTO(entity);
	}
	
	@Override
	@Transactional
	public NewsDTO save(NewsDTO newsDTO) {
		NewsEntity newsEntity = new NewsEntity();
		if (newsDTO.getId() != null) {
			NewsEntity newsEntityOld = newsRepository.findOne(newsDTO.getId());
			newsEntity = newsConverter.convertDTOToEntity(newsDTO); 
			newsEntity = newsConverter.convertEntityToEntity(newsEntity, newsEntityOld);
		} else {
			newsEntity = newsConverter.convertDTOToEntity(newsDTO);
		}
		newsEntity = newsRepository.save(newsEntity);
		return newsConverter.convertEntityToDTO(newsEntity);
	}

	@Override
	@Transactional
	public void delete(long[] ids) {
		for (long id: ids) {
			newsRepository.delete(id);
		}
	}

	@Override
	public List<NewsDTO> searchNews(String query) {
		List<NewsDTO> newsDTOs = new ArrayList<>();
		List<NewsEntity> newsEntities = newsRepository.searchNews(query);
		for (NewsEntity newsEntity : newsEntities) {
			NewsDTO newsDTO = newsConverter.convertEntityToDTO(newsEntity);
			newsDTOs.add(newsDTO);
		}
		return newsDTOs;
	}
	
}
