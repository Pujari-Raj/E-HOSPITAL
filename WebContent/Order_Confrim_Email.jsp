<%@page import="java.util.Map"%>
<%@include file="header.jsp"%>

	<% 
		String partyaddrsid = (String) request.getAttribute("partyAddrsid");
	
		Map<String, Object> orderidmap = EntityQuery.queryOne("ORDERDETAIL","ORDERADDRSID='"+partyaddrsid+"'");
		
		
		String orderid = (String) request.getAttribute("orderId");
	%>

		
	<section>
        <div class="container">
            <div class="row">
           	 	<div class="order_confirm">   
                    <p class="order_id">Your order id is-<%=orderid%></p>
                    <p> You will receive an order confirmation email with details of your order</p>
                
                    <a href="Services.jsp" class="btn_continue">CONTINUE</a>
                </div>
            </div>
        </div>
    </section>
			
	
<%@include file="Footer.jsp"%>