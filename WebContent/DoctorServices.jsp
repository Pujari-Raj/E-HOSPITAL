<%@page import="com.hospital.productServices.ProductServices"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@include file="header.jsp"%>

	<section class="cart_service">
		<div class="container">
			<h3 class="cart_service_heading"> Our Doctors </h3>
			<div class="row">
				<%
					//List to get data of product which is type of Appntmnt
					List<Map<String, Object>> doctorsMap = EntityQuery.queryList("PRODUCT", "PRODUCTTYPE = 'Appointment'");
					
					//loop the object of map to get data of products 
					for(int i=0;i<doctorsMap.size();i++)
					{		
						//Getting Map object to get partyid of dctr (using doctormap because partyid is forigen key in product table)
						Map<String, Object> nameMap = EntityQuery.queryOne("PARTY","PARTYID='"+doctorsMap.get(i).get("PARTYID")+"'");
				%>
				<div class="col-md-6">
					<div class="doctor_card">
						
					<div class="doctor_card_img_wrapper">
						<img alt="Doctor_img1" src="<%=doctorsMap.get(i).get("PIMAGEURL")%>">				
					<div class="doctor_card_content_wrapper">
						<h4 class="doctor_card_img_wrapper_name"> <%=nameMap.get("FNAME")%> 
							<%=nameMap.get("MNAME")%>
						</h4>
						<h5 class="doctor_card_img_wrapper_specialist"><%=doctorsMap.get(i).get("PRDTDSCRPTN")%> </h5>
						
						<span class="doctor_quailf"> <%=doctorsMap.get(i).get("PRDTNAME")%>  </span>
					
					<div class="doctor_card_fees_wrapper"> 
						<span class="doctor_fees"> Consulation Fees: </span>
						<span  class="doctor_fees"> <%=doctorsMap.get(i).get("PRDTMRPPRICE")%> </span>
					<div class="Book_Appt_link">	
						<a href="Single_product.jsp?ProductId=<%=doctorsMap.get(i).get("PID")%>" class="Book_appt"> Book Appointment </a>
					<!-- Code to get particular doctor details (Single_product.jsp?ProductId=<%=doctorsMap.get(i).get("PID")%>)
						 -->
					</div>	
					</div>	
					</div>
					</div>	
					
					</div>
				</div>
				<% }%>
			</div>			
		</div>
	</section>

<%@include file="Footer.jsp"%>
