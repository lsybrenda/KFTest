<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>固定考核内容评分</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!-- 
  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.7.5/themes/default/easyui.css" />
  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.7.5/themes/icon.css" />
  <script type="text/javascript" src="jquery-easyui-1.7.5/jquery.min.js"></script>
  <script type="text/javascript" src="jquery-easyui-1.7.5/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="jquery-easyui-1.7.5/easyui-lang-zh_CN.js"></script> -->

<% String examiner = session.getAttribute("examinerId").toString(); %>

</head>
<body>
	<div class="easyui-accordion" data-options="fit:true">
	  <div title="人员列表">
	    <div style="width:80%;float:left;height:auto;">
	     <div class="flow-panel">
	       <div class="search-div" >
	       			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
					<label>您的工号为:</label>
					<input type="text" disabled="disabled" class="easyui-textbox" id="inputvalue_dafen" value="<%= examiner%>"/>
					<!-- <button type="submit" class="easyui-linkbutton"  id="btn1" onclick="search();">查询</button> -->
					<button type="submit" class="easyui-linkbutton"  id="btn2" onclick="start();">开始打分</button>
		   </div>
		   
	     </div>

	  </div>
	  <div style="width:80%;float:left;height:auto;">
		<!-- 数据表 -->
							
		<div id="examlist" style="display:none">
				<table id="kpitable" width="800" border="1" align="center" cellpadding="0" cellspacing="0" toolbar="#toolbar2" >
				    <tr>
				    	<td id="dftype" width="100%" colspan="8" align="center"></td>
				    </tr>
				    <tr>
    					<td id="title" width="100%" colspan="8" align="center"></td>
 					</tr>
 					<tr>
 					    <td width="100%" id="kpilist" align="center">
 					    	
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
						   <tbody id="table-result">
							  
						   </tbody>
							</table>
							</td>
 					</tr>
					
				</table>

		<div>
		  <button type="submit" class="easyui-linkbutton" id="bt_1" onclick="checkfenshuAll();">提交</button>
		  <button type="submit" class="easyui-linkbutton" id="bt_2" onclick="toNext();">下一项</button>
		</div>
		
		</div>
		
		<!-- /数据表 -->
	  </div>	



	  </div>

	</div>

	
	
<script type="text/javascript">

	var thisexaminer = $("#inputvalue_dafen").val();
    
    //记录名单tbody
    var str_leader="";
    var str_emp="";
    //记录页数
    var pagenumber = 0;
    //是否已提交当前页
    var tijiao = 0;
    //表头
    var tablenamelist = ['处级领导','科级领导','综合管理部普通员工','IT事业部普通员工','党委办公室普通员工','规划发展部普通员工'];
    //领导考核项
    var leadertitle = ['核心能力','工作态度'];
    //领导考核内容
	var leaderlist = ['1、解决问题能力 (运用观念、规则、一定的程序方法等对问题进行分析并提出解决方案)',
	            '2、团队建设能力(为了实现团队产出最大化而进行的一系列结构设计、团队优化行为)',
	            '3、培养他人能力(自发、真诚的去帮助他人提高工作上的技能、工作方法和能力素质等)',
	            '4、适应变化能力(对外部、内部变化快速反应并提出解决方案)',
	            '5、沟通协调能力(能妥善处理好上级、同级、下级的关系，调动各方面的工作积极性)',
	            '1、责任感强，尽职尽责',
	            '2、工作中具有服务意识',
	            '3、具有预见性、计划性'];
    //普通员工考核项
    var emptitle = ['工作能力','个人素质'];
	//普通员工考核内容
	var emplist = ['1、工作量(维持较高的工作效率)',
	               '2、工作质量(正确，有条理)',
	               '3、服务态度(提供快速的、有效的和有礼的服务)',
	               '4、责任感(能承担与岗位相称的责任)',
	               '5、组织能力(能有计划地安排好自己的工作)',
	               '6、团队精神(有效地同各部门沟通合作)',
	               '7、承受压力能力(能在压力下做好工作)',
	               '8、知识与应用(知识面广，并能正确运用到工作中)',
	               '1、行为(树立好榜样并对别人产生正面影响)',
	               '2、投入(尽最大努力做好工作，具有风险精神，忠于岗位)',
	               '3、正直(在工作中诚实、正直)',
	               '4、主动(显示出智慧和有创意，能够独立采取有效行动解决问题)'
	               ];
	
	//检查并一起提交分数
	function checkfenshuAll(){
		if(tijiao == 1){
			alert("当前打分页面已经提交！");
		}else{
			//打分项id
	    	var thiskpi = "";
	    	//当前页分数
	    	var fenshu = document.getElementsByName("fenshu");
	    	//考生姓名
	    	var candidate = $('[id=candidate]');
	    	//考生
	    	var jnumber = $('[id=jnumber]');
	    	if(pagenumber < 5){
				var page = pagenumber+1;
				thiskpi = "L1" + page;
			}else if(pagenumber >=5 && pagenumber < 8){
				var page = pagenumber-4;
				thiskpi = "L2" + page;
			}else if(pagenumber >=8 && pagenumber < 16){
				var page = pagenumber-7;
				thiskpi = "E1" + page;
			}else{
				var page = pagenumber-15;
				thiskpi = "E2" + page;
			}
	    	var sum = candidate.length;
	    	var zeroflag = 0;
	    	for(var i=0;i<sum;i++){
	    		if(parseInt(fenshu[i].value) == 0){
	    			zeroflag = 1;
	    			alert("打分项不能为0，请检查！");
	    			break;
	    		}
	    	}
	    	if(zeroflag == 0){
	    		//二维数组
		    	var datas = new Array(sum);
				for(var i=0;i<sum;i++){
					var str = "";
					str += thiskpi;
					str += ",";
					str += thisexaminer;
					str += ",";
					str += jnumber[i].innerText;
					str += ",";
					str += parseInt(fenshu[i].value);
					datas[i] = str;
				}
				
				$.ajax({
		    		url:"insertAllScore.do",
		    		type:"post",
		    		//traditional:true,
		    		data:{
		    			"arr":datas.toString()
		    		},
		    		success:function(data){
		    			//表示当前页面成功提交
		    			tijiao=1;
		    			alert("提交成功！");
		    		},
		    		error:function(data){
						alert("提交失败！");
					}
		    	});
	    	};
		};
	}
	

