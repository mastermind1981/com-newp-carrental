<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>角色配置管理</title>
		<base href="<%=basePath%>">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>plugin/jquery-impromptu/jquery-impromptu.css">
		<link href="<%=basePath%>css/admin/style.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/form_util.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/pager.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-impromptu/jquery-impromptu.js"></script>
		<script type="text/javascript">
			$(function(){
				//清空
				$("#clearForm").click(function(){
					$("#role_roleName").val('');
				});
				//查询
				$("#query").click(function(){
					pageLoad();
				});
				//新增
				$("#add").click(function(){
					$.show('新增系统角色','<%=basePath%>role/toRoleEdit?id=',550,400,"A");
				});
				//修改
				$("#update").click(function(){
					var ids = getSelectedIdArray();
					if(ids.length==1){
						$.show('修改系统角色','<%=basePath%>role/toRoleEdit?id='+ids[0],550,400,'A');
					}else{
						$.prompt('请选择一条数据',{
							title: '提示',
		        			buttons: { "确认": false}
		        		});
					}
				});
				//删除
				$("#del").click(function(){
					var ids = getSelectedIdArray();
					if(ids.length==0){
						$.prompt('请选择至少一条数据',{
							title: '提示',
		        			buttons: { "确认": false}
		        		});
					}else{
						$.prompt(
							{state0:{
								html: '确定要删除吗',
			        			buttons: { "确认": 1, "取消": 0},
			        			submit:function(e,v,m,f){
			        				e.preventDefault();
			        				if(v==0){
			        					$.prompt.close();
			        				}else if(v==1){
			        					$.post("<%=basePath%>role/doRoleDelete", 
			        						{
			        							"ids": array2String(getSelectedIdArray()),
			        							"names":array2String(getSelectedArrayByName("roleName"))
			        						}, function(data){
						   					if(data.result=="SUCCESS"){
						   						$.prompt.goToState('state1', true);
						   						return false;
						   					}else{
						   						alert(data.result);
						   						//$.prompt.goToState('state2', true);
						   						return false;
						   					}
						   				}, "json");
			        				}
			        			}
			        		},
			        		state1:{
			        			html: '操作成功!点击确定返回列表',
			        			buttons: { "确认": true},
			        			submit:function(e,v,m,f){
			        				e.preventDefault();
			        				if(v){
			        					$.prompt.close();
			        					pageLoad();
			        				}
			        			}
			        		},
			        		state2:{
			        			html: '操作失败',
			        			buttons: { "确认": true},
			        			submit:function(e,v,m,f){
			        				e.preventDefault();
			        				if(v){
			        					$.prompt.goToState('state0');
			        				}
			        			}
			        		}}
						);
					}
				});
			});
			//重新提交表单刷新页面
			function pageLoad(){
				$("#queryForm").submit();
			}
			function showDetail(id){
				$.show('角色详细信息','<%=basePath%>role/toRoleDetail?id='+id,550,400,'A');
			}
		</script>
	</head>
	<body>
	<form action="<%=basePath%>role/showRoleList" id="queryForm">
	<div class="maintitle">
		<div class="placenav">当前位置：<a href="javascript:void(0);">首页</a>&gt;角色配置管理</div>
		<h1>角色配置管理</h1>
	</div>
	<div class="button_nde">
		角色名称：<input type="text" id="role_roleName" name="roleName" value="${role.roleName}" class="input"/>
	    <input type="button" id="query" class="btn" value="查询">
		<input type="button" id="clearForm" class="btn" value="清空">
	</div>
	<div class="button_nde">
		<a href="javascript:void(0);" id="add"><span>新增</span></a>
		<a href="javascript:void(0);" id="update"><span>修改</span></a>
		<a href="javascript:void(0);" id="del"><span>删除</span></a>
		<h6 class="clear"></h6>
	</div>
	<div class="content">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="show">
			<tr>
				<th width="20"><input type="checkbox" name="checkbox" id="checkbox" /></th>
				<th>角色名称</th>
				<th>监管城市</th>
			</tr>
			<c:forEach items="${roles}" var="parent">
			<tr>
				<td name="id" align="center"><input type="checkbox" value="<c:out value="${parent.id}"/>"/></td>
				<td name="roleName" align="center"><a href="javascript:void(0);" style="color: blue;" onclick="showDetail('${parent.id}')"><c:out value="${parent.roleName}"/></a></td>
				<td name="city" align="center">
					<c:choose>
                		<c:when test="${parent.city == null or parent.city.id == ''}">所有城市</c:when>
                		<c:otherwise>${parent.city.cityName}</c:otherwise>
                	</c:choose>
                </td>
			</tr>
			</c:forEach>
		</table>
		<%@ include file="../common/pager.jsp"%>
	</div>
	</form>
	</body>
</html>