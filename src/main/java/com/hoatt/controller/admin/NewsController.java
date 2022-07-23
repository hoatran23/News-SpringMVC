package com.hoatt.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hoatt.dto.NewsDTO;
import com.hoatt.service.ICategoryService;
import com.hoatt.service.INewsService;
import com.hoatt.utils.MessageUtils;

@Controller(value = "newsControllerOfAdmin")
public class NewsController {
	
	@Autowired
	private INewsService newsService;
	
	@Autowired
	private MessageUtils messageUtils;
	
	@Autowired
	private ICategoryService categoryService;
	
	@RequestMapping(value = "/admin-news/list", method = RequestMethod.GET)
	public ModelAndView showList(@RequestParam("page") int currentPage, 
								 @RequestParam("limit") int limit, 
								 HttpServletRequest request) {
		NewsDTO newsDTO = new NewsDTO();
		newsDTO.setCurrentPage(currentPage);
		newsDTO.setLimit(limit);
		ModelAndView mav = new ModelAndView("admin/news/list");
		Pageable pageable = new PageRequest(currentPage - 1, limit);
		newsDTO.setListResult(newsService.findAll(pageable));
		newsDTO.setTotalItem(newsService.getTotalItem());
		newsDTO.setTotalPage((int) Math.ceil((double) newsDTO.getTotalItem() / newsDTO.getLimit()));
		if (request.getParameter("message") != null) {
			Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
			mav.addObject("message", message.get("message"));
			mav.addObject("alert", message.get("alert"));
		}
		mav.addObject("newsDTO", newsDTO);
		return mav;
	}
	
	@RequestMapping(value = "/admin-news/edit", method = RequestMethod.GET)
	public ModelAndView editNews(@RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/news/edit");
		NewsDTO newsDTO = new NewsDTO();
		if (id != null) {
			newsDTO = newsService.findById(id);
		}
		if (request.getParameter("message") != null) {
			Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
			mav.addObject("message", message.get("message"));
			mav.addObject("alert", message.get("alert"));
		}
		mav.addObject("categories", categoryService.findAll());
		mav.addObject("newsDTO", newsDTO);
		return mav;
	}
	
	@RequestMapping(value = "/admin-news/search", method = RequestMethod.GET) 
	public ModelAndView searchNews(@RequestParam(value = "keyword") String keyword) {
		ModelAndView mav = new ModelAndView("admin/news/search");
		List<NewsDTO> newsDTOs = new ArrayList<>();
		NewsDTO newsDTO = new NewsDTO();
		if (keyword != null) {
			newsDTOs = newsService.searchNews(keyword);
			newsDTO.setListResult(newsDTOs);
		}
		mav.addObject("newsDTO", newsDTO);
		return mav;
	}
	
	@RequestMapping(value = "/admin-news/detail", method = RequestMethod.GET) 
	public ModelAndView getNewsDetail(@RequestParam(value = "id") Long id) {
		ModelAndView mav = new ModelAndView("admin/news/detail");
		NewsDTO newsDTO = new NewsDTO();
		if (id != null) {
			newsDTO = newsService.findById(id);
		}
		mav.addObject("categories", categoryService.findAll());
		mav.addObject("newsDTO", newsDTO);
		return mav;
	}
}
