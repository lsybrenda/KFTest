package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.graphbuilder.struc.LinkedList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import pojo.Relation;
import pojo.Scores;
import pojo.Staff;
import pojo.User;
import score.count.CountTotals;



import dao.OperateDao;
public class InsertScore extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8464342992071748668L;
	

	@Override
	protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		doPost(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		
		//获取请求的URL地址
		String url = request.getRequestURI();
		//截取方法名
		String methodName = url.substring(url.lastIndexOf("/")+1, url.lastIndexOf("."));
		Method method = null;
		try{
			//使用反射机制获取在本类中声明了的方法
			method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class,HttpServletResponse.class);
			//执行方法
			method.invoke(this, request,response);
		} catch(Exception e){
			throw new RuntimeException("调用方法出错！");
		}
		
	}
	

	/**
	 * 保存每张打分表分数
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void insert(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("执行保存每张打分表分数信息的方法。。。");
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String firsts = request.getParameter("firsts");
		String seconds = request.getParameter("seconds");
		String thirds = request.getParameter("thirds");
		String totals = request.getParameter("totals");
		String khtype = request.getParameter("khtype");
		String thistype = request.getParameter("thistype");
		OperateDao dao = new OperateDao();
		dao.saveScore(name, firsts, seconds, thirds, totals,khtype,thistype);
	}
	/**
	 * 统计每个人的加权总得分
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * 领导：上级平均分*0.4+同级平均分*0.2+下属平均分*0.4
	 * 员工：上级平均分*0.5+服务对象平均分*0.5
	 * 除上级外，其余平均分计算需去掉最高分和最低分
	 */
	private void count(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("执行每个人最终得分计算。。。");
		request.setCharacterEncoding("utf-8");
		//被打分人姓名
		String name = request.getParameter("name");
		System.out.println(name);
		//被打分人是否为领导
		String thistype = request.getParameter("thistype");
		OperateDao countdao = new OperateDao();
		if(thistype.equals("领导")){
			//获取上级平均分
			String hs = countdao.count_higher(name);
			System.out.println(hs);
		}else if(thistype.equals("员工")){
			
		}
		
	}
	
	/**
	 * 查询打分表信息
	 * 
	 */
	private void searchKP(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		if(request.getParameter("name")==null || request.getParameter("name").equals("")){
			request.getRequestDispatcher("/first.jsp").forward(request, response);
		}else{
			String name = request.getParameter("name").replace(" ", "");
			OperateDao dao = new OperateDao();
			Staff SearchInfo = dao.getInfoByName(name);
			
			if(SearchInfo.getType().equals("员工")){
				request.setAttribute("SearchInfo", SearchInfo);
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			}else{
				request.setAttribute("SearchInfo", SearchInfo);			
				request.getRequestDispatcher("/leader.jsp").forward(request, response);
		    }
			
		}
	}
	/*
	 * 根据工号查询个人信息
	 */
	private User queryInfoById(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("开始查询个人信息。。。");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("empId").replace(" ", "");
		User user = new User();
		OperateDao dao = new OperateDao();
		user = dao.searchInfoById(id);
		return user;
	}
	
	
	/*
	 * 根据工号查询打分人员名单
	 */
	private void queryById(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("根据ID查询人员关系。。。");
		request.setCharacterEncoding("utf-8");
		try{
			response.setCharacterEncoding("utf-8");
			String khID = request.getParameter("empId").replace(" ", "");
			List<Relation> list = new ArrayList<Relation>();
			OperateDao dao = new OperateDao();
			list = dao.searchKPList(khID);
			ObjectMapper mapper = new ObjectMapper();
			mapper.writeValue(System.out,list);
			HttpSession session = request.getSession();
			session.setMaxInactiveInterval(150*60);
			session.setAttribute("examinerId", khID);
			response.getWriter().write(mapper.writeValueAsString(list));
			response.getWriter().close();
		} catch(Exception e){
			e.printStackTrace();
		}

	}
	
	
	/*
	 * 单条提交分数
	 */
	private void insertScore(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("保存分数。。。");
		request.setCharacterEncoding("utf-8");
		try{
			String exaid = request.getParameter("exaid").replace(" ", "");
			//System.out.println(exaid);
			String examiner = request.getParameter("examiner");
			String candidate = request.getParameter("candidate");
			String score = request.getParameter("score").toString();
			OperateDao dao = new OperateDao();
			dao.insertScore(exaid, examiner, candidate, score);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/*
	 * 多条提交分数
	 */
	private void insertAllScore(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("开始保存分数。。。");
		request.setCharacterEncoding("utf-8");
		String arr = request.getParameter("arr");
		System.out.println(arr);
		try{
			OperateDao dao = new OperateDao();
			dao.savetable(arr);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	//根据考生id查询第一项得分
	private void countTwo(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("开始计算二部分总分。。。");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		
		try{
			OperateDao dao = new OperateDao();
			User user = new User();
			user = dao.searchInfoById(id);
			String position = user.getPosition();
			dao.countOne(id,position);
		}catch(Exception e){
			
		}
	}
	
	
	//按ID删除某个员工的打分数据
	private void deleteById(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("开始删除相关打分记录。。。");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("empId");
		try{
			OperateDao dao = new OperateDao();
			dao.deleteScore(id);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//查询某位员工的得分
	private void searchScoreById(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("开始查询得分信息。。。");
		double scoreall=0;
		request.setCharacterEncoding("utf-8");
		String emp = request.getParameter("emp");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		CountTotals ct = new CountTotals();
		scoreall = ct.searchAllById(emp);
		System.out.println(scoreall);
		out.println(scoreall);
	}
	
	//批量导出所有员工总得分
/*	private void exportScore(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("开始导出员工总得分。。。");
		
		
		
	}*/

	
}
