<%@include file="header.jsp"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.hospital.productServices.*"%>
		
<section class="cart_service">
	<div class="container">
		<h3 class="cart_service_heading">our services</h3>
		<div class="row">
		
		<%
			//Creating List Object of products to display and passing it to (getProductList(null)) 
			//method of (ProductServies) Class 
			List<Map<String,Object>> productlist = ProductServices.getProductList("main_product");
			
			
			//using for loop to get the product's data 
			for(int i=0;i<productlist.size();i++)
			{
				String imageurl =  (String) productlist.get(i).get("PIMAGEURL");	
				
				if(imageurl.contains("D:\\"))
				{
					imageurl = imageurl.substring(imageurl.lastIndexOf("productcontent"));
				}
		%>
		
		<!-- Displaying the product from using data stored in DBase -->
		<div class="col-md-3">
			<div class="product_card">
			<!-- On clicking on any product forward user to Single_product.jsp 
			 getting PRODUCTID from productlist 
			 setting the productId in URl of browser-->
			<a href="Single_product.jsp?ProductId=<%=productlist.get(i).get("pid")%>">
			
			<!-- Getting the image from productlist -->
			<div class="cart_service_img_wrapper">
				<img src="<%=imageurl%>"  alt="" class="blood_test_img">
			</div>
			<!-- Getting the Product Description from productlist -->
			<div class="cart_service_img_content_wrapper">
				<h4 class="btest_product_name"><%=productlist.get(i).get("PRDTDSCRPTN")%></h4>
			</div>
			
			<!-- Getting the PRODUCT PRICE from productlist -->
			<div class="cart_service_product_price_wrapper">
				<span class="mrp_price"><%=productlist.get(i).get("PRDTDSCTPRICE")%>Rupees</span>
			</div>
			</a>
			</div>
		</div>
		<% } %>
		
		</div>
	</div>
</section>
		

<%@include file="Footer.jsp" %>