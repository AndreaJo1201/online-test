package goodee.gdj58.online.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import goodee.gdj58.online.vo.Teacher;

@Mapper
public interface TeacherMapper {
	
	Integer selectTestByAnswer(int testNo);
	
	int deleteExampleByModify(Map<String,Object> paramMap);
	
	int updateExample(Map<String,Object> paramMap);
	
	int deleteQuestionByModify(Map<String,Object> paramMap);
	
	int updateQuestion(Map<String,Object> paramMap);
	
	int updateTest(Map<String,Object> paramMap);
	
	int deleteTest(int testNo);
	
	List<Map<String,Object>> selectExample(int questionNo);
	
	List<Map<String,Object>> selectQuestion(int testNo);
	
	Map<String, Object> selectTest(int testNo);
	
	int insertExample(Map<String,Object> paramMap);
	
	int insertQuestion(Map<String,Object> paramMap);
	
	int insertTest(Map<String, Object> paramMap);
	
	int selectTestListCnt(Map<String,Object> paramMap);
	
	List<Map<String, Object>> selectTestList(Map<String, Object> paramMap);
	
	int updateTeacherPw(Map<String, Object> paramMap);
	
	int selectTeacherListCnt(Map<String, Object> paramMap);
	
	Teacher login(Teacher teacher);
	
	int deleteTeacher(int teacherNo);
	
	int insertTeacher(Teacher teacher);
	
	List<Teacher> selectTeacherList(Map<String, Object> paramMap);
}
