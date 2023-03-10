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
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class StudentController {
	@Autowired
	private StudentService studentService;
	@Autowired
	private PageService pageService;
	
	// 학생 : 답안지 확인
	@GetMapping("/student/answerOne")
	public String answerOne(HttpSession session
						, Model model
						, @RequestParam(value="testNo") int testNo) {
		Student student = (Student) session.getAttribute("loginStudent");
		int studentNo = student.getStudentNo();
		
		Map<String,Object> answer = studentService.selectAnswerOne(testNo, studentNo);
		
		model.addAttribute("answer", answer);
		
		return "student/testOne";
	}
	
	// 학생 : 시험 응시 제출
	@PostMapping("/student/test/addPaper")
	public String addPaper(@RequestParam(value="studentNo") int studentNo
						, @RequestParam(value="questionNo") int[] questionNo
						, @RequestParam(value="answer") int[] answer) {
		
		studentService.insertPaper(studentNo, questionNo, answer);
		
		return "redirect:/student/testList/check";
	}
	
	// 학생 : 시험 응시 페이지 출력
	@GetMapping("/student/test/addPaper")
	public String getPaper(Model model
						, HttpSession session
						, @RequestParam(value="testNo", required = true) int testNo) {
		Map<String,Object> test = studentService.getTestOne(testNo);
		
		Student loginStudent = (Student) session.getAttribute("loginStudent");
		if(loginStudent == null) {
			return "redirect:/loginStudent";
		}
		
		model.addAttribute("test", test);
		model.addAttribute("studentNo", loginStudent.getStudentNo());
		
		return "student/paper/addPaper";
	}
	
	//학생 : 응시한 시험 목록 확인
	@GetMapping("/student/testList/check")
	public String getAnswerList(Model model
							, HttpSession session
							, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
							, @RequestParam(value="searchWord", defaultValue="") String searchWord
							, @RequestParam(value="searchCategory", defaultValue="ID") String searchCategory) {
		
		Student loginStudent = (Student) session.getAttribute("loginStudent");
		
		List<Map<String,Object>> list = studentService.getAnswerList(currentPage, rowPerPage, loginStudent.getStudentNo(), searchWord, searchCategory);
		
		Integer listCnt = studentService.getAnswerListCnt(loginStudent.getStudentNo(), searchWord, searchCategory);
		if(listCnt == null) {
			listCnt = 0;
		}
		Map<String,Integer> paging = pageService.paging(listCnt, currentPage, rowPerPage);
		
		model.addAttribute("list", list);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchCategory", searchCategory);
		model.addAttribute("paging", paging);
		
		return "student/testAnswerList";
	}
	
	@GetMapping("/student/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/student/loginStudent";
	}
	
	@PostMapping("/student/modifyStudentPw")
	public String modifyStudentPw(HttpSession session
								, @RequestParam(value="oldPw", required = true) String oldPw
								, @RequestParam(value="newPw", required = true) String newPw) {
		
		Student loginStudent = (Student)session.getAttribute("loginStudent");
		
		int studentNo = loginStudent.getStudentNo();
		
		int row = studentService.modifyStudentPw(studentNo, oldPw, newPw);
		if(row == 0) {
			log.debug("UPDATE Password False... :(");
			
			return"redirect:/student/modifyStudentPw";
		}
		
		log.debug("UPDATE Password Success..! :D");
		return "redirect:/student/logout";
	}
	
	@GetMapping("/student/modifyStudentPw")
	public String modifyStudentPw() {
		
		return "student/modifyStudentPw";
	}
	
	@GetMapping("/student/testList")
	public String getTestList(Model model
							, HttpSession session
							, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
							, @RequestParam(value="searchWord", defaultValue="") String searchWord
							, @RequestParam(value="searchCategory", defaultValue="ID") String searchCategory) {
		
		Student loginStudent = (Student) session.getAttribute("loginStudent");
		
		List<Map<String,Object>> list = studentService.getTestList(currentPage, rowPerPage, searchWord, searchCategory, loginStudent.getStudentNo());
		
		int listCnt = studentService.getTestListCnt(searchWord, searchCategory);
		
		Map<String,Integer> paging = pageService.paging(listCnt, currentPage, rowPerPage);
		
		
		model.addAttribute("loginStudent",loginStudent);
		model.addAttribute("list", list);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchCategory", searchCategory);
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
