package goodee.gdj58.online.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {
	@GetMapping("main")
	public String loginTeacher() {
		return "index";
	}
}
