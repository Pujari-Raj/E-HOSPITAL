<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@include file="header.jsp"%>

	<%
		// Getting session value of user to get user details and fecth orders related to user
		String getusereml = (String) session.getAttribute("customer");
		//System.out.println("Getting Customer Email- "+getusereml);
		
		//Getting party email using session value
		Map<String, Object> getpartydetailMap = EntityQuery.queryOne("PARTY","EMAIL='"+getusereml+"'");
		String partyid = (String) getpartydetailMap.get("PARTYID"); 
		
		//Getting Address Details of party
		List<Map<String, Object>> getpartyaddressMap = EntityQuery.queryList("PARTYADDRESS","PARTYID='"+getpartydetailMap.get("PARTYID")+"'");
	%>
	<!-- <p></p> -->	
	<section>
       <div class="container">
		 <div class="row">
		 
            <div class="manage_address">
                <span class="manage_address_title"> Manage Addresses </span>
                <div class="new_address">
                    <a href="#new_address" class="add_new_addrs"> <i class="fas fa-plus plus_icon"></i> ADD NEW ADDRESS </a>
                </div>

			<%
				for(int i =0;i<getpartyaddressMap.size();i++)
				{		
			%>
                <div class="your_address">
                    <div class="address_card">
                        <p class="profile_name"> <span> <%=getpartydetailMap.get("FNAME")%> <%=getpartydetailMap.get("MNAME")%> </span> <span> <%=getpartydetailMap.get("PHONENO")%> </span> </p>
                        <span>  
                        	<%=getpartyaddressMap.get(i).get("PADDRS1")%> <%=getpartyaddressMap.get(i).get("PADDRS2")%>
                        	<%=getpartyaddressMap.get(i).get("PSTATE")%> <%=getpartyaddressMap.get(i).get("PZCODE")%>
                        </span>
                        
                        <form action="Update_Party_Address" method="post">
                        	<input type="hidden" value="<%=getpartyaddressMap.get(i).get("PARTYADDRSID")%>" name="partyaddrsid"/>
                        	<button type="submit"  class="edit_addrs_btn"> Remove </button>
                        </form>
                    </div>
                </div>
           <%
				}   
           %>
           
           <div class="col-md-6" id="new_address">
					<div class="payment_bill_title">
						<h3>Billing info</h3>
					 </div>
					 
				<form action="New_Address" method="post">	 
					 <div class="field payment_fullname">
							<input type="hidden" id="pfname" class="input_layout" placeholder="Full Name" name="partyid" value="<%=getpartydetailMap.get("PARTYID")%>" required="required">
					 
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
					 	<input type="number" id="bzcode" placeholder="Zip Code" name="bzcode" required="required">
					</div>
					
				 <button type="submit" class="new_address_btn"> Add This New Address </button>
           </form>
            </div>
             
            </div>
		 </div>
       </div>
    </section>
    
<%@include file="Footer.jsp"%>