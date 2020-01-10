<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>固定项打分表</title>

<% String examiner = session.getAttribute("examinerId").toString(); %>

<!-- <script type="text/javascript">
	$(document).ready(function(){
		start();
	});

</script> -->

</head>
<body>
	<body>
	<div class="easyui-accordion" data-options="fit:true">
	  <div title="人员列表">
	    <div style="width:80%;float:left;height:auto;">
	     <div class="flow-panel">
	     <input type="hidden" class="easyui-textbox" id="inputvalue_dafen" value="<%= examiner%>"/>
	       <%-- <div class="search-div" >
	       			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
					<input type="hidden" class="easyui-textbox" id="inputvalue_dafen" value="<%= examiner%>"/>
					<button type="submit" class="easyui-linkbutton"  id="btn_start" onclick="start();">开始本部分打分</button>
		   </div> --%>
		   <div class="search-div" >
	       			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
					<button type="submit" class="easyui-linkbutton"  id="btn_start" onclick="start();">开始本部分打分</button>
		   </div>
	     </div>

	  </div>
	  <div style="width:80%;float:left;height:auto;">
		<!-- 数据表 -->
							
		<div id="leaderdafen" style="display:none">
				<table id="kpitable" width="800" border="1" align="center" cellpadding="0" cellspacing="0" toolbar="#toolbar2" >
				    <tr>
    					<td id="leadertitle" width="100%" colspan="8" align="center" style="font-size:17px"></td>
 					</tr>
 					<tr>
 					    <td width="100%" id="leaderkpilist" align="center" style="font-size:17px">
 					    	
 					    </td>
 					</tr>
 					<tr>
 					    <td style="width:50%;padding:0 border-collapse:collapse">
 						<table width="100%" cellspacing=0 cellpadding=0  style="table-layout:fixed" id="table-result">
 						   <thead>
							  <tr>
							     <th width="50%"><p align="center" style="font-size:17px">姓名 </p></th>
							     <th width="50%"><p align="center" style="font-size:17px">得分</p></th>
							  </tr>
					       </thead>
						   <tbody id="leader-result">
							  
						   </tbody>
							</table>
							</td>
 					</tr>
					
				</table>
		<br>
		<p align="center" style="color:red;font-size:17px">提交后此项将无法返回修改，请谨慎检查后再提交！</p>
		<div style="text-align:center">
		  <button type="submit" class="easyui-linkbutton" id="bt_1" onclick="leadercheckfenshuAll();">提交并进入下一项</button>		  
		  <!-- <button type="submit" class="easyui-linkbutton" id="bt_leader" onclick="leadertoNext();">下一项</button> -->
		 <!--  <p><strong>(请先提交再进入下一项)</strong></p> -->
		</div>
		
		</div>
		
		<!-- /数据表 -->
		<!-- 普通员工打分表 -->
		<div id="empdafen" style="display:none">
				<table id="kpitable" width="800" border="1" align="center" cellpadding="0" cellspacing="0" toolbar="#toolbar2" >
				    <tr>
    					<td id="emptitle" width="100%" colspan="8" align="center" style="font-size:17px"></td>
 					</tr>
 					<tr>
 					    <td width="100%" id="empkpilist" align="center" style="font-size:17px">
 					    	
 					    </td>
 					</tr>
 					<tr>
 					    <td style="width:50%;padding:0 border-collapse:collapse">
 						<table width="100%" cellspacing=0 cellpadding=0  style="table-layout:fixed" id="table-result">
 						   <thead>
							  <tr>
							     <th width="50%"><p align="center" style="font-size:17px">姓名 </p></th>
							     <th width="50%"><p align="center" style="font-size:17px">得分</p></th>
							  </tr>
					       </thead>
						   <tbody id="emp-result">
							  
						   </tbody>
							</table>
							</td>
 					</tr>
					
				</table>
		<br>
		<p align="center" style="color:red;font-size:17px">提交后此项将无法修改，请谨慎检查后再提交！</p>
		<div style="text-align:center">
		  <button type="submit" class="easyui-linkbutton" id="bt_1" onclick="empcheckfenshuAll();">提交并进入下一项</button>
		  <!-- <button type="submit" class="easyui-linkbutton" id="bt_emp" onclick="emptoNext();">下一项</button> -->
		  <!-- <p><strong>(请先提交再进入下一项)</strong></p> -->
		</div>
		
		</div>		

		<!-- /普通员工打分表 -->
		
		</div>
	  </div>	
	  </div>

	</div>
	
