package com.spring.user.controller;

import java.io.IOException;
import java.lang.annotation.Annotation;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialRef;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.spring.board.vo.BoardVo;
import com.spring.naver.BO.NaverLoginBO;
import com.spring.user.dao.impl.UserDaoImpl;
import com.spring.user.service.UserService;
import com.spring.user.service.impl.UserServiceImpl;
import com.spring.user.vo.UserVo;
import javax.servlet.http.HttpSession;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.spring.naver.BO.NaverLoginBO;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@RequestMapping(value="/user/userJoin.do", method=RequestMethod.GET)
	public String userJoin(Locale locale, Model model) throws Exception{
		
		List<String> list = userService.comPhone("phone");
		model.addAttribute("list", list);

		return "user/userJoin";
	}
	@RequestMapping(value="/user/userJoinAction.do", method=RequestMethod.POST)
	
	public String userJoinAction(Locale locale, Model model, 
			UserVo userVo, HttpServletRequest req) throws Exception{
		int resultCnt;
		req.setCharacterEncoding("UTF-8");
		int result = userService.userIdChk(userVo);
		if(result==1) {
			return "user/userJoinAction";
		}
		
		System.out.println(userVo.getUserName());
		resultCnt = userService.userInsert(userVo);
		model.addAttribute("alert",result);
		model.addAttribute("resultCnt",resultCnt);	
		model.addAttribute("alert",result);
		return "user/userLogin";
		
	}
	@ResponseBody
	@RequestMapping(value="/user/idChk.do", method = RequestMethod.POST)
	public int idChk(UserVo userVo,HttpServletRequest req) throws Exception {
		int result = userService.userIdChk(userVo);
		System.out.println(req.getAttribute("uesrId"));
		return result;
	}

	/*
	 * @RequestMapping(value="/user/userLogin.do", method=RequestMethod.GET) public
	 * String userLogin(Locale locale, Model model) throws Exception{
	 * 
	 * return "user/userLogin"; }
	 */
	@RequestMapping(value="/user/userLoginAction.do", method=RequestMethod.POST)
		
		public String userLoginAction(Locale locale, Model model,
				HttpServletRequest req,
				UserVo userVo) throws Exception{
			System.out.println("userVo");
			String userId=userVo.getUserId();
			String userName=userVo.getUserName();
			int resultId = userService.userIdChk(userVo);
			int resultPw = userService.userPwChk(userVo);
			model.addAttribute("resultId",resultId);
			model.addAttribute("resultPw",resultPw);
			model.addAttribute("userId", userId);
			HttpSession session = req.getSession();
			if(resultId==1&&resultPw==1) {
				session.setAttribute("ses", userVo.getUserId());
				session.setAttribute("name", userVo.getUserName());
			}
			return "user/userLogin";
			
		}
	//????????????
	@RequestMapping(value="/user/userLogout.do", method=RequestMethod.GET)
	public String userLogout(HttpSession session
			)throws Exception{
		session.invalidate();
		return "redirect:/user/userLogin.do";
	}
	

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
		}
		//????????? ??? ?????? ?????? ?????????
	@RequestMapping(value = "/user/userLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* ????????????????????? ?????? URL??? ???????????? ????????? naverLoginBO???????????? getAuthorizationUrl????????? ?????? */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("?????????:" + naverAuthUrl);
		//?????????
		model.addAttribute("url", naverAuthUrl);
		return "user/userLogin";
	}
	//????????? ????????? ????????? callback?????? ?????????
	@RequestMapping(value = "user/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
		System.out.println("????????? callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		//1. ????????? ????????? ????????? ????????????.
		apiResult = naverLoginBO.getUserProfile(oauthToken); //String????????? json?????????
		/** apiResult json ??????
		{"resultcode":"00",
		"message":"success",
		"response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		**/
		//2. String????????? apiResult??? json????????? ??????
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		//3. ????????? ??????
		//Top?????? ?????? _response ??????
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		//response??? nickname??? ??????
		String nickname = (String)response_obj.get("nickname");
		System.out.println(nickname);
		//4.?????? ????????? ???????????? ??????
		session.setAttribute("sessionId",nickname); //?????? ??????
		model.addAttribute("result", apiResult);
		return "user/naverLogin";
	}
	
	
}
