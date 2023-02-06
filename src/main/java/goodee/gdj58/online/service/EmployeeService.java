package goodee.gdj58.online.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.EmployeeMapper;
import goodee.gdj58.online.vo.Employee;

@Service
@Transactional
public class EmployeeService {
	// DI
	@Autowired
	private EmployeeMapper employeeMapper;
	
	public Map<String, Integer> paging(int listCnt, int currentPage, int rowPerPage) {
		Map<String, Integer> paging = new HashMap<String, Integer>();
		
		final int PAGE_COUNT = 10;
		
		int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
		int endPage = beginPage+PAGE_COUNT-1;
		int lastPage = (int)Math.ceil((double)listCnt / (double)rowPerPage);
		
		if(currentPage < 1) {
			currentPage = 1;
		} else if(currentPage > lastPage) {
			if(lastPage < 1) {
				lastPage = 1;
			}
			currentPage = lastPage;
		}
		
		paging.put("currentPage", currentPage);
		paging.put("beginPage", beginPage);
		paging.put("endPage", endPage);
		paging.put("lastPage", lastPage);
		paging.put("rowPerPage", rowPerPage);
		
		return paging;
	}
	
	public int modifyEmployeePw(int empNo, String oldPw, String newPw) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empNo", empNo);
		paramMap.put("oldPw", oldPw);
		paramMap.put("newPw", newPw);
		return employeeMapper.updateEmployeePw(paramMap);
	}
	
	public Employee login(Employee employee) {
		return employeeMapper.login(employee);
	}
	
	public int removeEmployee(int empNo) {
		return employeeMapper.deleteEmployee(empNo);
	}
	
	public int addEmployee(Employee employee) {
		return employeeMapper.insertEmployee(employee);
	}
	
	public int getEmployeeListCnt(String searchWord) {
		return employeeMapper.selectEmpListCnt(searchWord);
	}
	
	public List<Employee> getEmployeeList(int currentPage, int rowPerPage, String searchWord, String searchCategory) {
		int beginRow = (currentPage-1)*rowPerPage;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		paramMap.put("serachCategory", searchCategory);
		return employeeMapper.selectEmployeeList(paramMap);
	}
}
