package goodee.gdj58.online.restController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import goodee.gdj58.online.service.IdService;

@RestController
public class EmployeeRestController {
	@Autowired
	private IdService idService;
	
	@GetMapping("/idck")
	public String idck(@RequestParam(value="id") String id) {
		String result = "NO";
		if(idService.getIdCheck(id) == null) {
			result = "YES";
		}
		
		return result;
	}
}
