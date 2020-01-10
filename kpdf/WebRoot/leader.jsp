<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="pojo.Staff" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>领导干部页</title>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.7.5/themes/default/easyui.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.7.5/themes/icon.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.7.5/themes/common.css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.7.5/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.7.5/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.7.5/easyui-lang-zh_CN.js"></script> --%>
  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.7.5/themes/default/easyui.css" />
  <script type="text/javascript" src="jquery-easyui-1.7.5/jquery.min.js"></script>
  <script type="text/javascript" src="jquery-easyui-1.7.5/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="jquery-easyui-1.7.5/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">



function getValue(){

	var fenshu = 0;
	var fenshu1 = 0;
	var objs1 = document.getElementsByName("fenshu1");
	for (var i=0;i<objs1.length;i++){
		thisshufen = objs1[i].value;
	    fenshu1 = fenshu1 + parseInt(thisshufen);
	}
	
	document.getElementById("span1").innerText=fenshu1;
	fenshu += fenshu1/(objs1.length)*6;
	document.getElementById("span11").innerText=fenshu1/(objs1.length)*6;
	
	var fenshu2 = 0;
	var objs2 = document.getElementsByName("fenshu2");
	for (var i=0;i<objs2.length;i++){
		thisshufen = objs2[i].value;
		fenshu2 = fenshu2 + parseInt(thisshufen);
	}
	document.getElementById("span2").innerText=fenshu2;
	fenshu += fenshu2/2;
	document.getElementById("span22").innerText=fenshu2/2;
	
	var fenshu3 = 0;
	var objs3 = document.getElementsByName("fenshu3");
	for (var i=0;i<objs3.length;i++){
		thisshufen = objs3[i].value;
		fenshu3 = fenshu3 + parseInt(thisshufen);
	}
	document.getElementById("span3").innerText=fenshu3;
	fenshu += fenshu3/2;
	document.getElementById("span33").innerText=fenshu3/2;
	document.getElementById("spanall").innerText=(fenshu);
	
}

function printpage(){
	window.print();	
}

