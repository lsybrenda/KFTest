<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>首页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.7.5/themes/default/easyui.css" />
	  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.7.5/themes/icon.css" />
	  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.7.5/themes/common.css" />
  	  <script type="text/javascript" src="jquery-easyui-1.7.5/jquery.min.js"></script>
      <script type="text/javascript" src="jquery-easyui-1.7.5/jquery.easyui.min.js"></script>
      <script type="text/javascript" src="jquery-easyui-1.7.5/easyui-lang-zh_CN.js"></script>
      <script type="text/javascript" src="jspart1/part1.js"></script>
	  <script type="text/javascript">
			$(function() {
				//判断Tab关闭
				$("#tt").tabs({
					onBeforeClose:function(title,index){
						alert("不允许关闭！");
						return false;
					}
					
				});
				
				//添加新的Tab页
				$("#navmenu").on("click", "a[data-url]", function(e) {
					e.preventDefault();
					var tabTitle = $(this).text();
					var tabUrl = $(this).data("url");
					
					if($("#tt").tabs("exists", tabTitle)) { //判断该Tab页是否已经存在
						$("#tt").tabs("select", tabTitle);
					}else {
						$("#tt").tabs("add", {
							title: tabTitle,
							href: tabUrl,
							closable: true
						});
					}
					$("#navmenu .active").removeClass("active");
					$(this).parent().addClass("active");
				});
				
				//解决闪屏的问题
				window.setTimeout(function() {
					$("#layout").css("visibility", "visible");
				}, 800);
			});
			
   </script>
  </head>
  <body class="easyui-layout" id="layout" style="visibility:hidden;">
		
		<div region="north" id="header">
			<img src="images/logo0713.jpg" class="logo" />
			<div class="top-btns">
				<span>欢迎您，管理员</span>
				<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-lock'">修改密码</a>
				<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-clear'">退出系统</a>
<!-- 				<select class="easyui-combobox" data-options="editable:false">
					<option value="0" selected="selected">中文</option>
					<option value="1">English</option>
				</select> -->
			</div>
		</div>
		
		<div region="west" split="true" title="导航菜单" id="naver">
			<div class="easyui-accordion" fit="true" id="navmenu">
				<div title="主菜单">
					<ul class="navmenu">
						<!-- <li><a href="#" data-url="listsearch.jsp">查询打分人员列表</a> -->
						<!-- <li><a href="#" data-url="regular.jsp">修改</a> -->
						<li><a href="#" data-url="part1.jsp">1、业绩目标</a></li>
						<li><a href="#" data-url="part2.jsp">2、工作能力与素质</a>
						<!-- <li><a href="#" data-url="admin.jsp">分数管理</a> -->
						<!-- <li><a href="#" data-url="">评分系统使用说明</a> -->
						<!-- <li><a href="#" data-url="">导出</a></li> -->
					</ul>
				</div>
				
			</div>
		</div>
		
		<div region="center" id="content">
			<div class="easyui-tabs" fit="true" id="tt">
				
				<div title="查询待评分人员" iconCls="icon-ok">
					<div style="width:80%;float:left;height:auto;">
					     <div class="flow-panel">
					       <div class="search-div" >
					       			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
									<!-- <label>您的工号：</label> -->
									<input type="text" class="easyui-textbox" id="inputvalue" />
									<button type="submit" class="easyui-linkbutton"  id="btn1" onclick="search();">查询</button>
									<!-- <input type="text" id="inputvalue" />
									<button type="submit" id="btn1" onclick="search();">查询</button> -->
						   </div>
				
					     </div>
				
						<table style="float:left;width:85px;">
						  <thead>
							<tr>
							  <th>第一组</th>
							</tr>
						  </thead>
						  <tbody id="one-result">
						  
						  </tbody>
						</table>
						<table style="float:left;width:85px;margin-left:8px;">
						  <thead>
							<tr>
							  <th>第二组</th>
							</tr>
						  </thead>
						  <tbody id="two-result">
						  </tbody>
						</table>
						<table style="float:left;width:85px;">
						  <thead>
							<tr>
							  <th>第三组</th>
							</tr>
						  </thead>
						  <tbody id="three-result">
						  
						  </tbody>
						</table>
						<table style="float:left;width:85px;margin-left:8px">
						  <thead>
							<tr>
							  <th>第四组</th>
							</tr>
						  </thead>
						  <tbody id="four-result">
						  
						  </tbody>
						</table>
						<table style="float:left;width:85px;">
						  <thead>
							<tr>
							  <th>第五组</th>
							</tr>
						  </thead>
						  <tbody id="five-result">
						  
						  </tbody>
						  </table>
						  <table  style="float:left;width:85px;margin-left:8px">
						  <thead>
							<tr>
							  <th>第六组</th>
							</tr>
						  </thead>
						  <tbody id="six-result">
						  
						  </tbody>
						</table>
						<table  style="float:left;width:85px;">
						  <thead>
							<tr>
							  <th>第七组</th>
							</tr>
						  </thead>
						  <tbody id="seven-result">
						  
						  </tbody>
						</table>
						
					  </div>
					
				</div>
				
			</div>
		</div>

		<div region="south" id="footer">中国专利技术开发公司IT事业部V1.0</div>
		

		
		

