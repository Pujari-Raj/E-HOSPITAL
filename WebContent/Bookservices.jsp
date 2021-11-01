<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@include file="header.jsp"%>

<section class="payment_mode">
	<div class= "container">
		<div class="row payment_mode">
			<!-- Hidden Form to pass the productid,sdate,stime,partyaddrsid,paymentoptn -->
			<form name="Addressform" id="hidden_form" method="post" action="Process_payment_servlet">
				<input type="hidden" value="<%=request.getAttribute("selectedPid")%>" name="orderproductid">
				<input type="hidden" value="<%=request.getAttribute("slotDate")%>" name="SDate">
				<input type="hidden" value="<%=request.getAttribute("slotTime")%>" name="STime">
				
				<!-- Setting null value bcz value gets enetered on click of use this address -->
				<input type="hidden" name="partyaddrsid" value="" id="partyaddrsId">
				<input type="hidden" value="" name="paymentOptn" id="paymentoptn">
				<input type="hidden" value="<%=request.getAttribute("productType")%>" name="producttype">	
				<input type="hidden" value="<%=request.getAttribute("bedId")%>" name="bedID" >
			</form>
					
			<form action="Process_payment_servlet" id="payment_form" method="post">
				
				<!-- Setting the selected product's id  -->
				<input type="hidden" value="<%=request.getParameter("productid")%>" name="orderproductid">
				<input type="hidden" value="<%=request.getAttribute("slotDate")%>" name="SDate">
				<input type="hidden" value="<%=request.getAttribute("slotTime")%>" name="STime">
				<input type="hidden" value="<%=request.getAttribute("productType")%>" name="producttype">	
				<input type="hidden" value="<%=request.getAttribute("bedId")%>" name="bedID" >
				
			<%
				//Getting the session value of user from Utility class
				String getCustEml = (String)session.getAttribute("customer");
			
				//getting the slot date & time which is coming from singleproduct 
				String slotdate = (String)request.getAttribute("slotDate");
				String slotime = (String)request.getAttribute("slotTime");
				String producttype = (String) request.getAttribute("productType");
				String bedId = (String) request.getAttribute("bedId");
				//System.out.print("bed id -"+bedId);
				
				request.setAttribute("slotDate", slotdate);
				request.setAttribute("slotTime", slotime);
				request.setAttribute("productType", producttype);
				
				
				//Getting email of user from getCustEml object
				Map<String, Object> custMap = EntityQuery.queryOne("PARTY","EMAIL = '"+getCustEml+"'");

				//Getting List of map objects of party whose address is stored in partyaddress with same id 
				List<Map<String, Object>> custPartyMap = EntityQuery.queryList("PARTYADDRESS","PARTYID='"+custMap.get("PARTYID")+"'");
				
			%>	
			 <!--  	<p><%=request.getAttribute("slotDate")%></p> -->
			   
				<div class="col-md-12 Address_wrapper">
					<h4 class="Address_title"> Your Address </h4>
					<div class=" saved_addrs">
					<%
						//Code to fetch addresses entered by user 
						for(int i =0;i<custPartyMap.size();i++)
						{
							String adrsid = (String) custPartyMap.get(i).get("PARTYADDRSID");
					%>
					<div>
						<p class="saved_addrs_content"><%=custPartyMap.get(i).get("PFNAME")%>  <%=custPartyMap.get(i).get("PADDRS1")%> 
						<%=custPartyMap.get(i).get("PADDRS2")%>  <%=custPartyMap.get(i).get("PSTATE")%>
						 <%=custPartyMap.get(i).get("PZCODE")%>
						</p>	
		<!-- Code if user want to use previous entered addrss then take partyaddrsid and fetch the previous entered addres 
			js.void function takes partyaddrsid value inside it 
		-->				
					<a href ="javascript:void(0);" class="use_addrs"  onclick="addrsid(<%=custPartyMap.get(i).get("PARTYADDRSID")%>)">Use This as Billing Address</a>
					
					<% } %>
						
					</div>
					</div>
					
				</div>
					
					<div class="">
					<h3 class="payment_title"> Payment Mode  (Select the payment mode) </h3>
					</div>
					
					<div class="col-md-6">
					<!-- Setting same name= paymentoptn for both to get value in next page-->
					<input type="radio" name="paymentOptn" id="radio1" class="radiobtn" value="paymentAppt" required="required">
						<label for="radio1" class="payment_label">
							<div class="paymentlogo">
								<i class="fa fa-book" aria-hidden="true"></i>
							</div>
							<div class="paymenttext">
								<p>Pay on Appoinment</p>
							</div>
						</label>
					</div>
					<%
						if(!producttype.equals("bed"))
						{
					%>
					<div class= "col-md-6">	
					<input type="radio" name="paymentOptn" id="radio2" class="radiobtn" value="paymentppal" required="required">
						<label for="radio2" class="payment_label">
							<div class="paymentlogo">
								<i class="fa fa-credit-card" aria-hidden="true"></i>
							</div>
							<div class="paymenttext">
								<p>Pay Now with Paytm</p>
							</div>
						</label>
					</div>	
					<%
						}
					%>	
				<!-- Code to enter new address for users -->
				<div class="row">
				 <div class="col-md-6">
					<div class="payment_bill_title">
						<h3>Billing info</h3>
					 </div>
					 <div class="field payment_fullname">
					 	<label for="name"> Full Name:</label>
					 	<input type="text" id="pfname" class="input_layout" placeholder="Full Name" name="pfname" required="required">
					 </div>
					<div class="field payment_fullname">
					 	<label for="name">  Address Line1 :</label>
					 	<input type="text" id="baddrs1" placeholder="Billing Address" name="baddrs1" required="required">
					</div>
					<div class="field payment_fullname">
					 	<label for="name"> Address Line2 :</label>
					 	<input type="text" id="baddrs2" placeholder="Billing Address" name="baddrs2" required="required">
					</div>
					<div class="field payment_fullname payment_addr">
					 	<div class="payment_state">
					 		<label for="name"> State:</label>
					 		<input type="text" id="bstate" placeholder="State" name="bstate" required="required">
						</div>
					</div>
					<div class="field payment_fullname">
					 	<label for="name"> Zip Code:</label>
					 	<input type="text" id="bzcode" placeholder="Zip Code" name="bzcode" required="required">
					</div>
					 
					<div class="payment_button">
						<div class="payment_return">
							<a href="Services.jsp" class="rtn_store">Return to store </a>
						</div>
						<!-- 
						<div class="payment_ship">
							<a href="Services.jsp" class="rtn_store">Back to shipping</a>
						</div>
					 -->	
						<div class="payment_proceed">
							<button type="submit" class="btn_proceed btn_return" onclick="" id="proceed_payment">proceed</button>
						</div>
						
					</div> 
				 </div>
				</div>
		</div>
		</form>
	</div>
</section>

<script>
	//JQuery Function for submitting the form to next page
	$(document).ready(function(){
		$("#proceed_payment").click(function(){
			$("#payment_form").submit();
		})
	})
	
	$(document).ready(function()
		{
			$("#proceed_payment").click(function()
					{
				//	alert("button clicked");	
					var radbtnval = $("input[name='paymentOptn']:checked").val();
						if(radbtnval)
						{
							$("#paymentoptn").val(radbtnval);
							$("#hidden_form").submit();
						}
					})
	})	
	//JScript Function for getting the partyaddrsid and passing this function to <a>Use this Address</a> to get partyaddrsid & PaymentOptn
	//151 line to submit the hidden form to next page
	function addrsid(partyaddrsid)
	{
		document.getElementById("partyaddrsId").value = partyaddrsid
	}
	
	//Getting the value of radio btn which is checked
	$(document).ready(function()
		{
			$("a.use_addrs").click(function()
					{
						var radbtnval = $("input[name='paymentOptn']:checked").val();
						if(radbtnval)
						{
							$("#paymentoptn").val(radbtnval);
							$("#hidden_form").submit();
						}
					})
	})	
</script>

<%@include file="Footer.jsp"%>
