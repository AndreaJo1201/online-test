package goodee.gdj58.online.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import goodee.gdj58.online.vo.Teacher;

@Mapper
public interface TeacherMapper {
	
	int selectTestListCnt(Map<String,Object> paramMap);
	
	List<Map<String, Object>> selectTestList(Map<String, Object> paramMap);
	
	int updateTeacherPw(Map<String, Object> paramMap);
	
	int selectTeacherListCnt(String searchWord);
	
	Teacher login(Teacher teacher);
	
	int deleteTeacher(int teacherNo);
	
	int insertTeacher(Teacher teacher);
	
	List<Teacher> selectTeacherList(Map<String, Object> paramMap);
}
