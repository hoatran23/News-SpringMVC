package com.hoatt.converter;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.hoatt.dto.CategoryDTO;
import com.hoatt.entity.CategoryEntity;

@Component
public class CategoryConverter {
	
	@Autowired
	private ModelMapper modelMapper;
	
	public CategoryEntity convertDTOToEntity(CategoryDTO categoryDTO) {
		CategoryEntity categoryEntity = modelMapper.map(categoryDTO, CategoryEntity.class);
		return categoryEntity;
	}
	
	public CategoryDTO convertEntityToDTO(CategoryEntity categoryEntity) {
		CategoryDTO categoryDTO = modelMapper.map(categoryEntity, CategoryDTO.class);
		return categoryDTO;
	}
}	
