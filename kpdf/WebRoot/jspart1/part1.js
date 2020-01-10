//var divCount =0;

function getValue(userid){
	var fenshu = 0;
	var objs = $("."+userid);
	for (var i=0;i<objs.length;i++){
		thisfenshu = objs[i].value;
		fenshu = fenshu + parseInt(thisfenshu);
	}
	$('#'+userid+"span1").text(fenshu);
	$('#'+userid+"span11").text(Math.round(fenshu/(objs.length)*8));
}

function getSendScore(exa_id,userid,obj,sign_userid){

	$("."+sign_userid).val($(obj).val());
	var thisname = $(obj).attr("name");
	var thispagesigeselects = $("[name='"+thisname+"']");
	var num = Math.round(thispagesigeselects.length/3);
	var x = 0;
	for (var i =0;  i <thispagesigeselects.length ; i++){
		if($(thispagesigeselects[i]).val() >7){
			x++;
			if(x>num){
				alert("相同类目,高分得分者人数不得超过百分之三十！");
				$(obj).val("0");
				return;
			}
		}
	}
	$('#'+exa_id).val($(obj).val());
	getValue(userid);
}
function printpage(){
	window.print();	
}


var curr = 1;
function goLeft(){
	if(divCount == 0){
		divCount = $("div[id^='divstep']").length;
	}
	
	if(curr>1){
		$('#divstep'+curr).hide();
   		curr--;
   		$('#divstep'+curr).show();
	}
}

function goRight(){
	if(divCount == 0){
		divCount = $("div[id^='divstep']").length;
	}
/*	if(curr == divCount){
		$('#buttonplay').show();
	}*/
	if(curr<divCount){
        $('#divstep'+curr).hide();
        curr++;
        $('#divstep'+curr).show();
	}
}