/* 	//检查并分条提交分数
    function checkfenshu(){
    	//打分项id
    	var thiskpi = "";
    	//当前页分数
    	var fenshu = document.getElementsByName("fenshu");
    	//考生姓名
    	var candidate = $('[id=candidate]');
    	//考生
    	var jnumber = $('[id=jnumber]');
		if(pagenumber < 5){
			var page = pagenumber+1;
			thiskpi = "L1" + page;
		}else if(pagenumber >=5 && pagenumber < 8){
			var page = pagenumber-4;
			thiskpi = "L2" + page;
		}else if(pagenumber >=8 && pagenumber < 16){
			var page = pagenumber-7;
			thiskpi = "E1" + page;
		}else{
			var page = pagenumber-15;
			thiskpi = "E2" + page;
		}
		var flag = 0;
    	for(var j=0;j<candidate.length;j++){
    		//考生姓名
    		thisname = candidate[j].innerText;
    		//得分
    		thisfenshu = parseInt(fenshu[j].value);
    		//考生ID
    		thiscandidate = jnumber[j].innerText;
    		if(thisfenshu == 0){
    			alert("打分项不能为0,请重新打分！");
    			break;
    		}else if(flag == 0){	
    			$.ajax({
    				url:"insertScore.do",
    				type:"post",
    				data:{'exaid':thiskpi,'examiner':thisexaminer,'candidate':thiscandidate,'score':thisfenshu},
    				success:function(data){
    					tijiao=1;
    				},
    				error:function(data){
    					flag = 1;
    					alert("提交失败!");
    				}
    			});
    			
    		}
    	}
    	if(flag == 0){
			alert("提交成功！");
		}
    } */
    
	function toNext(){
    	//alert(tijiao);
		var fenshu = document.getElementsByName("fenshu");
		for(var i=0;i<fenshu.length;i++){
			if((parseInt(fenshu[i].value))==0){
				alert("打分项不能为0,请重新打分！");
				return;
			}
		}
		if(tijiao == 0){
			alert("请先提交当前页打分结果！");
			return;
		}else{
			tijiao = 0;
			pagenumber += 1;
			var selectobjs = document.getElementsByName("fenshu");
			for(var i=0;i<selectobjs.length;i++){
				selectobjs[i].value="0";
			}
			if(pagenumber == 20){
				alert("该部分打分结束，进入下一部分！");	
			}else if(pagenumber == 16){
				document.getElementById("title").innerText = emptitle[1];
				document.getElementById("kpilist").innerText = emplist[pagenumber-8];
			}else if(pagenumber > 16 && pagenumber < 20){
				document.getElementById("title").innerText = emptitle[1];
				document.getElementById("kpilist").innerText = emplist[pagenumber-16];
			}else if(pagenumber > 8 && pagenumber < 16){
				document.getElementById("kpilist").innerText = emplist[pagenumber-8];
			}else if(pagenumber == 8){
				alert("该部分领导打分结束，进入普通员工部分！");
				$("#table-result").append(str_emp);
				document.getElementById("dftype").innerText = tablenamelist[1];
				document.getElementById("title").innerText = emptitle[0];
				document.getElementById("kpilist").innerText = emplist[0];
			}else if(pagenumber>4 && pagenumber <=7 ){
				document.getElementById("title").innerText = leadertitle[1];
				document.getElementById("kpilist").innerText = leaderlist[pagenumber];
			}else{
			    document.getElementById("kpilist").innerText = leaderlist[pagenumber];
			}
		}
		
	}


	//8分以上为高分段，限制不能超过百分之30的人数
	function getScore(){
		var objs1 = document.getElementsByName("fenshu");
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
			};
		};
		
		
	}
  
  var temp;
 
  function start(){
	  var id = thisexaminer;
	  
	  if(id == "" || id == null){
		  alert("请先输入您的工号查询考核名单！");
	  }else{
		  //从第二三项打分开始显示考核表格
		  document.getElementById("dftype").innerText = tablenamelist[0];
		  document.getElementById("title").innerText = leadertitle[0];
		  document.getElementById("kpilist").innerText = leaderlist[0];
		  $('#examlist').show();
		  for(var i=0;i<temp.length;i++){
				if(temp[i].position != "员工"){
					str_leader += "<tr>" +
					"<td style='display:none' id='jnumber'>" + temp[i].candidate + "</td>" +
					"<td width='50%' id='candidate'><p align='center'>"+ temp[i].name + "</p></td>" +
					"<td width='50%' id='score'><p align='center'><select style='font-size:24px' name='fenshu' onChange='getScore()'>"+
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
				}else{
					str_emp += "<tr>" +
					"<td style='display:none' id='jnumber'>" + temp[i].candidate + "</td>" +
					"<td width='50%' id='candidate'><p align='center'>"+ temp[i].name + "</p></td>" +
					"<td width='50%' id='score'><p align='center'><select style='font-size:24px' name='fenshu' onChange='getScore()'>"+
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
				};
			}

			$("#table-result").append(str_leader);
	  };
  };

</script>

</body>

</html>