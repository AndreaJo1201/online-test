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

import goodee.gdj58.online.service.TeacherService;
import goodee.gdj58.online.vo.Teacher;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TeacherController {
	@Autowired
	private TeacherService teacherService;
	
	// 시험리스트 출력
	@GetMapping("/teacher/testList")
	public String getTestList(Model model
							, HttpSession session
							, @RequestParam(value="currentPage", defaultValue="1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
							, @RequestParam(value="searchWord", defaultValue="") String searchWord) {
		log.debug("\u001B[31m"+searchWord+" <-- searchWord"+"\u001B[0m");
		log.debug("\u001B[31m"+rowPerPage+" <-- rowPerPage"+"\u001B[0m");
		log.debug("\u001B[31m"+currentPage+" <-- currentPage"+"\u001B[0m");
		
		Teacher teacher = (Teacher)session.getAttribute("loginTeacher");
		List<Map<String,Object>> list = teacherService.getTestList(currentPage, rowPerPage, searchWord, teacher.getTeacherNo());
		
		int listCnt = teacherService.getTestListCnt(searchWord, teacher.getTeacherNo());
		
		Map<String, Integer> paging = teacherService.paging(listCnt, currentPage, rowPerPage);
		
		model.addAttribute("list", list);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("paging", paging);
		
		return "teacher/testList";
	}
	
	// 로그아웃
	@GetMapping("/teacher/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/teacher/loginTeacher";
	}
	
	/*
	 * 로그인 전 후 사용 가능한 기능
	 */
	
	// 로그인 페이지 forward
	@GetMapping("/loginTeacher")
	public String loginTeacher() {
		return "teacher/loginTeacher";
	}
	
	// 로그인 실행(post)
	@PostMapping("/loginTeacher")
	public String loginTeacher(HttpSession session, Teacher teacher) {
		
		Teacher resultTeacher = teacherService.login(teacher);
		if(resultTeacher == null) {
			System.out.println("Login False");
			return "redirect:/loginTeacher";
		}
		session.setAttribute("loginTeacher", resultTeacher);
		
		return "redirect:/teacher/testList";
	}
}
