<%@page import="java.util.List"%>
<%@page import="com.learning.hospital.Utility"%>
<%@page import="com.hospital.productServices.ProductServices"%>
<%@page import="java.util.Map"%>
<%@include file="header.jsp"%>

<section class="product_review">
	<!--  
	 <p> PARTYADDRSID = <%=request.getAttribute("PARTYADDRSID")%></p> 
	-->  
	<% 
		Map<String, Object> orderdeatilMap =  (Map<String, Object>)request.getAttribute("OrderDetailMap");
		
	String custeml = (String)session.getAttribute("customer");
	
	//Getting email of user for getting user details
	Map<String, Object> partyMap = EntityQuery.queryOne("PARTY","EMAIL='"+custeml+"'"); 
	
			
	//fetching partyaddress accrdng to partyid  		
	List<Map<String, Object>> postalidMap = EntityQuery.queryList("PARTYADDRESS","PARTYID='"+partyMap.get("PARTYID")+"'"); 
	
		
	%>
	<form id="hidden_form" action="OrderConfirmation" method="post">
		<input type="hidden" value="<%=orderdeatilMap.get("productid")%>" name="orderproductid">
		<input type="hidden" value="<%=orderdeatilMap.get("slotDate")%>" name="SDate">
		<input type="hidden" value="<%=(String)orderdeatilMap.get("slotTime")%>" name="STime">
		
	<%	
		if(request.getParameter("partyaddrsid")!=null)
		{
	%>		
			<input type="hidden" value="<%=request.getParameter("partyaddrsid")%>" name="partyaddrsid">
		<% 				
		}
		
		else
		{
			%>
			
			<input type="hidden" value="<%=postalidMap.get(postalidMap.size()-1).get("PARTYADDRSID")%>" name="partyaddrsid">
	<% 
		}
	%>
	
		<!-- new code(added at submission day) -->
	<%
		if(orderdeatilMap.get("paymentoptn")==null ||  orderdeatilMap.get("paymentoptn").equals(""))
		{
	%>	
			<input type="hidden" value="paymentAppt" name="paymentOptn">
				
	<%		
		}
		else{
	%>	
			<input type="hidden" value="<%=orderdeatilMap.get("paymentoptn")%>" name="paymentOptn">
		
	<% 		
		}
	%>	
		<input type="hidden" value="<%=orderdeatilMap.get("productType")%>" name="productType">
		<input type="hidden" value="<%=orderdeatilMap.get("bedId")%>" name="bedID" >
				
	</form>
	
	
	<form action="Services.jsp" method="post" id="order_confirm_form">
	
	<%
		//Getting session value

		Map<String, Object> partyproductid = EntityQuery.queryOne("PRODUCT","PID='"+orderdeatilMap.get("productid")+"'");
								
		Map<String, Object> partynamemap = EntityQuery.queryOne("PARTY","PARTYID='"+partyMap.get("PARTYID")+"'");
		
		// fetching productid of selected product(from bookservices) 
		String productorderdid = request.getParameter("orderproductid");
		//String postaladdrsID = (String)request.getAttribute("PARTYADDRSID");
		
		//Map object to fetch product details using productorderid
		Map<String, Object> productorderMap = ProductServices.getProductById(productorderdid);
		
		// Map object to fetch address & payment details of party  
		orderdeatilMap.get("PRODUCTTYPE");
		
	%>
	  
	<div class="container">
		<span class="product_review_header"> Double check your order details</span>
		<span class="product_review_msg">Almost done!Please click "Place your order" to complete your booking</span>
		
		<div class="row product_review_details">
	
			<div  class="col-md-4">
				<span class="product_review_addrs_title"> Shipping Address</span>
				<div>
				<% 
					//if partyaddrsid!=null then give previous entered address
				if(orderdeatilMap.get("partyaddrsid")!=null)
					{
						Map<String, Object> usedaddrsMap = EntityQuery.queryOne("PARTYADDRESS","PARTYADDRSID='"+orderdeatilMap.get("partyaddrsid")+"'");
				%>
				<p class="product_review_addrs"><%=usedaddrsMap.get("PFNAME")%></p>
				<p class="product_review_addrs"><%=usedaddrsMap.get("PADDRS1")%></p>
				<p class="product_review_addrs"><%=usedaddrsMap.get("PADDRS2")%></p>
				<p class="product_review_addrs"><%=usedaddrsMap.get("PSTATE")%></p>
				<p class="product_review_addrs"><%=usedaddrsMap.get("PZCODE")%></p>
				
				<%
					}
					//if partaddrssid is null then fetch new addrs
					else
					{
				%>	
						<p class="product_review_addrs"><%=postalidMap.get(postalidMap.size()-1).get("PFNAME")%></p>
						<p class="product_review_addrs"><%=postalidMap.get(postalidMap.size()-1).get("PADDRS1")%></p>
						<p class="product_review_addrs"><%=postalidMap.get(postalidMap.size()-1).get("PADDRS2")%></p>
						<p class="product_review_addrs"><%=postalidMap.get(postalidMap.size()-1).get("PSTATE")%></p>
						<p class="product_review_addrs"><%=postalidMap.get(postalidMap.size()-1).get("PZCODE")%></p>
				<% 
					}
				%>
				
				</div>
			</div>
			<div  class="col-md-3">
				<span class="product_review_payment_title"> Payment Method </span>
				<div class="product_review_payment_mode">
			
				<% 
					String PayType = request.getParameter("paymentOptn");
					
				if(orderdeatilMap.get("partyaddrsid")!=null)
				{
			
						if(PayType.equals("paymentAppt"))
						{
					%>
					<span class="product_review_payment_mode1"><i class="fa fa-cash product_review_payment_mode_icon" aria-hidden="true"></i>Pay</span><span class="product_review_payment_mode2">on Appointment</span>
				
				<% 			
						}
						
						else if(PayType.equals("paymentppal"))	
					{
				%>			
					<span class="product_review_payment_mode1"><i class="fa fa-paypal product_review_payment_mode_icon" aria-hidden="true"></i>Pay</span><span class="product_review_payment_mode2">Pal</span>
				
				<% 			
					}
				}
				else
				{	
				
				%>
			
				<%
					//Getting payment option and setting logo for that optn
										
					if(PayType.equals("paymentAppt"))
					{	
				%>
				<span class="product_review_payment_mode1"><i class="fa fa-cash product_review_payment_mode_icon" aria-hidden="true"></i>Pay</span><span class="product_review_payment_mode2">on Appointment</span>
				<% 	
					}
				%>
				
				<%	
					if(PayType.equals("paymentppal"))
					{
						
				%>
				<span class="product_review_payment_mode1"><i class="fa fa-paypal product_review_payment_mode_icon" aria-hidden="true"></i>Pay</span><span class="product_review_payment_mode2">Pal</span>
				<% 	
					}
				}
				%>
				
				</div>
			</div>
			<div  class="col-md-5 product_review_bill">
				<div class="product_review_payment_details">
					<span>Item(s)total</span>
					<span><%=productorderMap.get("PRDTDSCTPRICE")%></span>
				</div>
				<div class="product_review_payment_details">	
					<span>Shipping</span>
					<span>0 Rupees.</span>
				</div>	
				<div>
					<div class="product_review_payment_details product_review_payment_sales">	
						<span>Sales Tax</span>
						<span>0 Rupees.</span>
					</div>
				</div>	
				<div class="product_review_payment_details product_review_payment_total">	
					<span>Order Total</span>
					<span><%=productorderMap.get("PRDTDSCTPRICE")%></span>
				</div>	
				<div class="place_order_btn">
					<button type="button" class="place_order_submit_btn" id="place_order">Place Your Order</button>
				</div>
			</div>	
		</div>
	</div>
	<div class="container">
		<span class="appoint_details">Booking Details</span>
		
		<span class="appoint_details_date"> <%=orderdeatilMap.get("slotDate")%> </span> 
		<div class="row ">
			<div class="col-md-2 product_review_img_wrapper">
				<img alt="product_img" src="<%=productorderMap.get("PIMAGEURL")%>">
			</div>
			<div class="col-md-5 product_review_content_wrapper">
				<h4 class="product_review_name"> Service Name -</h4>
		<%
			if(orderdeatilMap.get("productType").equals("Appointment"))
			{
		%>
			<h3 class= "product_title">  </h3>
			<span class="product_review_price">(<%=productorderMap.get("PRDTDSCRPTN")%>)</span>
		
		<% 	
			
		%>	
			
		<% 
			}	
			if(orderdeatilMap.get("productType").equals("services"))
	
			{
	
		%>
			<span class="product_review_price"><%=productorderMap.get("PRDTDSCRPTN")%></span>
		<% 
			}
		%>	
		
			<% 
				
			if(orderdeatilMap.get("productType").equals("bed"))
			{
	
		%>
			<span class="product_review_price"><%=productorderMap.get("PRDTNAME")%></span>
		<% 
			}
		%>	
			
			</div>
			<div class="col-md-5 product_review_content_wrapper">
				<h4 class="product_review_name"> Service Price -</h4>
				<span class="product_review_price"><%=productorderMap.get("PRDTDSCTPRICE")%></span>
			</div>
			
		</div>
	</div>
	</form>
</section>

<script>
$(document).ready(function(){
	$("#place_order").click(function(){
		$("#hidden_form").submit();
	})
})

</script>
<%@include file="Footer.jsp"%>
