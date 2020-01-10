<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.dxy.dafen.jsp.action.GradeData" %>
<%@ page import="com.dxy.dafen.jsp.action.CandidateBean" %>
<%@ page import="com.dxy.dafen.jsp.action.SameworkBean" %>
<!doctype html>
<head>
<script type="text/javascript">
	
</script>
<title>无标题文档</title>

<% String examiner = session.getAttribute("examinerId").toString(); %>

</head>

<body>

<center><h1>业绩目标</h1></center>
<%-- <input type="text" style="display:none" id="idjilu" value="<%= examinerid%>"/> --%>
<p align="center"><strong>评分分为1-10分，10分为最高分</strong></p>

<%

		HashMap<String, String> userNamemap = GradeData.getUserNameMap();
		HashMap<String, ArrayList<String>> map = GradeData.getRelation(examiner);
		HashMap<String, ArrayList<String>> exaMap = GradeData.getExaminationQuestions(examiner);
		HashMap<String, ArrayList<String>> id_idsMap = GradeData.getSamework(examiner);
		int num = 1;
		for (Iterator<String> iterator = map.keySet().iterator(); iterator.hasNext();) {
			String examinertype = iterator.next();
			String examinertypeCN = "";
			if(examinertype.equals("A")){
				examinertypeCN="上级";
			}else if(examinertype.equals("B")){
				examinertypeCN="同级";
			}else if(examinertype.equals("C")){
				examinertypeCN="下级/服务对象";
			}
			
			ArrayList<String> userlist = map.get(examinertype);
			
			for (int i = 0; i < userlist.size(); i++) {
				String candidate = userlist.get(i);
				ArrayList<String> examinationQlist = exaMap.get(candidate);
				CandidateBean bean = GradeData.getCandidateBean(candidate);
				%>
<div <%if(num!=1){  %>style="display:none;"<% } %>  id="divstep<%=num++ %>" >
<input type="hidden" name="candidateid" value='<%=bean.getId() %>'>
<table width="800" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="13%"><p align="center">姓名 </p></td>
    <td width="10%" colspan="2"><p align="center"><%=bean.getName() %></p></td>
    <td width="12%"><p align="center">部门 </p></td>
    <td width="27%" colspan="2"><p align="center"><%=bean.getDepartment()%></p></td>
    <td width="15%"><p align="center">考核人类型 </p></td>
    <td width="20%"><p align="center"><%=examinertypeCN%></p></td>
  </tr>
  <tr>
    <td width="13%"><p align="center">岗位 </p></td>
    <td width="10%" colspan="2"><p align="center"><%=bean.getPosition() %></p></td>
    <td width="12%"><p align="center">入职时间 </p></td>
    <td width="27%" colspan="2"><p align="center"><%=bean.getHiredate() %> </p></td>
    <td width="15%"><p align="center">考核期 </p></td>
    <td width="20%"><p align="center">2019年半年度 </p></td>
  </tr>
  <tr>
    <td width="79%" colspan="7"><p align="center">目标细分 </p></td>
    <td width="20%"><p align="center">分数 </p></td>
  </tr>
 <%
 
for (int j = 0; j < examinationQlist.size(); j++) {
	String str = examinationQlist.get(j);
	String exa_id = str.substring(0,12);
	String examinationQ = str.substring(12);
	%>
	<tr>
    <td width="79%" colspan="7" valign="top"><p><%=examinationQ %></p></td>
    
	<td width="20%">
	<p align="center">
	
		<select
		<%
			if(id_idsMap.containsKey(exa_id)&&(id_idsMap.get(exa_id)).size()>1){
		%>
			 disabled="disabled"
		<%
			}
		%>
		style="font-size:24px" id="<%=exa_id %>" class="<%=bean.getId() %>" onChange="getValue('<%=bean.getId() %>')">
			<option value="0" selected>0</option>
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
		</select>
	
	</p>
	</td>
	</tr>
<%	
	
	if(id_idsMap.containsKey(exa_id)&&(id_idsMap.get(exa_id)).size()>1){
	//if(id_idsMap.size()!=0){
		ArrayList<String> bigIdlist = id_idsMap.get(exa_id);
	
		String sign = bigIdlist.get(0).substring(12);
		
		%>
			<tr>
    			<td colspan="8" valign="top"><p align="center">
		<%
		
		for (int k = 0; k < bigIdlist.size(); k++) {
			String bigId = bigIdlist.get(k);
			String this_exa_id = bigId.substring(0,12);
			String this_userid = bigId.substring(5,10);
			String this_username = userNamemap.get(this_userid);
		%>
			<%=this_username %>
	    	<select  style="font-size:24px" id="<%=bigId %>" class="<%=(sign+this_userid) %>" name="<%=(sign+bean.getId()) %>" onChange="getSendScore('<%=this_exa_id%>','<%=this_userid %>',this,'<%=(sign+this_userid) %>')">
				<option value="0" selected>0</option>
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
			</select>
		<%
		}
		%>
			</p></td></tr>
		<%
	}
}
%>
<tr>
    <td width="45%" colspan="3"><p align="center">得分小计 </p></td>
    <td width="55%" colspan="5"><p align="center"><span id="<%=bean.getId() %>span1" style="font-size:32px">0</span></p></td>
    <%-- <td width="26%" colspan="2"><p align="center">加权后得分 </p></td>
    <td width="20%"><p align="center"><span id="<%=bean.getId() %>span11" style="font-size:32px">0</span></p></td> --%>
  </tr>
</table>	
</div>	
<% 
	
			}
		}
		
