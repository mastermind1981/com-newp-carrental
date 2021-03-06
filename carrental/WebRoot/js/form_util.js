$(function(){
	$('input[type=checkbox]:first').click(function(){
		if($(this).attr('checked') == 'checked'){
			$("input[type=checkbox]").attr('checked', 'checked');
		}else{
			$("input[type=checkbox]").attr('checked', null);
		}
	});

	$("input[type=checkbox]").not(":first").bind("click",function(event){
		$("input[type=checkbox]:first").attr("checked",null);
	});
	
	/* 当鼠标移到表格上是，当前一行背景变色 */
	$(".show tr td").mouseover(function(){
        $(this).parent().find("td").css("background-color","#def5fc");
    });
	/* 当鼠标在表格上移动时，离开的那一行背景恢复 */
	$(".show tr td").mouseout(function(){
        var bgc = $(this).parent().attr("bg");
        $(this).parent().find("td").css("background-color",bgc);
    });
	//改变偶数行背景色
    $(".show tr:odd td").css("background-color","#dfdfdf");
    $(".show tr:odd").attr("bg","#dfdfdf");
    $(".show tr:even").attr("bg","#fff");
    
    $(".content tr").bind("click",function(event){
		var element = $(event.target);
		if(element.is("td")){
			var box = element.parent().find("td:first").find("input[type=checkbox]");
			if(null != box && box.length != 0){
				box.unbind("click").click();
			}
		} 
	});
	
    /*$(".content tr").not(":first").hover(function(){
		$(this).find("td").each(function(index,item){
			$(item).addClass("list_table_hilite");
		});
	},function(){
		$(this).find("td").each(function(index,item){
			$(item).removeClass();
		});
	}).bind("click",function(event){
		var element = $(event.target);
		if(element.is("td")){
			var box = element.parent().find("td:first").find("input[type=checkbox]");
			if(null != box && box.length != 0){
				box.unbind("click").click();
			}
		} 
	});*/
});
//选中的复选框的值数组
function getSelectedIdArray(){
	var arry = new Array();
	var index = 0;
	$("input:checkbox").not(":first").each(function(){	
		if(this.checked){
			arry[index] = $(this).val();
			index++;
		}
	});
	return arry;
}
//获取表格中选中的值
function getSelectedArrayByName(name){
	var arry = new Array();
	var index = 0;
	var td;
	$("input:checkbox").not(":first").each(function(){	
		if(this.checked){
			td = $(this).parent("td").parent("tr").find("td");
			for(var i=0;i<td.length;i++){
				if(td.eq(i).attr('name') == name){
					if(name == 'id'){
						arry[index] = td.eq(i).find('input:checkbox').val();
					}else{
						arry[index] = td.eq(i).text();
					}
					index++;
				}
			}
		}
	});
	return arry;
}

//获取表格中选中的值(单选，多选默认显示第一条)
function getSelectedByName(name){
	var _val = "";
	$("input:checkbox").not(":first").each(function(){	
		if(this.checked){
			var td = $(this).parent("td").parent("tr").find("td");
			for(var i=0;i<td.length;i++){
				if(td.eq(i).attr('name') == name){
					if(name == 'id'){
						_val = td.eq(i).find('input:checkbox').val();
					}else{
						_val = td.eq(i).text();
					}
				}
			}
		}
	});
	return _val;
}
//选中的复选框的值数组
function array2String(arr){
	var names = "";
	for(var i in arr){
		names += arr[i]+",";
	}
	if(names.length > 0){
		return names.substring(0, names.length-1);
	}else{
		return "";
	}
}
//打开新窗口居中
function openwindow(url,name,iWidth,iHeight){
	var url; //转向网页的地址;
	var name; //网页名称，可为空;
	var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=0,menubar=0,scrollbars=1,location=0,status=0');
}

//两个时间进行比较(按日)
function DateDiff_Day(s1, s2) {
    return (s2-s1)>=0;   //day大于0表示s1大于s1
}