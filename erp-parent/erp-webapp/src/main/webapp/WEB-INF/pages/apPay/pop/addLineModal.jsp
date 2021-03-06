<%--

    Copyright 2020-2021 redragon.dongbin
 
    This file is part of redragon-erp/赤龙ERP.

    redragon-erp/赤龙ERP is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    redragon-erp/赤龙ERP is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with redragon-erp/赤龙ERP.  If not, see <https://www.gnu.org/licenses/>.
	
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<div class="modal" id="addLineDiv" tabindex="-1" role="dialog" aria-hidden="true" >

	<div class="modal-dialog" role="document" style="max-width: 800px;">

		<div class="modal-content animated bounceInRight" >

			<div class="modal-header">
				<h4 class="modal-title">核销行编辑</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>

			<div class="modal-body" style="padding-bottom: 20px;">
				<%-- 导入提示信息框 --%>
				<c:if test="${hint!=null&&hint!=''}">
			   		<jsp:include page="../../common/alert/alert.jsp">
			   			<jsp:param value="${hint}" name="alertType"/>
			   			<jsp:param value="${alertMessage}" name="alertMessage"/>
			   		</jsp:include>
			    </c:if>
			
				<form id="lineForm">
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">发票编码</label>
						<div class="col-sm-4">
							<input id="invoiceHeadCode" name="invoiceHeadCode" type="text" class="form-control" value="${requestScope.payLine.invoiceHeadCode}" readonly="readonly">
						</div>
						
						<label class="col-sm-2 col-form-label">采购订单编码</label>
						<div class="col-sm-4">
							<input id="poHeadCode" type="text" class="form-control" value="${requestScope.payLine.poHeadCode}" readonly="readonly">
						</div>
					</div>
					<div class="hr-line-dashed"></div>
					
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">发票参考号</label>
						<div class="col-sm-4">
							<input id="referenceNumber" type="text" class="form-control" value="${requestScope.payLine.referenceNumber}" readonly="readonly">
						</div>
						
						<label class="col-sm-2 col-form-label">发票日期</label>
						<div class="col-sm-4">
							<input id="invoiceDate" type="text" class="form-control" value="<fmt:formatDate value="${requestScope.payLine.invoiceDate}" pattern="yyyy-MM-dd"/>" readonly="readonly">
						</div>
					</div>
					<div class="hr-line-dashed"></div>
				
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">发票金额</label>
						<div class="col-sm-4 input-group">
							<input id="invoiceAmount" type="text" class="form-control" value="${requestScope.payLine.invoiceAmount}" readonly="readonly">
							<span class="input-group-addon">(元)</span>
						</div>

						<label class="col-sm-2 col-form-label">发票税额</label>
						<div class="col-sm-4 input-group">
							<input id="taxAmount" type="text" class="form-control" value="${requestScope.payLine.taxAmount}" readonly="readonly">
							<span class="input-group-addon">(元)</span>
						</div>
					</div>
					<div class="hr-line-dashed"></div>
					
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">发票已核销金额</label>
						<div class="col-sm-4 input-group">
							<input id="invoicePaidAmount" type="text" class="form-control" value="${requestScope.payLine.invoicePaidAmount}" readonly="readonly">
							<span class="input-group-addon">(元)</span>
						</div>
					
						<label class="col-sm-2 col-form-label"><span class="text-danger">*</span>核销金额</label>
						<div class="col-sm-4">
							<input id="invoicePayAmount" name="invoicePayAmount" type="text" class="form-control" value="${requestScope.payLine.invoicePayAmount}">
						</div>
					</div>
					<div class="hr-line-dashed"></div>
					
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">摘要</label>
						<div class="col-sm-10">
							<input id="payLineMemo" name="memo" type="text" class="form-control" value="${requestScope.payLine.memo}">
						</div>
					</div>
					<div class="hr-line-dashed"></div>

					<div class="form-group row m-b-none">
						<div class="col-sm-12 col-sm-offset-2 text-right">
							<button class="btn btn-white btn-lg" type="button"
								data-dismiss="modal">返回</button>
							&nbsp;
							<button
								class="ladda-button ladda-button-demo btn btn-primary btn-lg"
								data-style="expand-right">
								&nbsp;&nbsp;确定&nbsp;&nbsp;<i class="fa fa-check-square-o"></i>
							</button>
						</div>
					</div>
					
					<input type="hidden" id="payHeadCode" name="payHeadCode" value="${param.payHeadCode}"> 
					<input type="hidden" id="payLineId" name="payLineId" value="${requestScope.payLine.payLineId}"> 
					<input type="hidden" id="payLineCode" name="payLineCode" value="${requestScope.payLine.payLineCode}"> 
					<input type="hidden" id="createdDate" name="createdDate" value="${requestScope.payLine.createdDate}"> 
					<input type="hidden" id="createdBy" name="createdBy" value="${requestScope.payLine.createdBy}">
				</form>
			</div>

		</div>

	</div>

</div>


<script>
	$(document).ready(function() {
		//表单提交
		var l = $('.ladda-button-demo').ladda();

		l.click(function() {
			$("#lineForm").valid();
			//l.ladda('stop');
		});

		$("#lineForm").validate({
			rules : {
				invoicePayAmount : {
					required : true,
					number : true,
					gtZero : true,
				},
			},
			submitHandler: function(form) {
				var invoicePayAmount = $("#invoicePayAmount").val();
				var invoiceAmount = $("#invoiceAmount").val();
				var taxAmount = $("#taxAmount").val();
				var invoicePaidAmount = $("#invoicePaidAmount").val();
				if($.isNumeric(invoicePayAmount)&&$.isNumeric(invoiceAmount)&&$.isNumeric(taxAmount)&&$.isNumeric(invoicePaidAmount)){
					if(parseFloat(invoicePayAmount)>redragonJS.numberSub(redragonJS.numberAdd(parseFloat(invoiceAmount), parseFloat(taxAmount)),invoicePaidAmount)){
						redragonJS.alert("核销金额("+invoicePayAmount+")不能大于发票金额("+invoiceAmount+"+"+taxAmount+"-"+invoicePaidAmount+")");
					}else{
						l.ladda('start');
						editLine();
					}
				}
		    }
		});
		
	});
	
	//异步编辑付款行
	function editLine(){
		redragonJS.loading("ibox-content1");
		
		$.ajax({
			type: "post",
			url: "web/apPayLine/editApPayLine",
			data: {"invoiceHeadCode": $("#invoiceHeadCode").val(), "invoicePayAmount": $("#invoicePayAmount").val(), "memo": $("#payLineMemo").val(), 
				   "payHeadCode": $("#payHeadCode").val(), "payLineId": $("#payLineId").val(),
				   "payLineCode": $("#payLineCode").val(), "createdDate": $("#createdDate").val(), "createdBy": $("#createdBy").val()},
			async: false,
			dataType: "html",
			cache: false,
			success: function(data){
				redragonJS.removeLoading("ibox-content1");
				$('#addLineDiv').modal('hide');
				$('.ladda-button-demo').ladda('stop');
				
				var json = JSON.parse(data);
				if(json.result=="success"){
					getLineTab($("#payHeadCode").val());
				}else{
					redragonJS.alert("编辑行信息错误");
				}
				
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				redragonJS.alert(textStatus);
			}
		});
	}
	
</script>
