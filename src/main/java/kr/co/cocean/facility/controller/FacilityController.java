package kr.co.cocean.facility.controller;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cocean.facility.service.FacilityService;

@Controller
public class FacilityController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired FacilityService service;

	@RequestMapping(value="/facility/facility.go")
	public ModelAndView faclity() {

		ModelAndView mav = new ModelAndView("facility/facility");

		List<HashMap<String, Object>> getCategory = service.getCategory();
		HashMap<String, Object> getPersonnelLeader = service.getPersonnelLeader();
		mav.addObject("getCategory", getCategory);
		mav.addObject("getPersonnelLeader", getPersonnelLeader);
		return mav;
	}

	@RequestMapping(value="/facility/getFacilityName.do")
	@ResponseBody
	public HashMap<String, Object> getFacilityName(@RequestParam String category) {

		List<HashMap<String, Object>> getfacilityName = service.getfacilityName(category);
		HashMap<String, Object> result = new HashMap<>();
		result.put("getfacilityName", getfacilityName);
		return result;
	}

	@RequestMapping(value="/facility/getFacilityInfo.do")
	@ResponseBody
	public HashMap<String, Object> getFacilityInfo(@RequestParam String facilityName) {


		HashMap<String, Object> getfacilityInfo = service.getfacilityInfo(facilityName);
		HashMap<String, Object> result = new HashMap<>();
		result.put("getfacilityInfo", getfacilityInfo);
		return result;
	}

	@PostMapping(value = "/facility/updateFacilityName.do")
	@ResponseBody
	public HashMap<String, Object> updateFacilityName( @RequestParam String facilityName,@RequestParam String facilityInfo,
			@RequestParam String facilityID ) {

		HashMap<String, Object> response = new HashMap<>();
		logger.info("@@@@@@"+facilityID);
		service.updateFacilityName(facilityName,facilityInfo,facilityID);

		response.put("message", "생성이 완료되었습니다.");
		return response;
		}

	@PostMapping(value = "/facility/delFacility.do")
	@ResponseBody
	public HashMap<String, Object> delFacility( @RequestParam String deltxt) {

		HashMap<String, Object> response = new HashMap<>();

		service.delFacility(deltxt);

		response.put("message", "삭제가 완료되었습니다.");
		return response;
		}

	@PostMapping(value = "/facility/addFacility.do")
	@ResponseBody
	public HashMap<String, Object> addFacility( @RequestParam String category, @RequestParam String facilityName
			, @RequestParam String facilityInfo) {

		HashMap<String, Object> response = new HashMap<>();

		service.addFacility(category,facilityName,facilityInfo);

		response.put("message", "생성이 완료되었습니다.");
		return response;
		}



}
