<%@page import="java.util.List"%>
<%@include file="header.jsp"%>

<%
		String productId = request.getParameter("ProductId");
		//System.out.print("ProductId In Product_details -"+productId);
		//request.setAttribute("productID", productId);
		
		if(productId==null)
		{
			productId = (String) request.getAttribute("productID");
			
		}
		
		
		Map<String, Object> productMap = EntityQuery.queryOne("PRODUCT", "PID='"+productId+"'");
		
%>
<section class="Patient_Details">
            <div class="container">
            
            <form action="Update_Product_Details" method="post" id="update_form">
            		<input type="hidden" name="productId" value="<%=productMap.get("PID")%>"/>
            
               <div class="patient_personal_details">
                    <h1 class="patient_personal_detail_title">Product Details</h1>
                
                	<div class="row">
                		<div class="col-md-6 edit_update_btn">
                                    <a href="#" class="edit_btn" id="party_edit"> Edit </a>
                                    <a href="#" class="update_btn" id="party_detail_update"> Update Changes </a>
                                    
                    	</div>
                	</div>
                	
               	    <div class="fname">
                        <label class="patient_form_label">Productid</label><br>
                        <input type="text" name="productId" class="form-control patient_form_input" value="<%=productMap.get("PID")%>" disabled="disabled" readonly="readonly"/>
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Product Description</label><br>
                        <input type="text" name="product_dscrptn" class="form-control patient_form_input" value="<%=productMap.get("PRDTDSCRPTN")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Product Name</label><br>
                        <input type="text" name="product_Name" class="form-control patient_form_input" value="<%=productMap.get("PRDTNAME")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">MRP Price</label><br>
                        <input type="text" name="product_MRP" class="form-control patient_form_input" value="<%=productMap.get("PRDTMRPPRICE")%>" disabled="disabled" />
                    </div>
                    <div class="fname">
                        <label class="patient_form_label">Discount Price</label><br>
                        <input type="text" name="product_DSCT" class="form-control patient_form_input" value="<%=productMap.get("PRDTDSCTPRICE")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Image Url</label><br>
                        <input type="text" name="product_Imageurl" class="form-control patient_form_input" value="<%=productMap.get("PIMAGEURL")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Category</label><br>
                        <input type="text" name="product_Cateogry" class="form-control patient_form_input" value="<%=productMap.get("CATERGORYID")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Product Type</label><br>
                        <input type="text" name="product_Type" class="form-control patient_form_input" value="<%=productMap.get("PRODUCTTYPE")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Party Id</label><br>
                        <input type="text" name="product_partyId" class="form-control patient_form_input" value="<%=productMap.get("PARTYID")%>" disabled="disabled" />
                    </div>
                    
                    
               </div> 

			</form>
	</div>
</section>

<script>
	$(document).ready(function (){
			$("#party_edit").click(function () {
				$(".patient_personal_details :input").css({"background": "#fff", "border": "1px solid gray", "border-radius": "4px"});
				$(".patient_personal_details :input").prop("disabled", false);
			});
	});
	$(document).ready(function () {
			$("#party_detail_update").click(function () {
				$("#update_form").submit();
			});
	});
</script>


<%@include file="Footer.jsp"%>