%>
<br />
<p align="center"><input type="button" value="上一页" onclick="goLeft()"></input>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="下一页" onclick="goRight()"></input></p>
<!-- <p align="center"><input type="button" value="提交" id="buttonplay" onclick="submitAll()"></input></p> -->
<p align="center"><button type="submit" class="easyui-linkbutton" id="buttonplay" onclick="submitAll();">提交</button></p>


<script type="text/javascript">

	var divCount=0;
	var zeroflag = 0;
	divCount = $("div[id^='divstep']").length; 
/* 	if(divCount > 1){
		$('#buttonplay').hide();
	}
 */

function submitAll(){
	
	var examiner =  "<%=session.getAttribute("examinerId")%>";
	var selectobjs = document.querySelectorAll("select");
	var zeroid="";
	var zeronum="";
	
	zeroflag = 0;
	for (var i = 0;i<selectobjs.length;i++){
		var fenshu = selectobjs[i].value;
		if(fenshu=="0"){
			zeroflag = 1;
			
			zeroid=(selectobjs[i].id).substring(5,10);
			zeronum=(selectobjs[i].id).substring(10,12);
			alert("发现0分项，请核对是否有漏打分项！");
			//alert("发现"+zeroid+"的第"+zeronum+"项为0分项,请核对是否漏打分！");	
			return;
		}
	}
	
	if(zeroflag == 0){
		var datas = new Array(selectobjs.length);
		for(var i=0;i<selectobjs.length;i++){
			var ss="";
			var str = "";
			str += $(selectobjs[i]).attr('id');
			ss = ($(selectobjs[i]).attr('id')).substring(5,10);
			str += ",";
			str += examiner;
			str += ",";
			//str += $(selectobjs[i]).attr('class');
			str += ss;
			str += ",";
			str += $(selectobjs[i]).val();
			datas[i] = str;
		}
	}
	

	$.ajax({
		url:"insertAllScore.do",
		type:"post",
		data:{
			"arr":datas.toString()
		},
		success:function(data){
			//document.getElementById("buttonplay").disabled=true;
			document.getElementById("buttonplay").style.display="none";
			page1=1;
			alert("提交成功！");
		},
		error:function(data){
			alert("提交失败！");
		}
	});
	
}

</script>
</body>
</html>
