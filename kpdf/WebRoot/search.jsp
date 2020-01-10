<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>考核打分系统</title>
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
		<div title="打分列表">
			<div class="flow-panel">
			
				<!-- 数据表工具栏 -->
				<div class="toolbar" id="toolbar2">
					<div class="search-div">
									
						<label>工号：</label>
					    <input type="text" class="easyui-textbox" id="inputvalue" />
					    <button type="submit" class="easyui-linkbutton"  id="btn" onclick="subbtn();">查询</button>
				
					</div>
				</div>
				<!-- /数据表工具栏 -->
				<!-- 名单表 -->
				
				<!-- 数据表 -->
							

				<table width="800" border="1" align="center" cellpadding="0" cellspacing="0" toolbar="#toolbar2" >
				    <tr>
    					<td width="100%" colspan="8"><p align="center"><strong>核心能力</strong><strong> </strong></p></td>
 					</tr>
 					<tr>
 					    <td width="100%">
 					    	<p align="center">1、解决问题能力 (运用观念、规则、一定的程序方法等对问题进行分析并提出解决方案)</p>
 					    </td>
 					</tr>
 					<tr>
 					    <td style="width:50%;padding:0 border-collapse:collapse">
 						<table width="100%" cellspacing=0 cellpadding=0  style="table-layout:fixed" id="table-result">
 						   <thead>
							  <tr>
							     <th width="50%"><p align="center">姓名 </p></th>
							     <th width="50%"><p align="center">得分</p></th>
							  </tr>
					       </thead>
						   <tbody id="tbody-result">
							  
						   </tbody>
							</table>
							</td>
 					</tr>
					
					<tr>
    					<td width="100%" colspan="8"><p align="center"><strong>工作态度</strong><strong> </strong></p></td>
 					</tr>
					
				</table>

				<!-- /数据表 -->
							
							
			</div>

		</div>
						
	</div>

<script type="text/javascript">

	//8分以上为高分段，限制不能超过百分之30的人数
	function getScore(){
		var objs1 = document.getElementsByName("fenshu1");
		var length = objs1.length;
		//最大高分人数
		var max = Math.round(length*0.3);
		
		var temp = 0;
		if(max == 0){
			max+=1;
		}
		for(var i=0;i<length;i++){
			if((parseInt(objs1[i].value))>=8 && (parseInt(objs1[i].value)) <=10){
				temp+=1;
			}
			if(temp > max){
				alert("超出高分人数30%比例限制，请修改！");
				objs1[i].value = 0;
				break;
			}
		}
		
		
	}
	
	function printpage(){
		window.print();	
	}
    
	subbtn = function(){
		var empId = $("#inputvalue").val();
		var tabledata = [];
		$.ajax({
			url:"queryById.do",
			type:"post",
			data:{'empId':empId,},
			success:function(data){
				tabledata = data;
				var str="";
				var obj = JSON.parse(tabledata);
				for(var i=0;i<obj.length;i++){

					str += "<tr>" +
					"<td width='50%'><p align='center'>"+ obj[i].name + "</p></td>" +
					"<td width='50%'><p align='center'><select style='font-size:24px' name='fenshu1' onChange='getScore()'>"+
					"<option value='0' selected></option>" +
					"<option value='1'>1</option>" +
					"<option value='2'>2</option>" +
					"<option value='3'>3</option>" +
					"<option value='4'>4</option>" +
					"<option value='5'>5</option>" +
					"<option value='6'>6</option>" +
					"<option value='7'>7</option>" +
					"<option value='8'>8</option>" +
					"<option value='9'>9</option>" +
					"<option value='10'>10</option>" +
					"</select></p></td>" +
					"</tr>";

				}
				$("#table-result").append(str);
				
				
			},
			error:function(data){
				alert("error!");
			}
		}); 
	};


</script>


</body>
</html>