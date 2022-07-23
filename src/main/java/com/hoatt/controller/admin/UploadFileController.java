package com.hoatt.controller.admin;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Controller
@RequestMapping(value = "uploadfile")
public class UploadFileController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String index(){
		return "upload";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public String index(@RequestParam(value="file") CommonsMultipartFile commonsMultipartFiles,HttpServletRequest request,ModelMap modelMap){
		String nameFile = commonsMultipartFiles.getOriginalFilename();
		System.out.println(nameFile);
		if(!"".equals(nameFile)){
			String dirFile = request.getServletContext().getRealPath("upload");
			System.out.println(dirFile);
			File fileDir = new File(dirFile);
			if(!fileDir.exists()){
				fileDir.mkdir();
			}
			try {
				commonsMultipartFiles.transferTo(new File(fileDir+File.separator+nameFile));
				System.out.println("Upload file thành công!");
				modelMap.addAttribute("filename", nameFile);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				System.out.println("Upload file thất bại!");
			}
		}
		return "upload";
	}
}
