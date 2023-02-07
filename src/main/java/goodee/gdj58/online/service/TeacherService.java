package goodee.gdj58.online.service;

import java.util.ArrayList;
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
	public int addTest(String testTitle, String testDate, int teacherNo
						, String[] questionTitle, String[] exampleTitle, String[] exampleOx
						, int[] exampleCnt) {
		
		int row = 0;
		
		//정보 가공
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("testTitle", testTitle);
		paramMap.put("testDate", testDate);
		paramMap.put("teacherNo", teacherNo);
		
		List<Map<String,Object>> questionList = new ArrayList<Map<String,Object>>();
		
		int ox = 1; // exampleOx 시작 순서
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
			question.put("exampleList", exampleList);
			
			ox = 1;
			
			questionList.add(question);
		}
		
		paramMap.put("questionList", questionList);
		//정보가공 끝
		
		
		if(teacherMapper.insertTest(paramMap) != 0) {
			for(Map<String,Object> question : questionList) {
				// 
				// question.put("testNo", autoIncrement);
				if(teacherMapper.insertQuestion(question) != 0) {
					
					@SuppressWarnings("unchecked")
					List<Map<String,Object>> exampleList = (List<Map<String,Object>>) question.get("exampleList");
					for(Map<String,Object> example : exampleList) {
						//example.put("questionNo", autoIncrement);
						if(teacherMapper.insertExample(example) != 0) {
							row = 1;
						} else {
							return row;
						}
					}		
				}
			}
		}
		
		
		return row;
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
