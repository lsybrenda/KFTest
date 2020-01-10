<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>考核人员列表查询</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.7.5/themes/default/easyui.css" />
  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.7.5/themes/icon.css" />
  <script type="text/javascript" src="jquery-easyui-1.7.5/jquery.min.js"></script>
  <script type="text/javascript" src="jquery-easyui-1.7.5/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="jquery-easyui-1.7.5/easyui-lang-zh_CN.js"></script>
  
</head>
<body>
	<div class="easyui-accordion" data-options="fit:true">
	  <div title="人员列表">
	    <div style="width:80%;float:left;height:auto;">
	     <div class="flow-panel">
	       <div class="search-div" >
	       			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
					<label>请输入您的工号：</label>
					<input type="text" class="easyui-textbox" id="inputvalue"/>
					<button type="submit" class="easyui-linkbutton"  id="btn1" onclick="search();">查询</button>
		   </div>

	     </div>

		<table style="float:left;width:100px;">
		  <thead>
			<tr>
			  <th>处级领导</th>
			</tr>
		  </thead>
		  <tbody id="chujileader-result">
		  
		  </tbody>
		</table>
		<table style="float:left;width:100px;margin-left:8px;">
		  <thead>
			<tr>
			  <th>科级领导</th>
			</tr>
		  </thead>
		  <tbody id="kejileader-result">
		  </tbody>
		</table>
		<table style="float:left;width:100px;">
		  <thead>
			<tr>
			  <th>综合管理部</th>
			</tr>
		  </thead>
		  <tbody id="zongheemp-result">
		  
		  </tbody>
		</table>
		<table style="float:left;width:100px;margin-left:8px">
		  <thead>
			<tr>
			  <th>IT事业部</th>
			</tr>
		  </thead>
		  <tbody id="itemp-result">
		  
		  </tbody>
		</table>
		<table style="float:left;width:100px;">
		  <thead>
			<tr>
			  <th>党委办公室</th>
			</tr>
		  </thead>
		  <tbody id="dangweiemp-result">
		  
		  </tbody>
		  </table>
		  <table  style="float:left;width:100px;margin-left:8px">
		  <thead>
			<tr>
			  <th>规划发展部</th>
			</tr>
		  </thead>
		  <tbody id="guihuaemp-result">
		  
		  </tbody>
		</table>
		
	  </div>	
	 </div>

	</div>
	
	
	
<script type="text/javascript">
	var empId;
    //记录名单tbody
    //处级领导
    var chujileader="";
    //科级领导
    var kejileader="";
    //综合管理部普通员工
    var zongheemp="";
    //IT事业部普通员工
    var itemp="";
    //党委办公室普通员工
    var dangweiemp="";
    //规划发展部普通员工
    var guihuaemp="";
  	var temp;
  	search = function(){
	  empId = $("#inputvalue").val();
	  var tabledata = [];
	  $.ajax({
			url:"queryById.do",
			type:"post",
			data:{'empId':empId,},
			success:function(data){
				tabledata = data;
				//alert(data);
				var obj = JSON.parse(tabledata);
				temp = obj;
				if(obj.length == 0){
					alert("没有该员工数据，请重新输入！");
				}else{		
					//公司领导只有下级一组处级干部
					if(obj[0].myposition == "总经理" || obj[0].myposition=="副总经理"){
						chujileader="";
						kejileader="";
						zongheemp="";
					    itemp="";
					    dangweiemp="";
					    guihuaemp="";
						for(var i=0;i<obj.length;i++){
							if(obj[i].position == "处级领导"){
								chujileader += "<tr>" +
								"<td align='center'>" +
								obj[i].name +
								"</td></tr>";
							}
						}
					}else if(obj[0].myposition == "处级领导"){
						chujileader="";
						kejileader="";
						zongheemp="";
					    itemp="";
					    dangweiemp="";
					    guihuaemp="";
						for(var i=0;i<obj.length;i++){
							if(obj[i].position == "处级领导"){
								chujileader += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "科级领导"){
								kejileader += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("综合") != -1){
								zongheemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("IT") != -1){
								
								itemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("党委") != -1){
								dangweiemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("规划") != -1){
								guihuaemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}
						}
					}else if(obj[0].myposition == "科级领导"){
						chujileader="";
						kejileader="";
						zongheemp="";
					    itemp="";
					    dangweiemp="";
					    guihuaemp="";
					    for(var i=0;i<obj.length;i++){
							if(obj[i].position == "处级领导"){
								chujileader += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "科级领导"){
								kejileader += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("综合") != -1){
								zongheemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("IT") != -1){
								itemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("党委") != -1){
								dangweiemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("规划") != -1){
								guihuaemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}
						}
					}else if((obj[0].mydepartment).indexOf("分类") != -1 || (obj[0].mydepartment).indexOf("加工") != -1){
						chujileader="";
						kejileader="";
						zongheemp="";
					    itemp="";
					    dangweiemp="";
					    guihuaemp="";
					    for(var i=0;i<obj.length;i++){
					    	if(obj[i].position == "科级领导"){
						    	kejileader += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
					    	}
					    }
					}else{
						chujileader="";
						kejileader="";
						zongheemp="";
					    itemp="";
					    dangweiemp="";
					    guihuaemp="";
					    for(var i=0;i<obj.length;i++){
					    	
					    	if(obj[i].position == "科级领导"){
					    		kejileader += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
					    	}else if(obj[i].position == "员工" && (obj[i].department).indexOf("综合") != -1){
					    		zongheemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
					    	}else if(obj[i].position == "员工" && (obj[i].department).indexOf("IT") != -1){
					    		itemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
					    	}else if(obj[i].position == "员工" && (obj[i].department).indexOf("党委") != -1){
								dangweiemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}else if(obj[i].position == "员工" && (obj[i].department).indexOf("规划") != -1){
								guihuaemp += "<tr>" +
								"<td align='center'>"+
								obj[i].name +
								"</td></tr>";
							}
					    }
					   
					}
				}
				
				$("#chujileader-result").html("");
				$("#kejileader-result").html("");
				$("#zongheemp-result").html("");
				$("#itemp-result").html("");
				$("#dangweiemp-result").html("");
				$("guihuaemp-result").html("");
				
				$("#chujilader-result").append(chujileader);
				$("#kejileader-result").append(kejileader);
				$("#zongheemp-result").append(zongheemp);
				$("#itemp-result").append(itemp);
				$("#dangweiemp-result").append(dangweiemp);
				$("#guihuaemp-result").append(guihuaemp);
			},
			error:function(data){
				alert("error!");
			},
	  });
  };

</script>

</body>

</html>