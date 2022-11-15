package com.sns.timeline;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.model.CardView;

@Controller
@RequestMapping("/timeline")
public class TimelineController {
	
	@Autowired
	private TimelineBO timeLineBO;

	@RequestMapping("/timeline_view")
	public String timelineView(Model model,
			HttpSession session) {
		
		Integer userId = (Integer)session.getAttribute("userId");
		
		List<CardView> cardViewList = timeLineBO.generateCardList();
		
		model.addAttribute("viewName", "/timeline/timeline");
		model.addAttribute("cardList", cardViewList);
		
		return "template/layout";
	}
}
