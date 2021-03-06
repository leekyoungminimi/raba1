package com.bitcamp.rava;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.dto.HostDTO;
import com.bitcamp.dto.TourApplyDTO;
import com.bitcamp.dto.TourDTO;
import com.bitcamp.dto.TourMarkerDTO;
import com.bitcamp.dto.TourPage;
import com.bitcamp.dto.TourReplyDTO;
import com.bitcamp.security.Login__MemberVO;
import com.bitcamp.service.MypageService;
import com.bitcamp.service.TourService;

@Controller
public class TourController {
	
	@Autowired
	private TourService tourService;

	@Autowired
	private MypageService mypageservice;
	
	@RequestMapping(value = "/touradmin", method = RequestMethod.GET)
	public String touradmin(@RequestParam(required=false, defaultValue="1") int currPage 
			,Model model) {
	
		int totalRow =tourService.totalCount();
		int pageSize = 10;
		int blockSize = 10;
		TourPage page = new TourPage(currPage, totalRow, pageSize, blockSize);
		
		List<TourDTO> tourlist = tourService.tourList(page.getStartRow(), page.getPageSize());
		
		model.addAttribute("tourlist", tourlist);
		model.addAttribute("page", page);
		
		return "admin/touradmin";
	}
	
	
	@RequestMapping("/tourlist")
	public String tourlist(@RequestParam(required=false, defaultValue="1") int currPage 
							,Model model) {
		
		int totalRow = tourService.totalCount();
		int pageSize = 9;
		int blockSize = 5;
		TourPage page = new TourPage(currPage, totalRow, pageSize, blockSize);
		
		List<TourDTO> list = tourService.tourList(page.getStartRow(),page.getPageSize());
		
		model.addAttribute("page", page);
		model.addAttribute("list",list);
		
		return "tourall/tourlist";
	}
	
	@RequestMapping("/tourdetail/{tourno}")
	public String tourdetail(@PathVariable("tourno") int tourno, Model model) {
		
		TourDTO dto = tourService.tourDetail(tourno);
		List<TourMarkerDTO> markerlist = tourService.markerList(tourno);
		HostDTO hostdto = tourService.hostDetail(dto.getHostno());
		List<TourReplyDTO> redtolist = tourService.replyList(tourno);

		model.addAttribute("hostdto", hostdto);
		model.addAttribute("dto", dto);
		model.addAttribute("markerlist", markerlist);
		model.addAttribute("redtolist", redtolist);
		
		return "tour/tourdetail";
	}
	
	@RequestMapping("/tourinsert")
	public String tourinsert(Model model) {
		
		return "tour/tourinsert";
	}
	
	@RequestMapping("/tourinsertresult")
	public String tourinsertresult(TourDTO dto,Model model) {

		tourService.insertTour(dto);
	
		return "redirect:/tourlist";
	}
	
	@RequestMapping(value="/tourapply")
	@ResponseBody
	public int tourapply(@RequestParam String userid, @RequestParam int tourno) {
		//결과값을 구하는 기능 구현
		int result = tourService.applyTour(userid, tourno);
		
		return result;
	}
	
	@RequestMapping("/tourdelete/{tourno}")
	public String tourdelete(@PathVariable int tourno) {
		
		tourService.deleteTour(tourno);
		
		return "redirect:/tourlist";
	}
	
	@RequestMapping("/atourdelete")
	@ResponseBody
	public int atourdelete(@RequestParam int tourno) {
		int result = tourService.deleteTour(tourno);
		return result;
	}
	
	@RequestMapping("/tourupdate/{tourno}")
	public String tourupdate(@PathVariable int tourno, Model model) {
		TourDTO dto = tourService.tourDetail(tourno);
		List<TourMarkerDTO> markerlist = tourService.markerList(tourno);
		HostDTO hostdto = tourService.hostDetail(dto.getHostno());
		
		model.addAttribute("hostdto", hostdto);
		model.addAttribute("dto", dto);
		model.addAttribute("markerlist", markerlist);
		
		return "tour/tourupdate";
	}
	
