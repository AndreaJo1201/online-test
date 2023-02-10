package goodee.gdj58.online.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.StudentMapper;
import goodee.gdj58.online.mapper.TeacherMapper;
import goodee.gdj58.online.vo.Student;

@Service
@Transactional
public class StudentService {
	@Autowired
	private StudentMapper studentMapper;
	@Autowired
	private TeacherMapper teacherMapper;
	
	public int insertPaper(int studentNo, int[] questionNo, int[] answer) {
		
		for(int i=0; i<questionNo.length; i++) {
			Map<String,Object> paper = new HashMap<String,Object>();
			paper.put("studentNo", studentNo);
			paper.put("questionNo", questionNo[i]);
			paper.put("answer", answer[i]);
			
			if(studentMapper.insertPaper(paper) == 0) {
				return 1;
			}
		}
		
		return 0;
	}
	
	public Map<String,Object> getTestOne(int testNo) {
		Map<String,Object> test = teacherMapper.selectTest(testNo);
		
		List<Map<String,Object>> questionList = teacherMapper.selectQuestion(testNo);
		for(Map<String,Object> question : questionList) {
			List<Map<String,Object>> example = studentMapper.selectExample((int)question.get("questionNo"));
			question.put("example", example);
		}
		
		test.put("questionList", questionList);
		
		return test;
	}
	
	public int getAnswerListCnt(int studentNo, String searchWord, String searchCategory) {
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("studentNo", studentNo);
		paramMap.put("searchWord", searchWord);
		paramMap.put("searchCategory", searchCategory);
		
		return studentMapper.selectAnswerListCnt(paramMap);
	}
	
	public List<Map<String,Object>> getAnswerList(int currentPage, int rowPerPage, int studentNo, String searchWord, String searchCategory) {
		int beginRow = (currentPage-1) * rowPerPage;
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("studentNo", studentNo);
		paramMap.put("searchWord", searchWord);
		paramMap.put("searchCategory", searchCategory);
		
		return studentMapper.selectAnswerList(paramMap);
	}
	
	public int getTestListCnt(String searchWord, String searchCategory) {
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("searchWord", searchWord);
		paramMap.put("searchCategory", searchCategory);
		
		return studentMapper.selectTestListCnt(paramMap);
	}
	
	public List<Map<String,Object>> getTestList(int currentPage, int rowPerPage, String searchWord, String searchCategory) {
		int beginRow = (currentPage-1) * rowPerPage;
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		paramMap.put("searchCategory", searchCategory);
		
		return studentMapper.selectTestList(paramMap);
	}
	
	public int modifyStudentPw(int empNo, String oldPw, String newPw) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empNo", empNo);
		paramMap.put("oldPw", oldPw);
		paramMap.put("newPw", newPw);
		return studentMapper.updateStudentPw(paramMap);
	}
	
	public Student login(Student student) {
		return studentMapper.login(student);
	}
	
	public int removeStudent(int studentNo) {
		return studentMapper.deleteStudent(studentNo);
	}
	
	public int addStudent(Student student) {
		return studentMapper.insertStudent(student);
	}
	
	public int getStudentListCnt(String searchWord, String searchCategory) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("searchWord", searchWord);
		paramMap.put("searchCategory", searchCategory);
		
		return studentMapper.selectStudentListCnt(paramMap);
	}
	
	public List<Student> getStudentList(int currentPage, int rowPerPage, String searchWord, String searchCategory) {
		int beginRow = (currentPage-1)*rowPerPage;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		paramMap.put("searchCategory", searchCategory);
		return studentMapper.selectStudentList(paramMap);
	}
}
