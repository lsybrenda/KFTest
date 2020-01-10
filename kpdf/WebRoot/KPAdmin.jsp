<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<title>分数管理</title>
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
</head>
<body>


		<div title="分数管理" iconCls="icon-ok">
			<div style="width:80%;float:left;height:auto;">
				<div class="flow-panel">
					       <div class="search-div" >
					       			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
									<label>请输入您的工号删除打分数据:</label>
									<input type="text" class="easyui-textbox" id="inputid" />
									<button type="submit" class="easyui-linkbutton"  id="btn_delete" onclick="deletescore();">删除</button>
						   </div>
						   <br>
						   <br>
						   <div class="search-div" >
					       			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
									<label>请输入您的工号查询加权总分:</label>
									<input type="text" class="easyui-textbox" id="emp" />
									<button type="submit" class="easyui-linkbutton"  id="btn_search" onclick="searchScore();">查询</button>
						   </div>
						   
				
			   </div>
			
			</div>
		
		</div>

<script type="text/javascript">

	//删除某员工的打分数据
	deletescore = function(){
		var id = $("#inputid").val();
		$.ajax({
			url:"deleteById.do",
			type:"post",
			data:{'empId':id},
			success:function(data){
				alert("删除成功!");
			},
			error:function(data){
				alert("error!");
			},	
		});
	};
	
	//查询某位员工的最后得分
	searchScore = function(){
		var emp = $("#emp").val();
		//alert(emp);
		$.ajax({
			url:"searchScoreById.do",
			type:"post",
			data:{'emp':emp},
			success:function(data){
				alert(data);
			},
			error:function(data){
				alert("error!");
			},	
		});
	};

</script>

</body>
</html>