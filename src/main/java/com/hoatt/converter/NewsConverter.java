package com.hoatt.converter;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.hoatt.dto.NewsDTO;
import com.hoatt.entity.NewsEntity;
import com.hoatt.model.NewsModel;
import com.hoatt.repository.ICategoryReposiroty;

@Component
public class NewsConverter {
	
	@Autowired
	private ModelMapper modelMapper;
	
	@Autowired
	private ICategoryReposiroty categoryRepository;
	
	public NewsEntity convertModelToEntity(NewsModel newsModel) {
		NewsEntity newsEntity = new NewsEntity();
		newsEntity = modelMapper.map(newsModel, NewsEntity.class);
		newsEntity.setCategoryEntity(categoryRepository.findOneByCode(newsModel.getCategoryCode()));
		return newsEntity;
	}
	
	public NewsModel convertEntityToModel(NewsEntity newsEntity) {
		NewsModel newsModel = new NewsModel();
		newsModel = modelMapper.map(newsEntity, NewsModel.class);
		newsModel.setCategoryCode(newsEntity.getCategoryEntity().getCode());
		return newsModel;
	}
	
	public NewsEntity convertEntityToEntity(NewsEntity newsEntity, NewsEntity newsEntity2) {
		newsEntity.setCreatedBy(newsEntity2.getCreatedBy());
		newsEntity.setCreatedDate(newsEntity2.getCreatedDate());
		return newsEntity;
	}
	
	public NewsEntity convertDTOToEntity(NewsDTO newsDTO) {
		NewsEntity newsEntity = new NewsEntity();
		newsEntity = modelMapper.map(newsDTO, NewsEntity.class);
		newsEntity.setCategoryEntity(categoryRepository.findOneByCode(newsDTO.getCategoryCode()));
		return newsEntity;
	}
	
	public NewsDTO convertEntityToDTO(NewsEntity newsEntity) {
		NewsDTO newsDTO = new NewsDTO();
		newsDTO = modelMapper.map(newsEntity, NewsDTO.class);
		newsDTO.setCategoryCode(newsEntity.getCategoryEntity().getCode());
		return newsDTO;
	}
}
