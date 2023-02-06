package goodee.gdj58.online.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PageService {
	// 강사 : 시험리스트 페이징 -> 사원, 강사, 학생 통합 service 만들어서 이동할 것!
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
}
