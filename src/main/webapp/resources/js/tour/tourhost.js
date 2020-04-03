window.onload = function() {
	var touradminsel = document.getElementsByClassName('tourstatesel');
	for(var i = 0; i<touradminsel.length;i++) {		
		var selval = touradminsel[i].nextElementSibling.value;
		touradminsel[i].children[selval].selected = true;
	}
}

function detailinfo(obj) {
	var openstate = obj.dataset.openwin;
	
	if(openstate == 0) {
		var tourno = obj.dataset.tourno;
		
		var tempdata = {
				"tourno":tourno
			};
			
			$.ajax({
				url:"/tourapplist"
				,data : tempdata
				,dataType : "json"
				,contentType: "application/json;charset=utf-8"
				,success:function(data) {
					var result ='<tr><td colspan="5" style="width:100%; height:100px;">';
						result+='<div style="padding:20px 40px; width:100%; height:100%;"><p>';
					$.each(data,function(index,item){
						result += item.username;
						result += '  ';
					});
					result += '</p></div>';
					/*result += '<div style="width:100%; height:60%;">메시지 전송</div>';*/
					result += '</td></tr>';
					$(obj).parent().after(result);
				}
				,error : function(data) {
					alert("error : 수정실패");
				}
			});
			obj.dataset.openwin = 1;
	} else {
		$(obj).parent().next().remove();
		obj.dataset.openwin = 0;
	}
}

function changeState(tourno) {
	var tourselect = document.getElementById("tourstatesel"+tourno);
	var tempstate = tourselect.options[tourselect.selectedIndex].value;
	var tempdata = {
			"tourno":tourno
			,"tourstate":tempstate
	}
	
	$.ajax({
		url:"/tourupdatestate"
		,data : tempdata
		,dataType : "json"
		,contentType: "application/json;charset=utf-8"
		,success:function(data) {
			alert("수정 완료");
		}
		,error : function(data) {
			alert("error : 수정실패");
		}
	});
}