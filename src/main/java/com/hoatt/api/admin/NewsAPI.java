package com.hoatt.api.admin;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hoatt.dto.NewsDTO;
import com.hoatt.service.INewsService;

@RestController(value = "newsAPIOfAdmin")
@RequestMapping("/api/news")
public class NewsAPI {

	@Autowired
	private INewsService newsService;
	
	@Autowired
	ServletContext context;
	
	@GetMapping
	public NewsDTO getNews(@RequestParam(value = "page", required = false) Integer currentPage, 
							@RequestParam(value = "limit", required = false) Integer limit) {
		NewsDTO newsDTO = new NewsDTO();
		if (currentPage != null && limit != null) {
			newsDTO.setCurrentPage(currentPage);
			newsDTO.setTotalPage((int) Math.ceil(newsService.getTotalItem() / limit));
			Pageable pageable = new PageRequest(currentPage - 1, limit);
			newsDTO.setListResult(newsService.findAll(pageable));
		}
		return newsDTO;
	}
	
	@PostMapping
	public NewsDTO createNews(@RequestBody NewsDTO newsDTO) {
		return newsService.save(newsDTO);
	}
	
	@PutMapping
	public NewsDTO updateNews(@RequestBody NewsDTO newsDTO) {
		return newsService.save(newsDTO);
	}
	
	@DeleteMapping
	public void deleteNews(@RequestBody long[] ids) {
		newsService.delete(ids);
	}
	
	@GetMapping("/detail")
	public NewsDTO getDetailNews(@RequestParam(value = "id") Long id) {
		NewsDTO newsDTO = new NewsDTO();
		if (id != null) {
			newsDTO = newsService.findById(id);
		}
		return newsDTO;
	}
	
	@GetMapping("/search")
	public List<NewsDTO> searchNews(@RequestParam(value = "query") String query) {
		return newsService.searchNews(query);
	}
	
}
