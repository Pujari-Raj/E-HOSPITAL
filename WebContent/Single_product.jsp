<%@include file="header.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.hospital.productServices.*"%>
		
<!-- Product Details Card -->

<section class="product_details">
	<div class="container">
		<div class="row">
		
		<% 
			//Getting the PRODUCTID from Services page to display the details of only particular service
			String productId = request.getParameter("ProductId");
			
			//Map to get the productid of the product 
			Map<String, Object> partyproductid = EntityQuery.queryOne("PRODUCT","PID='"+productId+"'");
			String productype = partyproductid.get("PRODUCTTYPE").toString(); //Storing the producttype of selected product
			
			//Map to get the partyid from partyproductid map using productid
			Map<String, Object> partynamemap = EntityQuery.queryOne("PARTY","PARTYID='"+partyproductid.get("PARTYID")+"'");
		
		%>
		
		<%			
			//Creating Map<> to get the product details using the productid
			Map<String, Object> productdetails = ProductServices.getProductById(productId);
			
			//Creating List of map object to get slotstatus
			List<Map<String, Object>> slotlist = EntityQuery.queryList("timeslots", " slotstatus='Y'");
			
			String imageurl =  (String) partyproductid.get("PIMAGEURL");	
			
			if(imageurl.contains("D:\\"))
			{
				imageurl = imageurl.substring(imageurl.lastIndexOf("productcontent"));
			}
		%>
			<!--  <p><%=partynamemap.get("PARTYID")%></p> -->
			
			<form action="Process_checkout" method="post" id="single_product">
			<!-- Setting the productid in hidden field so that we can use it in next page i.e process_checkout page-->
				<input type="hidden" name= "productid" value="<%=productId%>">
				<input type="hidden" name= "producttype" value="<%=productype%>">
			<!-- Getting the product detils stored in Map object -->
			<div class="col-md-6">
				<img alt="product1_image" src="<%=imageurl%>" >
			</div>
			<div class="col-md-6">
				<%
					if(productype.equals("Appointment"))
					{
				%>		
						<h3 class= "product_title"> <%=partynamemap.get("FNAME")%> <%=partynamemap.get("MNAME")%> </h3>
						<h3 class= "product_dctr_field"> <%=productdetails.get("PRDTDSCRPTN")%> </h3>
						<h3 class= "product_dctr_field"> <%=productdetails.get("PRDTNAME")%> </h3>
						
				<%	
					}
					else
					{	
				%>
					<h3 class= "product_title"> <%=productdetails.get("PRDTDSCRPTN")%> </h3>
				<% 
					}
				%>
				<div class="product_price">
					<span class="product_mrpprice">Rs. <%=productdetails.get("PRDTDSCTPRICE")%> </span>
					<span class="product_mrpprice product_mrpprice_scratched">Rs. <%=productdetails.get("PRDTMRPPRICE")%> </span>
				</div>
				
				<div>
				<label>
					<span class="Booking_slot_date">Booking Date: </span>
					<input type="date" required="required" name="slotDate" min="" id="currentdate" class="Booking_slot_time_input"/>
				</label>
				
				<label>
					<span class="Booking_slot_time">Booking Time: </span>
				<select name="slotTime" class="Booking_slot_time_input">
				<% 
					//Getting the value of slotstatus which is Y
					for(int i=0;i<slotlist.size();i++)
					{	
				%>
					<option value="<%=slotlist.get(i).get("SLOTID")%>">
						<%=slotlist.get(i).get("DCRPTN")%>
					</option>
				<%
					}
				%>
				</select>
				</label>
				</div>
				
				<div class="product_available">
						<button type="submit" class="btn_submit btn">Book Now</button>
				</div>
				<div class="share_product"> 
					<h4>share product</h4>
				</div>
				<div class="social_icons">
					<ul>
						 
						 <li><a href="#"><i class="fab fa-facebook-f"></i>Facebook</a></li>
                         <li><a href="#"><i class="fab fa-twitter"></i>Twitter</a></li>
                         <li><a href="#"><i class="fab fa-google"></i>Google</a></li>
					</ul>
				</div>
			</div>					
		</div>
		<div class="row">
			<%
				if(productype.equals("Appointment"))
				{
			%>
					<div class="col-md-6 doctor_details">
                        <h3 class="shop-sing doctor_name"><%=partynamemap.get("FNAME")%> <%=partynamemap.get("MNAME")%> </h3>
                        <div class="doctor_qualification">
                            <p class="doctor_qual"><%=productdetails.get("PRDTNAME")%></p>
                        </div>
                       
                        <div class="doctor_experience"> 
                            <p class="doctor_qual"> Work Experience </p> 
                            <span class="qual_exp"><i class="fas fa-arrow-right detail_space"></i><%=partynamemap.get("WORKEXP")%> Years</span>
                        </div>
                        
                        <div class="doctor_experience"> 
                            <p class="doctor_qual"> Detailed Experience </p> 
                            <span><i class="fas fa-arrow-right detail_space"></i>Consultant Interventional  <%=productdetails.get("PRDTDSCRPTN")%>, MGM Healthcare, Chennai Consultant and Interventional  <%=productdetails.get("PRDTDSCRPTN")%>, BGS Gleneagles Global Hospital, Bangalore : Heart Failure specialist and Transplant  <%=productdetails.get("PRDTDSCRPTN")%>, Gleneagles Global : Consultant Interventional  <%=productdetails.get("PRDTDSCRPTN")%>, Manipal Hospitals, Bangalore.</span>
                        </div>
                        
                    </div>
                     			
			<%
				}
				else
				{
			%>
		
			<h3 class="product_description">  <%=productdetails.get("PRDTDSCRPTN")%>  </h3>
			<p class="product_description1"> Regular <%=productdetails.get("PRDTDSCRPTN")%>  can identify any early signs of health issues. When you have a health check, your doctor will talk with you about your medical history, your family's history of disease and your lifestyle, including your diet, weight, physical activity, alcohol use and whether you smoke.</p>
			
			<%
				}
			%>			
		</div>
		<h3 class = "feature_products"> Related Service </h3>
		<div class="row">
		<%	
			//Creating the List object to get the realted service dat using (CategoryID='feature_prod') 
			List<Map<String, Object>> cateogrylist = ProductServices.getProductList("feature_prod");
			
			List<Map<String, Object>> doctorslist = ProductServices.getProductList("feature_doctor");
			String doccategory = partyproductid.get("CATERGORYID").toString();
			System.out.println("category--"+doccategory);
		%>	
	
		<% 	
			if(doccategory.equals("doctors"))
			{
				for (int i=0;i<doctorslist.size();i++)
				{
		%>		
			<div class="col-md-3">
				<div class="product_card">
				<a href="Single_product.jsp?ProductId=<%=doctorslist.get(i).get("pid") %>">
				<div class="cart_service_img_wrapper">
				<img src="<%=doctorslist.get(i).get("PIMAGEURL")%>"  alt="" class="blood_test_img">
				</div>
				<div class="cart_service_img_content_wrapper">
				<h4 class="btest_product_name"><%=doctorslist.get(i).get("PRDTDSCRPTN")%></h4>
				</div>
				<div class="cart_service_product_price_wrapper">
				<span class="mrp_price">Rs.<%=doctorslist.get(i).get("PRDTMRPPRICE")%></span>
				</div>
				</a>
			</div>
		</div>		
		<%
				}
			}
			else
			{	
		%>
		
		<%	
			
			for(int i=0;i<cateogrylist.size();i++)
			{
		%>
		
		<div class="col-md-3">
			<div class="product_card">
			<a href="Single_product.jsp?ProductId=<%=cateogrylist.get(i).get("pid") %>">
			<div class="cart_service_img_wrapper">
				<img src="<%=cateogrylist.get(i).get("PIMAGEURL")%>"  alt="" class="blood_test_img">
			</div>
			<div class="cart_service_img_content_wrapper">
				<h4 class="btest_product_name"><%=cateogrylist.get(i).get("PRDTDSCRPTN")%></h4>
			</div>
			<div class="cart_service_product_price_wrapper">
				<span class="mrp_price">Rs.<%=cateogrylist.get(i).get("PRDTMRPPRICE")%></span>
			</div>
			</a>
			</div>
		</div>		
		<% 
			}
			}	
		%>
		</div>
		</form>
	</div>
</section>

<script>

// js function to get the current date for bookng the services/ doctor's appointment
window.onload = function(){

	  var d = new Date();

	  // Build ISO 8601 format date string
	  var s = d.getFullYear() + '-' + ('0' + (d.getMonth()+1)).slice(-2) + '-' +('0' + d.getDate()).slice(-2);

	  // Set the value of the value and min attributes
	  var node = document.getElementById('currentdate');
	  if (node) 
	  {
	    node.setAttribute('min', s);
	    node.setAttribute('value', s);
	  }
	}

</script>
<%@include file="Footer.jsp"%>