	@RequestMapping("/tourupdateresult")
	public String tourupdateresult(TourDTO dto,Model model) {
		tourService.updateTour(dto);
		
		return "redirect:/tourlist";
	}
		
	@RequestMapping("/tourreinsert")
	@ResponseBody
	public List<TourReplyDTO> tourreinsert(TourReplyDTO redto) {

		return tourService.replyInsert(redto);
		
	}
	
	@RequestMapping("/tourredelete")
	@ResponseBody
	public List<TourReplyDTO> tourredelete(@RequestParam int tourno, @RequestParam int tourreno) {
		
		return tourService.deleteTourRe(tourno,tourreno);
	}
	
	@RequestMapping("/tourrelist")
	@ResponseBody
	public List<TourReplyDTO> tourrelist(@RequestParam int tourno) {
		
		return tourService.listTourRe(tourno);
	}
	
	@RequestMapping("/tourreupdate")
	@ResponseBody
	public List<TourReplyDTO> tourreupdate(@RequestParam int tourreno, @RequestParam int tourno, @RequestParam String recontent) {
		//결과값을 구하는 기능 구현
		
		return tourService.updateTourRe(tourno, tourreno, recontent);
	}
	
	
	@RequestMapping("/tourupdatestate")
	@ResponseBody
	public int tourupdatestate(@RequestParam int tourno, @RequestParam int tourstate) {
		
		int result = tourService.updateState(tourno, tourstate);
		return result;
	}
	
	@RequestMapping("/tourmypage")
	public String tourmypage(Model model,Principal principal) {
		String userid = principal.getName();
		
		List<TourDTO> list = tourService.tourUserList(userid);
		model.addAttribute("list", list);
		
		Login__MemberVO vo = mypageservice.userinfo(userid); //정보수정 페이지에서 사용합니다.(1/2) 
		model.addAttribute("userinfo", vo); //정보수정 페이지에서 사용합니다. (2/2)

		
		int totaldistance = 0;
		for(TourDTO dto : list) {
			if(dto.getTourstate()==2) {
				totaldistance += dto.getDistance();
			}
		}
		
		model.addAttribute("totaldistance", totaldistance);
		
		return "tour/tourmypage";
	}
	
	
	@RequestMapping("/tourmypagelistre")
	@ResponseBody
	public List<TourDTO> tourmypagelistre(@RequestParam String userid, @RequestParam String searchtxt, @RequestParam int tourstate) {
		
		return tourService.tourUserSearchList(userid,searchtxt,tourstate);
	}
	
	
	@RequestMapping("/tourhostpage")
	public String tourhostpage(Model model,Principal principal) {
		String userid = principal.getName();

		Login__MemberVO vo = mypageservice.userinfo(userid); //정보수정 페이지에서 사용합니다.(1/2) 
		model.addAttribute("userinfo", vo); //정보수정 페이지에서 사용합니다. (2/2)
		
		HostDTO hostdto = tourService.hostDetailById(userid);
		List<TourDTO> list = tourService.tourHostList(hostdto.getHostno());
		
		model.addAttribute("list", list);
		model.addAttribute("hostdto", hostdto);
		
		return "tour/tourhostpage";
	}
	
	@RequestMapping("/tourhostlistre")
	@ResponseBody
	public List<TourDTO> tourhostlistre(@RequestParam int hostno, @RequestParam int tourstate) {
		System.out.println(tourstate);
		
		return tourService.tourHostListSelected(hostno,tourstate);
	}
	
	
	
	@RequestMapping(value="/tourcancel")
	@ResponseBody
	public int tourcancel(@RequestParam String userid, @RequestParam int tourno) {
		//결과값을 구하는 기능 구현
		int result = tourService.cancelApplyTour(userid, tourno);
		
		return result;
	}
	
	@RequestMapping("/tourapplist")
	@ResponseBody
	public List<TourApplyDTO> tourapplist(@RequestParam int tourno) {
		
		return tourService.tourApplyList(tourno);
	}
	
	@RequestMapping("/tourgetfavorit")
	@ResponseBody
	public TourDTO tourgetfavorit(@RequestParam int tourno) {
		
		return tourService.tourFavDetail(tourno);
	}
	
}



