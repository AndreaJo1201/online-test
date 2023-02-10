package goodee.gdj58.online.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import goodee.gdj58.online.vo.Student;

@Mapper
public interface StudentMapper {
	
	int insertPaper(Map<String,Object> paramMap);
	
	List<Map<String,Object>> selectExample(int questionNo);
	
	int selectAnswerListCnt(Map<String,Object> paramMap);
	
	List<Map<String,Object>> selectAnswerList(Map<String,Object> paramMap);
	
	int selectTestListCnt(Map<String,Object> paramMap);
	
	List<Map<String,Object>> selectTestList(Map<String,Object> paramMap);
	
	int updateStudentPw(Map<String, Object> paramMap);
	
	Student login(Student student);
	
	int selectStudentListCnt(Map<String,Object> paramMap);
	
	int deleteStudent(int studentNo);
	
	int insertStudent(Student student);
	
	List<Student> selectStudentList(Map<String, Object> paramMap);
}
