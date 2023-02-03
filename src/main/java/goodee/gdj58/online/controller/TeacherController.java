package goodee.gdj58.online.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import goodee.gdj58.online.service.TeacherService;
import goodee.gdj58.online.vo.Teacher;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TeacherController {
	@Autowired
	private TeacherService teacherService;
	
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
