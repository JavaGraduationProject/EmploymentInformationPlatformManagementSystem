﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="law.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>招聘信息</title>
    <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/combo/combo.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.theme.default.css" rel="stylesheet"
        type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/treetable/js/jquery.treetable.js" type="text/javascript"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			$(function() {
				$("#btnDelete").click(function(){
				       var ids = $(".check[type=checkbox]:checked").serialize();
						 if($(".check:checked").length<1)
					        {
					           $.dialog.alert("请选择需要删除条目");
					           return;
					        } 
						if(!confirm("你确定要删除吗")){
							return;
						}
						$.ajax({
				                   url: "${pageContext.request.contextPath}/admin/zhaopinmanager.do?actiontype=delete",
				                     method: 'post',
				                     data: ids,
				                     success: function (data) {
				                          window.location.reload();
				                     },
				                     error: function (XMLHttpRequest, textStatus, errorThrown) {
				                         alert(XMLHttpRequest.status + errorThrown);
				                     }
				                 });
				    });
			    $("#btnCheckAll").click(function(){
			           var ischeck=false;
			           $(".check").each(function(){
			               if($(this).is(":checked"))
			               {
			                  $(this).prop("checked","");
			                  ischeck=false;
			                }
			               else
			               {
			                  $(this).prop("checked","true");
			                  ischeck=true;
			                }
			           });
			           if($(this).text()=="选择记录")
			              $(this).text("取消选择");
			           else
			              $(this).text("选择记录");
			    })
			});
       </script>
	</head>
	 <body >
	<div class="search-title">
		<h2>招聘管理</h2>
		<div class="description">
			
		</div>
	</div>
	<!-- 搜索控件开始 -->
	<div class="search-options">
		<form id="searchForm"
			action="${pageContext.request.contextPath}/admin/zhaopinmanager.do"
			method="post">
			<table cellspacing="0" width="100%">
				<tbody>
					<tr>
						<td>职位名称 <input name="title" value="${title}"
							class="input-txt" type="text" id="title" /> <input
							type="hidden" name="actiontype" value="search" /> <input
							type="hidden" name="seedid" value="${seedid}" /> <input
							type="hidden" name="forwardurl" value="/qiye/zhaopinmanager.jsp" />
							<button class="orange-button">搜索</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- 搜索控件结束 -->
	<div class="clear"></div>
	<div class="action-details">
		<span class="orange-href" id="btnCheckAll">选择</span> <span
			id="btnDelete" class="orange-href"> 删除 </span>
	</div>
	<table id="zhaopin" width="100%" border="0" cellspacing="0"
		cellpadding="0" class="ui-record-table">
		<thead>
			<tr>
				<th>选择</th>
				<th><b>职位名称</b></th>
				<th><b>岗位类别</b></th>
				<th><b>发布人</b></th>
				<th><b>发布时间</b></th>
				<th><b>职位待遇</b></th>
				<th><b>工作地</b></th>
				<th><b>最低学历</b></th>
				<th><b>招聘人数</b></th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${listzhaopin== null || fn:length(listzhaopin) == 0}">
				<tr>
					<td colspan="20">没有相关招聘信息</td>
				</tr>
			</c:if>
			<%	
								        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
									if(request.getAttribute("listzhaopin")!=null)
								      {
									  List<Zhaopin> listzhaopin=( List<Zhaopin>)request.getAttribute("listzhaopin");
								     for(Zhaopin  temzhaopin  :  listzhaopin)
								      {
							%>
			<tr>
				<td>&nbsp<input id="chk<%=temzhaopin.getId()%>" class="check"
					name="ids" type="checkbox"
					value='<%=temzhaopin.getId()%>'/></td>
				<td><%=temzhaopin.getTitle()%></td>
				<td><%=temzhaopin.getGwtype()%></td>
				<td><%=temzhaopin.getPubren()%></td>
				<td><%=sdf.format(temzhaopin.getPubtime())%></td>
				<td><%=temzhaopin.getDaiyu()%></td>
				<td><%=temzhaopin.getGzdi()%></td>
				<td><%=temzhaopin.getXueli()%></td>
				<td><%=temzhaopin.getRenshu()%></td>
				<td><a class="orange-href"
					href="${pageContext.request.contextPath}/admin/zhaopinmanager.do?actiontype=load&id=<%=temzhaopin.getId()%>&forwardurl=/qiye/zhaopinadd.jsp">修改</a>
					<a class="orange-href"
					href="${pageContext.request.contextPath}/qiye/zhaopindetails.jsp?id=<%=temzhaopin.getId()%>">查看</a>
					<a class="orange-href" 
									   href="${pageContext.request.contextPath}/admin/yingpinmanager.do?actiontype=get&zpid=<%=temzhaopin.getId()%>&forwardurl=/qiye/yingpinmanager.jsp">查看应聘者
					</a>
				</td>
			</tr>
			<%}}%>
		</tbody>
	</table>
	<div class="clear"></div>
	<daowen:pager id="pager1" attcheform="searchForm" />
</body>
</html>
