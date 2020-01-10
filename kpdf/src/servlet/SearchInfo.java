package servlet;
import DB.OperateOracle;
import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import dao.OperateDao;
import pojo.Staff;


//查询员工基本信息
public class SearchInfo extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8682123824559324381L;
	
	@Override
	protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		this.doPost(request, response);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		
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
	
	/**
	 * 查询打分表信息
	 * 
	 *//*
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
	}*/
}