<script type="text/javascript">


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

		var leaderkpilist = ["1.解决问题能力 (运用观念、规则、一定的程序方法等对问题进行分析并提出解决方案)",
		                     "2.团队建设能力(为了实现团队产出最大化而进行的一系列结构设计、团队优化行为)",
		                     "3.培养他人能力(自发、真诚的去帮助他人提高工作上的技能、工作方法和能力素质等)",
		                     "4.适应变化能力(对外部、内部变化快速反应并提出解决方案)",
		                     "5.沟通协调能力(能妥善处理好上级、同级、下级的关系，调动各方面的工作积极性)",
		                     "1.责任感强，尽职尽责",
		                     "2.工作中具有服务意识",
		                     "3.具有预见性、计划性"
		                     ];
		var empkpilist = ["1.工作量(维持较高的工作效率)",
		                  "2.工作质量(正确，有条理)",
		                  "3.服务态度(提供快速的、有效的和有礼的服务)",
		                  "4.责任感(能承担与岗位相称的责任)",
		                  "5.组织能力(能有计划地安排好自己的工作)",
		                  "6.团队精神(有效地同各部门沟通合作)",
		                  "7.承受压力能力(能在压力下做好工作)",
		                  "8.知识与应用(知识面广，并能正确运用到工作中)",
		                  "1.行为(树立好榜样并对别人产生正面影响)",
		                  "2.投入(尽最大努力做好工作，具有风险精神，忠于岗位)",
		                  "3.正直(在工作中诚实、正直)",
		                  "4.主动(显示出智慧和有创意，能够独立采取有效行动解决问题)"
		                  ];
		
		var leadertitle = ["核心能力","工作态度"];
		var emptile = ["工作能力","个人素质"];
		
		var str_one="";
		var str_two="";
		var str_three="";
		var str_four="";
		var str_five="";
		var str_six="";
		var str_seven="";
	
		var groupnumber = 0;
		if(onelist.length !=0){
			groupnumber +=1;
			for(var i=0;i<onelist.length;i++){
				str_one += "<tr>" +
				"<td style='display:none' id='jnumber'>" + onelist[i].candidate + "</td>" +
				"<td width='30%' height='42px' id='candidate'><p align='center' style='font-size:17px'>"+ onelist[i].name + "</p></td>" +
				"<td width='40%' id='score'><p align='center'><select style='font-size:24px' name='fenshu' onChange='getScore()'>"+
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
		}
		if(twolist.length !=0){
			groupnumber +=1;
			for(var i=0;i<twolist.length;i++){
				str_two += "<tr>" +
				"<td style='display:none' id='jnumber'>" + twolist[i].candidate + "</td>" +
				"<td width='50%' height='42px' id='candidate'><p align='center' style='font-size:17px'>"+ twolist[i].name + "</p></td>" +
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
			}
		}
		if(threelist.length !=0){
			groupnumber +=1;
			for(var i=0;i<threelist.length;i++){
				str_three += "<tr>" +
				"<td style='display:none' id='jnumber'>" + threelist[i].candidate + "</td>" +
				"<td width='50%' height='42px' id='candidate'><p align='center' style='font-size:17px'>"+ threelist[i].name + "</p></td>" +
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
			}
		}
		if(fourlist.length !=0){
			groupnumber +=1;
			for(var i=0;i<fourlist.length;i++){
				str_four += "<tr>" +
				"<td style='display:none' id='jnumber'>" + fourlist[i].candidate + "</td>" +
				"<td width='50%' height='42px' id='candidate'><p align='center' style='font-size:17px'>"+ fourlist[i].name + "</p></td>" +
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
			}
		}
		if(fivelist.length !=0){
			groupnumber +=1;
			for(var i=0;i<fivelist.length;i++){
				str_five += "<tr>" +
				"<td style='display:none' id='jnumber'>" + fivelist[i].candidate + "</td>" +
				"<td width='50%' height='42px' id='candidate'><p align='center' style='font-size:17px'>"+ fivelist[i].name + "</p></td>" +
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
			}
		}
		if(sixlist.length !=0){
			groupnumber +=1;
			for(var i=0;i<sixlist.length;i++){
				str_six += "<tr>" +
				"<td style='display:none' id='jnumber'>" + sixlist[i].candidate + "</td>" +
				"<td width='50%' height='42px' id='candidate'><p align='center' style='font-size:17px'>"+ sixlist[i].name + "</p></td>" +
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
			}
		}
		if(sevenlist.length !=0){
			groupnumber +=1;
			for(var i=0;i<sevenlist.length;i++){
				str_seven += "<tr>" +
				"<td style='display:none' id='jnumber'>" + sevenlist[i].candidate + "</td>" +
				"<td width='50%' height='42px' id='candidate'><p align='center' style='font-size:17px'>"+ sevenlist[i].name + "</p></td>" +
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
			}
		}
		
		var pagenumber = 0;
		
		function showNextGroup(groupnumber){
			$("#emp-result").html('');
			$("#leader-result").html('');
			pagenumber = 0;
			if(groupnumber != 0){
				var str;
				var groups;
				if(groupnumber == "1"){
					groups = onelist;
					str = str_one;
				}else if(groupnumber == "2"){
					groups = twolist;
					str = str_two;
				}else if(groupnumber == "3"){
					groups = threelist;
					str = str_three;
				}else if(groupnumber == "4"){
					groups = fourlist;
					str = str_four;
				}else if(groupnumber == "5"){
					groups = fivelist;
					str = str_five;
				}else if(groupnumber == "6"){
					groups = sixlist;
					str = str_six;
				}else if(groupnumber == "7"){
					groups = sevenlist;
					str = str_seven;
				}
				if(groups.length !=0){
					//如果是员工
					if(groups[0].position == "员工"){
						$("#emp-result").append(str);
						emptoNext();
					//如果是领导
					}else if(groups[0].position == "处级领导" || groups[0].position == "科级领导"){
						$("#leader-result").append(str);
						leadertoNext();
					}
				}
			}else{
				alert("该部分打分已完成!");
			}
		}
		function leadertoNext(){
			var fenshu = document.getElementsByName("fenshu");
			for(var i=0;i<fenshu.length;i++){
				fenshu[i].value=0;
			}
			/* document.getElementById("bt_leader").disabled=true;
			if(tijiao == 0){
				document.getElementById("bt_leader").disabled=true;
			} */
			if(tijiao == 1){
				tijiao = 0;
			}
			
			//从第二项开始
			if(pagenumber < 5){
				document.getElementById("leadertitle").innerText = "核心能力";
			    document.getElementById("leaderkpilist").innerText = leaderkpilist[pagenumber];
			    $('#leaderdafen').show();
			    pagenumber += 1;
			}else if(pagenumber > 4 && pagenumber < 8){
				document.getElementById("leadertitle").innerText = "工作态度";
				document.getElementById("leaderkpilist").innerText = leaderkpilist[pagenumber];
			    $('#leaderdafen').show();
				pagenumber += 1;
			}else{
				groupnumber -= 1;
				if(groupnumber != 0){
					alert("进入下一组打分!");
					$('#leaderdafen').hide();
					showNextGroup(groupnumber);
				}else{
					$('#leaderdafen').hide();
					
					alert("该部分打分已完成!");
				}

			}
		}
		function emptoNext(){
			var fenshu = document.getElementsByName("fenshu");
			for(var i=0;i<fenshu.length;i++){
				fenshu[i].value=0;
			}
			//document.getElementById("bt_leader").disabled=true;
			/* if(tijiao == 0){
				document.getElementById("bt_emp").disabled=true;
			} */
			if(tijiao == 1){
				tijiao = 0;
			}
			//第二项
			if(pagenumber < 8){
			    document.getElementById("emptitle").innerText = "工作能力";
			    document.getElementById("empkpilist").innerText = empkpilist[pagenumber];
			    $('#empdafen').show();
			    pagenumber += 1;
			}else if(pagenumber >7 && pagenumber < 12){
				document.getElementById("emptitle").innerText = "个人素质";
				document.getElementById("empkpilist").innerText = empkpilist[pagenumber];
			    $('#empdafen').show();
				pagenumber += 1;
			}else{
				groupnumber -= 1;
				if(groupnumber != 0){
					alert("进入下一组打分!");
					$('#empdafen').hide();
					showNextGroup(groupnumber);
				}else{
					$('#empdafen').hide();
					//固定项打分已完成

					alert("该部分打分已完成!");
				}
			}
		}
		
		function start(){
			if(page1 == 0){
				alert("请先完成业绩目标部分打分！");
			}else{
				pagenumber = 0;
				showNextGroup(groupnumber);
				$("#btn_start").hide();
			}
		}
		
		
		var thisexaminer = $("#inputvalue_dafen").val();
		var tijiao=0;
		
		//当前项总分
		var totals = 0;
		
		function leadercheckfenshuAll(){
			//当前页分数
			var fenshu = document.getElementsByName("fenshu");
			for(var i=0;i<fenshu.length;i++){
				if((parseInt(fenshu[i].value))==0){
					alert("打分项不能为0,请重新打分！");
					return;
				}
			}
			if(tijiao == 1){
				alert("当前页面已提交!");
			}else{

				//当前项id
				var thiskpi; 
				//考生姓名
		    	var candidate = $('[id=candidate]');
		    	//考生id
		    	var jnumber = $('[id=jnumber]');
		    	//当前打分人数
		    	var sum = candidate.length;
		    	//是否有零分项
		    	var zeroflag2 = 0;
		    	var page;
		    	if(pagenumber<= 5){
		    		page = pagenumber;
		    		thiskpi = "RL2" + page;
		    	}else if(pagenumber > 5 && pagenumber <= 8){
		    		page = pagenumber - 5;
		    		thiskpi = "RL3" + page;
		    	}
		    	
		    	for(var i=0;i<sum;i++){
		    		if(parseInt(fenshu[i].value) == 0){
		    			zeroflag2 = 1;
		    			alert("打分项不能为0，请检查！");
		    			break;
		    		};
		    	}
		    	if(zeroflag2 == 0){
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
			    			leadertoNext();
			    			//document.getElementById("bt_leader").disabled=false;
			    		},
			    		error:function(data){
							alert("提交失败！");
						}
			    	});
			};
		};
	}
		function empcheckfenshuAll(){
			//当前页分数
			var fenshu = document.getElementsByName("fenshu");
			for(var i=0;i<fenshu.length;i++){
				if((parseInt(fenshu[i].value))==0){
					alert("打分项不能为0,请重新打分！");
					return;
				}
			}
			if(tijiao == 1){
				alert("当前页面已提交!");
			}else{
				//当前项id
				var thiskpi; 
				//考生姓名
		    	var candidate = $('[id=candidate]');
		    	//考生id
		    	var jnumber = $('[id=jnumber]');
		    	//当前打分人数
		    	var sum = candidate.length;
		    	//是否有零分项
		    	var zeroflag2 = 0;
		    	var page;
		    	if(pagenumber<=8){
		    		page = pagenumber;
		    		thiskpi = "RE2" + page;
		    	}else if(pagenumber >8 && pagenumber <= 12){
		    		page = pagenumber - 8;
		    		thiskpi = "RE3" + page;
		    	}
		    	
		    	if(zeroflag2 == 0){
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
			    			emptoNext();
			    			
			    			//document.getElementById("bt_emp").disabled=false;
			    		},
			    		error:function(data){
							alert("提交失败！");
						}
			    	});
			};
		};
	}
		
		



</script>

</body>
</html>