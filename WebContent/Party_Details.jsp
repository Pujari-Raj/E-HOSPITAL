<%@page import="java.util.List"%>
<%@include file="header.jsp"%>

<%
		String partyId = request.getParameter("PartyId");
		//System.out.print("ProductId In Product_details -"+productId);
		//request.setAttribute("orderID", orderId);

		
		if(partyId==null)
		{
			partyId = (String) request.getAttribute("partyid");
			
		}
		
		
		Map<String, Object> productMap = EntityQuery.queryOne("PARTY", "PARTYID='"+partyId+"'");
		
%>
<section class="Patient_Details">
            <div class="container">
            
            <form action="Update_Party_Details" method="post" id="update_form">
            	<input type="hidden" name="partyid" value="<%=productMap.get("PARTYID")%>"/>
            
               <div class="patient_personal_details">
                    <h1 class="patient_personal_detail_title">Personal Details</h1>
                
                	<div class="row">
                		<div class="col-md-6 edit_update_btn">
                                    <a href="#" class="edit_btn" id="party_edit"> Edit </a>
                                    <a href="#" class="update_btn" id="party_detail_update"> Update Changes </a>
                                    
                    	</div>
                	</div>
                	
               	    <div class="fname">
                        <label class="patient_form_label">Party Id</label><br>
                        <input type="text" name="partyid" class="form-control patient_form_input" value="<%=productMap.get("PARTYID")%>" disabled="disabled" readonly="readonly" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Party Type</label><br>
                        <input type="text" name="partytype" class="form-control patient_form_input" value="<%=productMap.get("PARTYTYPE")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">First Name</label><br>
                        <input type="text" name="fname" class="form-control patient_form_input" value="<%=productMap.get("FNAME")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Middle Name</label><br>
                        <input type="text" name="mname" class="form-control patient_form_input" value="<%=productMap.get("MNAME")%>" disabled="disabled" />
                    </div>
                    <div class="fname">
                        <label class="patient_form_label">Last Name</label><br>
                        <input type="text" name="lname" class="form-control patient_form_input" value="<%=productMap.get("LNAME")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">DOB</label><br>
                        <input type="text" name="DOB" class="form-control patient_form_input" value="<%=productMap.get("DOB")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Gender</label><br>
                        <input type="text" name="Gender" class="form-control patient_form_input" value="<%=productMap.get("GENDER")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Phone No</label><br>
                        <input type="text" name="party_mobil_no" class="form-control patient_form_input" value="<%=productMap.get("PHONENO")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Email</label><br>
                        <input type="text" name="party_email" class="form-control patient_form_input" value="<%=productMap.get("EMAIL")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Street Address1</label><br>
                        <input type="text" name="saddr1" class="form-control patient_form_input" value="<%=productMap.get("SADDR1")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Street Address2</label><br>
                        <input type="text" name="saddr2" class="form-control patient_form_input" value="<%=productMap.get("SADDR2")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">City</label><br>
                        <input type="text" name="city" class="form-control patient_form_input" value="<%=productMap.get("CITY")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">State</label><br>
                        <input type="text" name="state" class="form-control patient_form_input" value="<%=productMap.get("STATE")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Zip Code</label><br>
                        <input type="text" name="zcode" class="form-control patient_form_input" value="<%=productMap.get("ZCODE")%>" disabled="disabled" />
                    </div>
                    
                    <div class="fname">
                        <label class="patient_form_label">Work Experience</label><br>
                        <input type="text" name="workexp" class="form-control patient_form_input" value="<%=productMap.get("WORKEXP")%>" disabled="disabled" />
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