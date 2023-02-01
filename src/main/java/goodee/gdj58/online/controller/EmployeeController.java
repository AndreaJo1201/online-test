package goodee.gdj58.online.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import goodee.gdj58.online.service.EmployeeService;
import goodee.gdj58.online.service.IdService;
import goodee.gdj58.online.service.StudentService;
import goodee.gdj58.online.service.TeacherService;
import goodee.gdj58.online.vo.Employee;
import goodee.gdj58.online.vo.Student;
import goodee.gdj58.online.vo.Teacher;

@Controller
public class EmployeeController {
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private IdService idService;
	@Autowired
	private TeacherService teacherService;
	@Autowired
	private StudentService studentService;
	
	// 로그인 화면 출력
	@GetMapping("/employee/loginEmp")
	public String loginEmp(HttpSession session) {
		
		// 이미 login 상태라면 redirect:/employee/empList
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp != null) {
			return "redirect:/employee/empList";
		}
		return "employee/loginEmp";
	}
	
	// 로그인 실행(post)
	@PostMapping("/employee/loginEmp")
	public String loginEmp(HttpSession session, Employee employee) {
		
		// 이미 login 상태라면 redirect:/employee/empList
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp != null) {
			return "redirect:/employee/empList";
		}
		
		Employee resultEmp = employeeService.login(employee);
		if(resultEmp == null) {
			System.out.println("Login False");
			return "redirect:/employee/loginEmp";
		}
		session.setAttribute("loginEmp", resultEmp);
		
		return "redirect:/employee/empList";
	}
	
	/*
	 *  로그인 후에 사용가능한 기능
	 */
	
	// 학생 삭제(forward)
	@GetMapping("/employee/student/removeStudent")
	public String removeStudent(HttpSession session, @RequestParam("studentNo") int studentNo) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		studentService.removeStudent(studentNo);
		return "redirect:/employee/student/studentList";
	}
	
	// 학생 등록(post)
	@PostMapping("/employee/student/addStudent")
	public String addTeacher(HttpSession session, Model model, Student student) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		
		String idCheck = idService.getIdCheck(student.getStudentId());
		if(idCheck != null) {
			System.out.println("ID NOT NULL, ADD EMPLOYEE FALSE... :(");
			String errorMsg = "ID중복입니다.";
			model.addAttribute("errorMsg",errorMsg);
			return "employee/student/addStudent";
		}
		
		int row = studentService.addStudent(student);
		if(row == 0) {
			System.out.println("addTeacher False... :(");
			String errorMsg = "등록실패";
			model.addAttribute("errorMsg",errorMsg);
			return "employee/student/addStudent";
		}
		// row == 1 이면 입력성공
		return "redirect:/employee/student/studentList";
	}
	
	// 학생 등록(forward)
	@GetMapping("employee/student/addStudent")
	public String addStudent(HttpSession session) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		return "employee/student/addStudent";
	}
	
	// 학생 리스트(forward)
	@GetMapping("employee/student/studentList")
	public String studentList(HttpSession session 
							, Model model
							, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		
		List<Student> list = studentService.getStudentList(currentPage, rowPerPage);
		// request.setAttribute("list", list);
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		return "employee/student/studentList";
	}
	
	//강사 삭제(forward)
	@GetMapping("/employee/teacher/removeTeacher")
	public String removeTeacher(HttpSession session, @RequestParam("teacherNo") int teacherNo) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		teacherService.removeTeacher(teacherNo);
		return "redirect:/employee/teacher/teacherList";
	}
	
	//강사 등록(post)
	@PostMapping("/employee/teacher/addTeacher")
	public String addTeacher(HttpSession session, Model model, Teacher teacher) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		
		String idCheck = idService.getIdCheck(teacher.getTeacherId());
		if(idCheck != null) {
			System.out.println("ID NOT NULL, ADD EMPLOYEE FALSE... :(");
			String errorMsg = "ID중복입니다.";
			model.addAttribute("errorMsg",errorMsg);
			return "employee/teacher/addTeacher";
		}
		
		int row = teacherService.addTeacher(teacher);
		if(row == 0) {
			System.out.println("addTeacher False... :(");
			String errorMsg = "등록실패";
			model.addAttribute("errorMsg",errorMsg);
			return "employee/teacher/addTeacher";
		}
		// row == 1 이면 입력성공
		return "redirect:/employee/teacher/teacherList";
	}
	
	
	//강사 등록(forward)
	@GetMapping("employee/teacher/addTeacher")
	public String addTeacher(HttpSession session) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		return "employee/teacher/addTeacher";
	}
	
	//강사 리스트 출력(forward)
	@GetMapping("employee/teacher/teacherList")
	public String teacherList(HttpSession session 
							, Model model
							, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		
		List<Teacher> list = teacherService.getTeacherList(currentPage, rowPerPage);
		// request.setAttribute("list", list);
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		return "employee/teacher/teacherList";
	}
	
	// 사원 비밀번호 수정(forward)
	@GetMapping("/employee/modifyEmpPw")
	public String modifyEmpPw(HttpSession session) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		
		return "employee/modifyEmpPw";
	}
	
	//사원 비밀번호 수정(post)
	@PostMapping("/employee/modifyEmpPw")
	public String modifyEmpPw(HttpSession session
							, @RequestParam(value="oldPw", required = true) String oldPw
							, @RequestParam(value="newPw", required = true) String newPw) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		int empNo = loginEmp.getEmpNo();
		
		int row = employeeService.modifyEmployeePw(empNo, oldPw, newPw);
		if(row == 0) {
			System.out.println("UPDATE Password False... :(");
			return"redirect:/employee/modifyEmpPw";
		}
		
		System.out.println("UPDATE Password Success..! :D");
		return "redirect:/employee/logout";
	}
	
	// 로그아웃
	@GetMapping("/employee/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/employee/loginEmp";
	}
	
	// 사원 삭제(forward)
	@GetMapping("/employee/removeEmp")
	public String removeEmp(HttpSession session, @RequestParam("empNo") int empNo) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		employeeService.removeEmployee(empNo);
		return "redirect:/employee/empList";
	}
	
	// 사원 입력(forward)
	@GetMapping("/employee/addEmp")
	public String addEmp(HttpSession session) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		return "employee/addEmp";
	}
	
	// 사원 입력(post -> redirect)
	@PostMapping("/employee/addEmp")
	public String addEmp(HttpSession session, Model model, Employee employee) {
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		
		String idCheck = idService.getIdCheck(employee.getEmpId());
		if(idCheck != null) {
			System.out.println("ID NOT NULL, ADD EMPLOYEE FALSE... :(");
			String errorMsg = "ID중복입니다.";
			model.addAttribute("errorMsg",errorMsg);
			return "employee/addEmp";
		}
		
		int row = employeeService.addEmployee(employee);
		if(row == 0) {
			System.out.println("addEmployee False... :(");
			String errorMsg = "등록실패";
			model.addAttribute("errorMsg",errorMsg);
			return "employee/addEmp";
		}
		// row == 1 이면 입력성공
		return "redirect:/employee/empList";
	}
	
	// 사원 리스트 출력(forward)
	@GetMapping("/employee/empList")
	public String empList(HttpSession session
							, Model model
							, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage) { 
							// int currentPage = reuqest.getParamenter("currentPage");
		
		// login 상태가 아니라면 redirect:/employee/loginEmp
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			return "redirect:/employee/loginEmp";
		}
		
		List<Employee> list = employeeService.getEmployeeList(currentPage, rowPerPage);
		// request.setAttribute("list", list);
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		return "employee/empList";
	}
}
