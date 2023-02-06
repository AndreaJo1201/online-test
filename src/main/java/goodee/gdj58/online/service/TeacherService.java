package goodee.gdj58.online.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.TeacherMapper;
import goodee.gdj58.online.vo.Teacher;

@Service
@Transactional
public class TeacherService {
	@Autowired
	private TeacherMapper teacherMapper;
	
	// 강사 : 시험 추가
	public int addTest(int teacherNo, String testTitle, String testDate) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("teacherNo", teacherNo);
		paramMap.put("testTitle", testTitle);
		paramMap.put("testDate", testDate);
		
		return teacherMapper.insertTest(paramMap);
	}
	
	// 강사 : 시험리스트 count
	public int getTestListCnt(String searchWord, int teacherNo) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("searchWord", searchWord);
		paramMap.put("teacherNo", teacherNo);
		return teacherMapper.selectTestListCnt(paramMap);
	}
	
	
	// 강사 : 시험리스트 불러오기
	public List<Map<String, Object>> getTestList(int currentPage, int rowPerPage, String searchWord, int teacherNo) {
		int beginRow = (currentPage - 1) * rowPerPage;
		
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("currentPage", currentPage);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		paramMap.put("teacherNo", teacherNo);
		
		return teacherMapper.selectTestList(paramMap);
	}
	
	// 강사 : 비밀번호 수정
	public int modifyTeacherPw(int empNo, String oldPw, String newPw) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empNo", empNo);
		paramMap.put("oldPw", oldPw);
		paramMap.put("newPw", newPw);
		return teacherMapper.updateTeacherPw(paramMap);
	}
	
	// 강사 : 로그인
	public Teacher login(Teacher teacher) {
		return teacherMapper.login(teacher);
	}
	
	// 사원 : 강사 삭제
	public int removeTeacher(int teacherNo) {
		return teacherMapper.deleteTeacher(teacherNo);
	}
	
	// 사원 : 강사 추가
	public int addTeacher(Teacher teacher) {
		return teacherMapper.insertTeacher(teacher);
	}
	
	// 사원 : 강사리스트 count
	public int getTeacherListCnt(String searchWord) {
		return teacherMapper.selectTeacherListCnt(searchWord);
	}
	
	// 사원 : 강사리스트 불러오기
	public List<Teacher> getTeacherList(int currentPage, int rowPerPage, String searchWord, String searchCategory) {
		int beginRow = (currentPage-1)*rowPerPage;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		paramMap.put("serachCategory", searchCategory);
		return teacherMapper.selectTeacherList(paramMap);
	}
}