<script type="text/javascript">

	var page1=0;

    var one="";
    var two="";
    var three="";
    var four="";
    var five="";
    var six="";
    var seven="";
    
  	var temp=null;
	
	//生成不同分组名单
	var onelist = new Array();
	var twolist = new Array();
	var threelist = new Array();
	var fourlist = new Array();
	var fivelist = new Array();
	var sixlist = new Array();
	var sevenlist = new Array();

	
  	search = function(){
  		
  	  //清空
  	  onelist.length = 0;
  	  twolist.length = 0;
  	  threelist.length = 0;
  	  fourlist.length = 0;
  	  fivelist.length = 0;
  	  sixlist.length = 0;
  	  sevenlist.length = 0;
  	  
	  var empId = $("#inputvalue").val().toUpperCase();
	  var tabledata = [];
	  $.ajax({
			url:"queryById.do",
			type:"post",
			data:{'empId':empId,},
			success:function(data){
				$("#btn1").hide();
				//document.getElementById("btn1").disabled=true;
				tabledata = data;
				var obj = JSON.parse(tabledata);
				temp = obj;
				if(obj.length == 0){
					alert("没有该员工数据，请重新输入！");
				}else{
					one="";
				    two="";
				    three="";
				    four="";
				    five="";
				    six="";
				    seven="";
					for(var i=0;i<obj.length;i++){
						if(obj[i].groups == "1"){
							onelist.push(obj[i]);
							one += "<tr>" +
							"<td align='center'>" +
							obj[i].name +
							"</td></tr>";
						}else if(obj[i].groups == "2"){
							twolist.push(obj[i]);
							two += "<tr>" +
							"<td align='center'>" +
							obj[i].name +
							"</td></tr>";
						}else if(obj[i].groups == "3"){
							threelist.push(obj[i]);
							three += "<tr>" +
							"<td align='center'>" +
							obj[i].name +
							"</td></tr>";
						}else if(obj[i].groups == "4"){
							fourlist.push(obj[i]);
							four += "<tr>" +
							"<td align='center'>" +
							obj[i].name +
							"</td></tr>";
						}else if(obj[i].groups == "5"){
							fivelist.push(obj[i]);
							five += "<tr>" +
							"<td align='center'>" +
							obj[i].name +
							"</td></tr>";
						}else if(obj[i].groups == "6"){
							sixlist.push(obj[i]);
							six += "<tr>" +
							"<td align='center'>" +
							obj[i].name +
							"</td></tr>";
						}else if(obj[i].groups == "7"){
							sevenlist.push(obj[i]);
							seven += "<tr>" +
							"<td align='center'>" +
							obj[i].name +
							"</td></tr>";
						}
					}
				}
				$("#one-result").html("");
				$("#two-result").html("");
				$("#three-result").html("");
				$("#four-result").html("");
				$("#five-result").html("");
				$("#six-result").html("");
				$("#seven-result").html("");
				
				$("#one-result").append(one);
				$("#two-result").append(two);
				$("#three-result").append(three);
				$("#four-result").append(four);
				$("#five-result").append(five);
				$("#six-result").append(six);
				$("#seven-result").append(seven);
			},
			error:function(data){
				alert("error!");
			},
	  });
  };

</script>
		
		
	</body>
  
</html>
