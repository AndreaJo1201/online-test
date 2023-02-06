package goodee.gdj58.online.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import goodee.gdj58.online.service.StudentService;
import goodee.gdj58.online.vo.Student;
// import lombok.extern.slf4j.Slf4j;

@Controller
// @Slf4j
public class StudentController {
	@Autowired
	private StudentService studentService;
	
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
		
		return "redirect:/student/studentTestList";
	}
}
