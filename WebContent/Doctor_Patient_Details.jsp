<%@include file="header.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
	
<%
		String orderId = request.getParameter("OrderId");
		System.out.print("order id -"+orderId);
		request.setAttribute("orderID", orderId);
		
		//Getting the orderid from servlet
		if(orderId==null)
		{
			orderId = (String) request.getAttribute("orderId");
		}
		
		Map<String, Object> orderdeatilmap = EntityQuery.queryOne("ORDERDETAIL","ORDERID='"+orderId+"'");
		String partyid = (String)orderdeatilmap.get("PARTYID");
		System.out.print("partyid in patient detail page-"+partyid);
		request.setAttribute("partyId", partyid);
		
		Map<String, Object> getpartyidMap = EntityQuery.queryOne("PARTY", "PARTYID='"+partyid+"'");
		
		List<Map<String, Object>> custPartyMap = EntityQuery.queryList("PARTYADDRESS","PARTYID='"+partyid+"'");
		
		List<Map<String, Object>> medicinesMap = EntityQuery.queryList("PRODUCT", "PRODUCTTYPE = 'medicine'");
		
		List<Map<String, Object>> prescripitionMap = EntityQuery.queryList("PRESCRIPTION", "PARTYID='"+partyid+"'");
		
%>	
	
<section class="Patient_Details">
            <div class="container">
               <div class="patient_personal_details">
                    <h1 class="patient_personal_detail_title">Personal Details</h1>
                
               	     <div class="fname">
                        <label class="patient_form_label">First Name</label><br>
                        <input type="text" name="fname" class="form-control patient_form_input" value="<%=getpartyidMap.get("FNAME")%>" disabled="disabled" />
                    </div>
                    <div class="fname">
                        <label class="patient_form_label">Last Name</label><br>
                        <input type="text" name="fname" class="form-control patient_form_input" value="<%=getpartyidMap.get("LNAME")%>" disabled="disabled" />
                    </div>
                    <div class="fname">
                        <label class="patient_form_label">Email</label><br>
                        <input type="text" name="fname" class="form-control patient_form_input" value="<%=getpartyidMap.get("EMAIL")%>" disabled="disabled" />
                    </div>
                    <div class="fname">
                        <label class="patient_form_label">Mobile Number</label><br>
                        <input type="text" name="fname" class="form-control patient_form_input" value="<%=getpartyidMap.get("PHONENO")%>" disabled="disabled" />
                    </div>
                    
               </div> 

            <div class="patient_Address_details">
                <h1 class="patient_personal_detail_title">Address Details</h1>
            
                <div class="Address">
                    <label class="patient_form_label">Address Line1</label><br>
                    <input type="text" name="fname" class="form-control patient_form_input" value="<%=custPartyMap.get(custPartyMap.size()-1).get("PADDRS1")%>" disabled="disabled" />
                </div>
                <div class="Address">
                    <label class="patient_form_label">Address Line2</label><br>
                    <input type="text" name="fname" class="form-control patient_form_input" value="<%=custPartyMap.get(custPartyMap.size()-1).get("PADDRS2")%>" disabled="disabled" />
                </div>
                <div class="Address">
                    <label class="patient_form_label">State</label><br>
                    <input type="text" name="fname" class="form-control patient_form_input" value="<%=custPartyMap.get(custPartyMap.size()-1).get("PSTATE")%>" disabled="disabled" />
                </div>
                <div class="Address">
                    <label class="patient_form_label">ZipCode</label><br>
                    <input type="text" name="fname" class="form-control patient_form_input" value="<%=custPartyMap.get(custPartyMap.size()-1).get("PZCODE")%>" disabled="disabled" />
                </div>
           </div> 
        
        <form action="Doctor_Prescription" method="post">
           <input type="hidden" value="<%=orderId%>" name="orderId">
           <input type="hidden" value="<%=partyid%>" name="partyId">
         <div class="patient_Address_details patient_treatment">
            <h1 class="patient_personal_detail_title">Checkup and Prescription Details</h1>
        	
        	<%
        		if(prescripitionMap.size()<1)
        		{
        	%>	
        			<h4 class="no_orders"> No Prescription Yet , to prescribe the medicine please select the medicines </h4>
        			<div class="Address">
                		<label class="patient_form_label">Chief Complaint</label>
                		<input type="text" name="patientcomplain" class="form-control patient_form_input" />
          		  </div>
            <div class="Address">
                <label class="patient_form_label">Treatment Plan</label><br>
               
               <% 
               		for(int i=0;i<medicinesMap.size();i++)
               		{
               %>
                <input type="checkbox" id="Medicine1" name="medid" value="<%=medicinesMap.get(i).get("PID")%>">
                <label for="vehicle1" class="patient_medicine_label"> <%=medicinesMap.get(i).get("PRDTNAME")%> </label><br>
               <%
               		}
               %>  
               
               	<button type="submit" class="btn_proceed btn_return btn_prescription" onclick="" id="proceed_payment">Send</button>
			</form>
        			   
            
             <%   
                }
        		else
        		{
        	%>
        		 <label class="patient_form_label">Treatment Plan</label><br>
               	 <label class="patient_form_label">Complain:- <%=orderdeatilmap.get("PATIENTCOMPLAINT")%></label><br>
               	
        	<%	
        			for(int i=0;i<prescripitionMap.size();i++)
               		{
        				String pid = (String) prescripitionMap.get(i).get("PRODUCTID");
        		
              			Map<String, Object> getproductdetailsMap = EntityQuery.queryOne("PRODUCT", "PID='"+pid+"'");
        	%>
        	
            <div class="Address">
               
                <label for="vehicle1" class="patient_medicine_label"> <%=getproductdetailsMap.get("PRDTNAME")%>  </label>
            </div>
            
            <%
               		}
               	}
            %>
        </div> 
        
        </div>
       
       </div>
             
    </section>		
		
<%@include file="Footer.jsp" %>
				