<%@page import="java.util.Map"%>
<%@include file="header.jsp"%>

	<% 
		String partyaddrsid = (String) request.getAttribute("partyAddrsid");
	
		Map<String, Object> orderidmap = EntityQuery.queryOne("ORDERDETAIL","ORDERADDRSID='"+partyaddrsid+"'");
		
		String orderid = (String)orderidmap.get("ORDERID");
		System.out.print("orderid in order_confirm-"+orderid);
		request.setAttribute("OrderID", orderid);
	%>

<section>
        <div class="container">
            <div class="row">
           	 <form action="Order_Confirm_Email" method="post">
           	 	<input type="hidden" value="<%=orderidmap.get("ORDERID")%>"  name="orderID"/>
                <div class="order_confirm">   
                    <h2 class="order_received"> YOUR ORDER HAS BEEN RECEIVED </h2>
                    <h3 class="order_thankyou"> Thank you for your order, it processing </h3>
                    <p class="order_id">Your order id is-<%=orderidmap.get("ORDERID")%></p>
                    <p> You will receive an order confirmation email with details of your order</p>
                
                    <button type="submit" class="btn_continue">CONTINUE</button>
                </div>
              </form>  	
            </div>
        </div>
    </section>

<%@include file="Footer.jsp"%>
