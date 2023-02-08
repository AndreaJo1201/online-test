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
import goodee.gdj58.online.service.TeacherService;
import goodee.gdj58.online.vo.Teacher;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TeacherController {
	@Autowired
	private TeacherService teacherService;
	@Autowired
	private PageService pageService;
	
	//시험 등록 post
	@PostMapping("/teacher/test/addTest")
	public String getAddTest(@RequestParam(value="testTitle", defaultValue="", required = true) String testTitle
							, @RequestParam(value="testDate", defaultValue="", required = true) String testDate
							, @RequestParam(value="teacherNo", defaultValue="", required = true) int teacherNo
							, @RequestParam(value="questionTitle", defaultValue="", required = true) String[] questionTitle
							, @RequestParam(value="exampleTitle", defaultValue="", required = true) String[] exampleTitle
							, @RequestParam(value="exampleOx", defaultValue="", required = true) String[] exampleOx
							, @RequestParam(value="exampleCnt", defaultValue="", required = true) int[] exampleCnt) {
		/*
		Map<String,Object> test = new HashMap<String,Object>();
		test.put("testTitle", testTitle);
		test.put("testDate", testDate);
		test.put("testTeacher", teacherNo);
		
		List<Map<String,Object>> questionList = new ArrayList<Map<String,Object>>();
		
		int ox = 0; // exampleOx 시작 순서
		int cnt = 0; // exampleCnt
		
		for(int i=0; i<questionTitle.length; i++) {
			Map<String,Object> question = new HashMap<String,Object>();
			question.put("questionTitle", questionTitle[i]);
			question.put("questionIdx", i+1);
			
			List<Map<String, Object>> exampleList = new ArrayList<Map<String,Object>>();
			
			while(ox < exampleCnt[i]) {
				Map<String,Object> example = new HashMap<String,Object>();
				example.put("exampleTitle", exampleTitle[cnt]);
				example.put("exampleIdx", cnt+1);
				example.put("exampleOx", exampleOx[cnt]);
				
				cnt++;
				ox++;
				
				exampleList.add(example);
			}
			
			ox = 0;
			
			questionList.add(question);
		}
		
		test.put("questionList", questionList);
		*/
		int success = teacherService.addTest(testTitle, testDate, teacherNo, questionTitle, exampleTitle, exampleOx, exampleCnt);
		
		if(success == 0) {
			log.debug("시험추가 실패");
		}
		
		return "redirect:/teacher/testList";
	}
	
	//시험 등록 페이지 forward
	@GetMapping("/teacher/test/addTest")
	public String getAddTest() {
		return "teacher/test/addTest";
	}
	
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
		
		Map<String, Integer> paging = pageService.paging(listCnt, currentPage, rowPerPage);
		
		model.addAttribute("list", list);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("paging", paging);
		
		return "teacher/testList";
	}
	
	//강사 비밀번호 수정(post)
	@PostMapping("/teacher/modifyTeacherPw")
	public String modifyEmpPw(HttpSession session
							, @RequestParam(value="oldPw", required = true) String oldPw
							, @RequestParam(value="newPw", required = true) String newPw) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Teacher loginTeacher = (Teacher)session.getAttribute("loginTeacher");

		int teacherNo = loginTeacher.getTeacherNo();
		
		int row = teacherService.modifyTeacherPw(teacherNo, oldPw, newPw);
		if(row == 0) {
			System.out.println("UPDATE Password False... :(");
			return"redirect:/teacher/modifyTeacherPw";
		}
		
		System.out.println("UPDATE Password Success..! :D");
		return "redirect:/teacher/logout";
	}
	
	// 비밀번호 수정
	@GetMapping("/teacher/modifyTeacherPw")
	public String modifyTeacherPw() {
		return "/teacher/modifyTeacherPw";
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
