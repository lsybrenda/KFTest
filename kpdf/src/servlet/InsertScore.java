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
		
		//��ȡ�����URL��ַ
		String url = request.getRequestURI();
		//��ȡ������
		String methodName = url.substring(url.lastIndexOf("/")+1, url.lastIndexOf("."));
		Method method = null;
		try{
			//ʹ�÷�����ƻ�ȡ�ڱ����������˵ķ���
			method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class,HttpServletResponse.class);
			//ִ�з���
			method.invoke(this, request,response);
		} catch(Exception e){
			throw new RuntimeException("���÷�������");
		}
		
	}
	

	/**
	 * ����ÿ�Ŵ�ֱ����
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void insert(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("ִ�б���ÿ�Ŵ�ֱ������Ϣ�ķ���������");
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
	 * ͳ��ÿ���˵ļ�Ȩ�ܵ÷�
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * �쵼���ϼ�ƽ����*0.4+ͬ��ƽ����*0.2+����ƽ����*0.4
	 * Ա�����ϼ�ƽ����*0.5+�������ƽ����*0.5
	 * ���ϼ��⣬����ƽ���ּ�����ȥ����߷ֺ���ͷ�
	 */
	private void count(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("ִ��ÿ�������յ÷ּ��㡣����");
		request.setCharacterEncoding("utf-8");
		//�����������
		String name = request.getParameter("name");
		System.out.println(name);
		//��������Ƿ�Ϊ�쵼
		String thistype = request.getParameter("thistype");
		OperateDao countdao = new OperateDao();
		if(thistype.equals("�쵼")){
			//��ȡ�ϼ�ƽ����
			String hs = countdao.count_higher(name);
			System.out.println(hs);
		}else if(thistype.equals("Ա��")){
			
		}
		
	}
	
	/**
	 * ��ѯ��ֱ���Ϣ
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
			
			if(SearchInfo.getType().equals("Ա��")){
				request.setAttribute("SearchInfo", SearchInfo);
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			}else{
				request.setAttribute("SearchInfo", SearchInfo);			
				request.getRequestDispatcher("/leader.jsp").forward(request, response);
		    }
			
		}
	}
	/*
	 * ���ݹ��Ų�ѯ������Ϣ
	 */
	private User queryInfoById(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("��ʼ��ѯ������Ϣ������");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("empId").replace(" ", "");
		User user = new User();
		OperateDao dao = new OperateDao();
		user = dao.searchInfoById(id);
		return user;
	}
	
	
	/*
	 * ���ݹ��Ų�ѯ�����Ա����
	 */
	private void queryById(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("����ID��ѯ��Ա��ϵ������");
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
	 * �����ύ����
	 */
	private void insertScore(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("�������������");
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
	 * �����ύ����
	 */
	private void insertAllScore(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("��ʼ�������������");
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
	
	//���ݿ���id��ѯ��һ��÷�
	private void countTwo(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("��ʼ����������ܷ֡�����");
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
	
	
	//��IDɾ��ĳ��Ա���Ĵ������
	private void deleteById(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("��ʼɾ����ش�ּ�¼������");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("empId");
		try{
			OperateDao dao = new OperateDao();
			dao.deleteScore(id);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//��ѯĳλԱ���ĵ÷�
	private void searchScoreById(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("��ʼ��ѯ�÷���Ϣ������");
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
	
	//������������Ա���ܵ÷�
/*	private void exportScore(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		System.out.println("��ʼ����Ա���ܵ÷֡�����");
		
		
		
	}*/

	
}
