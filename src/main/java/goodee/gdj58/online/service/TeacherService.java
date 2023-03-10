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
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class TeacherService {
	@Autowired
	private TeacherMapper teacherMapper;
	
	
	// 강사 : 시험 응시한 사람 확인
	public Integer selectTestByAnswer(int testNo) {
		return teacherMapper.selectTestByAnswer(testNo);
	}
	
	// 강사 : 시험 수정하기
	@SuppressWarnings("unchecked")
	public int modifyTest(String testTitle, int testNo, String testDate, int teacherNo
						, String[] questionTitle
						, String[] exampleTitle, String[] exampleOx, int[] exampleCnt) {
		
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("testTitle", testTitle);
		paramMap.put("testNo", testNo);
		paramMap.put("testDate", testDate);
		paramMap.put("teacherNo", teacherNo);
		
		List<Map<String,Object>> questionList = new ArrayList<Map<String,Object>>();
		
		int idx = 0; // exampleOx 시작 순서
		int cnt = 0; // exampleCnt
		
		for(int i=0; i<questionTitle.length; i++) {
			Map<String,Object> question = new HashMap<String,Object>();
			question.put("questionTitle", questionTitle[i]);
			question.put("questionIdx", i+1);

			
			List<Map<String, Object>> exampleList = new ArrayList<Map<String,Object>>();
			while(idx < exampleCnt[i]) {
				Map<String,Object> example = new HashMap<String,Object>();
				example.put("exampleTitle", exampleTitle[cnt]);
				example.put("exampleIdx", idx+1);
				example.put("exampleOx", exampleOx[cnt]);
				
				cnt += 1;
				idx += 1;
				
				exampleList.add(example);
			}
			question.put("exampleList", exampleList);
			
			idx = 0;
			
			questionList.add(question);
		}
		
		paramMap.put("questionList", questionList);
		
		//정보 가공 끝
		
		if(teacherMapper.updateTest(paramMap) != 0) {
			List<Map<String,Object>> beforeQuestion = teacherMapper.selectQuestion(testNo);
			List<Map<String,Object>> afterQuestion = (List<Map<String,Object>>) paramMap.get("questionList");
			
			int[] beforeQuestionNo = new int[beforeQuestion.size()];
			int beforeSize = 0;
			for(Map<String,Object> beforeQ : beforeQuestion) {
				beforeQuestionNo[beforeSize] = (int) beforeQ.get("questionNo");
				beforeSize += 1;
			}
			
			if(beforeQuestion.size() < afterQuestion.size()) {
				int qIndex = 1;
				for(Map<String,Object> question : afterQuestion) {
					question.put("testNo", testNo);
					if(qIndex <= beforeQuestion.size()) {
						List<Map<String,Object>> beforeExample = teacherMapper.selectExample(beforeQuestionNo[qIndex-1]);
						List<Map<String,Object>> afterExample = (List<Map<String,Object>>) question.get("exampleList");
						
						int eIndex = 1;
						if(beforeExample.size() <= afterExample.size()) {
							for(Map<String,Object> example : afterExample) {
								example.put("questionNo", beforeQuestionNo[qIndex-1]);
								if(eIndex <= beforeExample.size()) {
									log.debug("보기업데이트");
									teacherMapper.updateExample(example);
								} else {
									log.debug("보기추가");
									teacherMapper.insertExample(example);
								}
								eIndex += 1;
							}
						} else {
							for(Map<String,Object> example : afterExample) {
								example.put("questionNo", beforeQuestionNo[qIndex-1]);
								log.debug("보기업데이트");
								teacherMapper.updateExample(example);
								eIndex += 1;
							}
							int forCnt = 1;
							for(Map<String,Object> example : beforeExample) {
								example.put("questionNo", beforeQuestionNo[qIndex-1]);
								if(forCnt >= eIndex) {
									log.debug("보기삭제");
									teacherMapper.deleteExampleByModify(example);
								}
								forCnt += 1;
							}
						}
						log.debug("문제업데이트");
						teacherMapper.updateQuestion(question);
						qIndex += 1;
					} else {
						teacherMapper.insertQuestion(question);
						List<Map<String,Object>> insertExample = (List<Map<String,Object>>) question.get("exampleList");
						for(Map<String,Object> example : insertExample) {
							example.put("questionNo", question.get("questionNo"));
							teacherMapper.insertExample(example);
						}
					}
				}
				
			} else { // beforeQuestion.size() >= afterQuestion.size()
				int qIndex = 1;

				for(Map<String,Object> question : afterQuestion) {
					question.put("testNo", testNo);
					if(qIndex <= beforeQuestion.size()) {
						List<Map<String,Object>> beforeExample = teacherMapper.selectExample(beforeQuestionNo[qIndex-1]);
						List<Map<String,Object>> afterExample = (List<Map<String,Object>>) question.get("exampleList");
						
						int eIndex = 1;
						if(beforeExample.size() <= afterExample.size()) {
							for(Map<String,Object> example : afterExample) {
								example.put("questionNo", beforeQuestionNo[qIndex-1]);
								if(eIndex <= beforeExample.size()) {
									teacherMapper.updateExample(example);
								} else {
									teacherMapper.insertExample(example);
								}
								eIndex += 1;
							}
						} else {
							for(Map<String,Object> example : afterExample) {
								example.put("questionNo", beforeQuestionNo[qIndex-1]);
								teacherMapper.updateExample(example);
								eIndex += 1;
							}
							int forCnt = 1;
							for(Map<String,Object> example : beforeExample) {
								example.put("questionNo", beforeQuestionNo[qIndex-1]);
								if(forCnt >= eIndex) {
									teacherMapper.deleteExampleByModify(example);
								}
								forCnt += 1;
							}
						}
						teacherMapper.updateQuestion(question);
						qIndex += 1;
					}
				}
				
				//qIndex는 afterSize만큼 돌고 남은 걸 비교 int i = qIndex; i<beforeQuestion.size(); i++
				int forCnt = 1;
				for(Map<String,Object> question : beforeQuestion) {
					question.put("testNo", testNo);
					if(forCnt >= qIndex) {
						List<Map<String,Object>> beforeExample = teacherMapper.selectExample((int)question.get("questionNo"));
						for(Map<String,Object> example : beforeExample) {
							example.put("questionNo", beforeQuestionNo[qIndex-1]);
							teacherMapper.deleteExampleByModify(example);
						}
						teacherMapper.deleteQuestionByModify(question);
					}
					forCnt += 1;
				}
			}
		}
		
		return 0;
	}
	
	// 강사 : 시험 삭제하기
	public int removeTest(int testNo) {
		
		return teacherMapper.deleteTest(testNo);
	}
	
	// 강사 : 시험 상세보기
	public Map<String,Object> getTestOne(int testNo) {
		Map<String, Object> resultMap = teacherMapper.selectTest(testNo);
		
		List<Map<String,Object>> questionList = teacherMapper.selectQuestion(testNo);
		
		for(Map<String,Object> question : questionList) {
			List<Map<String,Object>> example = teacherMapper.selectExample((int)question.get("questionNo"));
			question.put("example", example);
		}
		
		resultMap.put("questionList", questionList);
		
		return resultMap;
	}
	
	
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
		
		int idx = 0; // exampleOx 시작 순서
		int cnt = 0; // exampleCnt
		
		for(int i=0; i<questionTitle.length; i++) {
			Map<String,Object> question = new HashMap<String,Object>();
			question.put("questionTitle", questionTitle[i]);
			question.put("questionIdx", i+1);

			
			List<Map<String, Object>> exampleList = new ArrayList<Map<String,Object>>();
			while(idx < exampleCnt[i]) {
				Map<String,Object> example = new HashMap<String,Object>();
				example.put("exampleTitle", exampleTitle[cnt]);
				example.put("exampleIdx", idx+1);
				example.put("exampleOx", exampleOx[cnt]);
				
				cnt += 1;
				idx += 1;
				
				exampleList.add(example);
			}
			question.put("exampleList", exampleList);
			
			idx = 0;
			
			questionList.add(question);
		}
		
		paramMap.put("questionList", questionList);
		//정보가공 끝
		
		if(teacherMapper.insertTest(paramMap) != 0) {
			log.debug("testNo:" + paramMap.get("testNo"));
			for(Map<String,Object> question : questionList) {
				// 
				// question.put("testNo", autoIncrement);
				question.put("testNo", paramMap.get("testNo"));
				if(teacherMapper.insertQuestion(question) != 0) {
					@SuppressWarnings("unchecked")
					List<Map<String,Object>> exampleList = (List<Map<String,Object>>) question.get("exampleList");
					for(Map<String,Object> example : exampleList) {
						//example.put("questionNo", autoIncrement);
						log.debug("questionNo: "+question.get("questionNo"));
						example.put("questionNo", question.get("questionNo"));
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
	public int getTeacherListCnt(String searchWord, String searchCategory) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("searchWord", searchWord);
		paramMap.put("searchCategory", searchCategory);
		
		return teacherMapper.selectTeacherListCnt(paramMap);
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