</script>
</head>
<body>
	<center><h1>领导干部考核评估表</h1></center>
	<%!
  		List<String> kpilist= new ArrayList<String>();
	%>
	<table width="800" border="1" align="center" cellpadding="0" cellspacing="0">
  <%
  //获取个人信息
  Staff staff = (Staff)request.getAttribute("SearchInfo");
  if(staff == null){
	  out.print("没有该员工数据！");
  }else{
		String temp = staff.getKpi();
		kpilist=Arrays.asList(temp.split("\\$"));

  %>

  <tr>
    <td width="13%" ><p align="center">姓名 </p></td>
    <td width="15%" colspan="2" align="center" id="ename" name="name"><%=staff.getName() %></td>
    <td width="12%"><p align="center">部门 </p></td>
    <td width="23%" colspan="2" align="center"><%=staff.getDepartment() %></td>
    <td width="15%"><p align="center">考核人类型</p></td>
    <td width="20%" colspan="2" align="center" id="type" name="type"></td>
  </tr>
  
  <tr>
    <td width="13%"><p align="center">职位</p></td>
    <td width="15%" colspan="2" align="center"><%=staff.getPost() %></td>
    <td width="12%"><p align="center">任职时间 </p></td>
    <td width="23%" colspan="2" align="center"><%=staff.getTimein() %></td>
    <td width="15%"><p align="center">考核期 </p></td>
    <td width="20%" clospan="2" align="center"><%=staff.getKhtime() %></td>
  </tr>
  <% 
  }
  %>
  
  <tr>
    <td width="100%" colspan="8"><p align="center"><strong>评分分为</strong><strong>1-10</strong><strong>分，</strong><strong>10</strong><strong>分为最高分</strong><strong> </strong></p></td>
  </tr>
  <tr>
    <td width="100%" colspan="8"><p align="center"><strong>一、业绩目标</strong><strong> </strong></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7"><p align="center">目标细分 </p></td>
    <td width="20%"><p align="center">分数 </p></td>
  </tr>
  <%
  for(int i=0;i<kpilist.size();i++){
  %>
  <tr>
     <td width="79%" colspan="7" valign="top"><p><%=kpilist.get(i) %></p></td>
     <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu1" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <%
  }
  %>

  <tr>
    <td width="26%" colspan="2"><p align="center">得分小计 </p></td>
    <td width="26%" colspan="3"><p align="center"><span id="span1" name="span1" style="font-size:32px"></span></p></td>
    <td width="26%" colspan="2"><p align="center">加权后得分 </p></td>
    <td width="20%"><p align="center"><span id="span11" name="span11" style="font-size:32px"></span></p></td>
  </tr>
  <tr>
    <td width="100%" colspan="8"><p align="center"><strong>二、核心能力</strong><strong> </strong></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7"><p align="center">能力细分 </p></td>
    <td width="20%"><p align="center">分数 </p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7" valign="top"><p align="left"><strong>1. </strong><strong>解决问题能力</strong><strong> </strong><br>
      （运用观念、规则、一定的程序方法等对问题进行分析并提出解决方案） </p></td>
    <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu2" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7" valign="top"><p align="left"><strong>2. </strong><strong>团队建设能力</strong><strong> </strong><br>
      （为了实现团队产出最大化而进行的一系列结构设计、团队优化行为） </p></td>
    <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu2" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7" valign="top"><p align="left"><strong>3. </strong><strong>培养他人能力</strong><strong> </strong><br>
      （自发、真诚的去帮助他人提高工作上的技能、工作方法和能力素质等）</p></td>
    <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu2" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7" valign="top"><p align="left">4. <strong>适应变化能力</strong><strong> </strong><br>
      （对外部、内部变化快速反应并提出解决方案）     </p></td>
    <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu2" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7" valign="top"><p align="left"><strong>5. </strong><strong>沟通协调能力</strong><strong> </strong><br>
      （能妥善处理好上级、同级、下级的关系，调动各方面的工作积极性）            </p></td>
    <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu2" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <tr>
    <td width="26%" colspan="2"><p align="center">得分小计 </p></td>
    <td width="26%" colspan="3"><p align="center"><span id="span2" name="span2" style="font-size:32px"></span></p></td>
    <td width="26%" colspan="2"><p align="center">加权后得分 </p></td>
    <td width="20%"><p align="center"><span id="span22" name="span22" style="font-size:32px"></span></p></td>
  </tr>
  <tr>
    <td width="100%" colspan="8"><p align="center"><strong>三、工作态度</strong><strong> </strong></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7"><p align="center">态度细分 </p></td>
    <td width="20%"><p align="center">分数 </p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7" valign="top"><p align="left">1. 责任感强，尽职尽责</p></td>
    <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu3" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7" valign="top"><p align="left">2. 工作中具有服务意识</p></td>
    <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu3" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7" valign="top"><p align="left">3. 具有预见性、计划性</p></td>
    <td width="20%"><p align="center"><select  style="font-size:24px" name="fenshu3" onChange="getValue()">
      <option value="0" selected></option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select></p></td>
  </tr>
  <tr>
    <td width="26%" colspan="2"><p align="center">得分小计 </p></td>
    <td width="26%" colspan="3"><p align="center"><span id="span3" name="span3" style="font-size:32px"></span></p></td>
    <td width="26%" colspan="2"><p align="center">加权后得分 </p></td>
    <td width="20%"><p align="center"><span id="span33" name="span33" style="font-size:32px"></span></p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7"><p align="center"><strong>总分</strong><strong>=</strong><strong>第一项加权分</strong><strong>+</strong><strong>第二项得分小计</strong><strong>+</strong><strong>第三项得分小计</strong><strong> </strong></p></td>
    <td width="20%"><p align="center"><span id="spanall" name="spanall" style="font-size:38px; font-weight:600 ; color:#F00"></span></p></td>
  </tr>
</table>
<center>
  <button type="submit" id="bt_1" onclick="checkfenshu();">提交</button>
 </center>
</body>
<script type="text/javascript">

	checkfenshu = function(){
		var objs_fenshu1 = document.getElementsByName("fenshu1");
		var objs_funshu2 = document.getElementsByName("fenshu2");
		var objs_senshu3 = document.getElementsByName("fenshu3");
		var flag = 0;//是否有为空的分数项
		//alert(length);
		for(var i=0;i<objs_fenshu1.length;i++){
			thisfenshu = objs_fenshu1[i].value;
			if(parseInt(thisfenshu) < 1){
				flag = 1;
			}
		}
		if(flag == 1){
			alert("打分项不能为空，请检查！");
		}else{
			subbtn();
		}
	};
	
	//存储每张打分表得分
	subbtn = function(){
		var name = document.getElementById('ename').innerHTML;
		var firsts = document.getElementById('span11').innerText;
		var seconds = document.getElementById('span22').innerText;
		var thirds = document.getElementById('span33').innerText;
		var totals = document.getElementById('spanall').innerText;
		var khtype = document.getElementById('khtype').innerText;
		var thistype = document.getElementById('thistype').innerText;
		//alert(thistype);
		
	    $.ajax({
			url:"insert.do",
			type:"post",
			data:{'name':name,'firsts':firsts,'seconds':seconds,'thirds':thirds,'totals':totals,'khtype':khtype,'thistype':thistype},
			success:function(data){
				alert("提交成功！");
			},
			error:function(data){
				alert("error!");
			}
		}); 

	};


</script>
</html>