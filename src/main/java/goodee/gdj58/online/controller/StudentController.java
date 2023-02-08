package goodee.gdj58.online.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import goodee.gdj58.online.service.PageService;
import goodee.gdj58.online.service.StudentService;
import goodee.gdj58.online.vo.Student;
// import lombok.extern.slf4j.Slf4j;

@Controller
// @Slf4j
public class StudentController {
	@Autowired
	private StudentService studentService;
	@Autowired
	private PageService pageService;
	
	@GetMapping("/student/testList")
	public String getTestList(Model model
							, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
							, @RequestParam(value="searchWord", defaultValue="") String searchWord
							, @RequestParam(value="searchCategory", defaultValue="ID") String searchCategory) {
		
		List<Map<String,Object>> list = studentService.getTestList(currentPage, rowPerPage, searchWord, searchCategory);
		
		int listCnt = studentService.getTestListCnt(searchWord, searchCategory);
		
		Map<String,Integer> paging = pageService.paging(listCnt, currentPage, rowPerPage);
		
		model.addAttribute("list", list);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("paging", paging);
		
		return "student/studentTestList";
	}
	
	@GetMapping("/loginStudent")
	public String loginTeacher() {
		return "student/loginStudent";
	}
	
	// 로그인 실행(post)
	@PostMapping("/loginStudent")
	public String loginStudent(HttpSession session, Student student) {
		
		Student resultStudent = studentService.login(student);
		if(resultStudent == null) {
			System.out.println("Login False");
			return "redirect:/loginStudent";
		}
		session.setAttribute("loginStudent", resultStudent);
		
		return "redirect:/student/testList";
	}
}
