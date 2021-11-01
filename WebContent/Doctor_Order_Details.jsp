<%@include file="header.jsp"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>


<% 
		// Getting session value of user to get user details and fecth orders related to user
		String getusereml = (String) session.getAttribute("customer");
		System.out.println("Getting Customer Email- "+getusereml);
		
		//Getting party email using session value
		Map<String, Object> getpartyidMap = EntityQuery.queryOne("PARTY", "EMAIL='"+getusereml+"'");
		//Getting partyid value from session(email)
		String partyid = (String) getpartyidMap.get("PARTYID");
		//System.out.print("pid-"+partyid);		
		
		
		Map<String, Object> getproductidMap = EntityQuery.queryOne("PRODUCT", "PARTYID='"+partyid+"'");
		//Getting partyid value from session(email)
		String productid = (String) getproductidMap.get("PID");
		System.out.print("pid-\n "+productid);		
		
		List<Map<String, Object>> getorderDetailsMap = EntityQuery.queryList("ORDERDETAIL", "ORDERPRODUCTID='"+productid+"'");		
		
%>

<section class="Doctor_Order_Details">
        <div class="container">
            <div class="table-wrapper">
                <div class="row">
                    <div class="table_title col-md-12">
                        <span>
                            <h2 class="doctor_Order_details_title">Order Details</h2>
                        </span>
                    </div>
                </div>
            </div>
        </div>    
            <table class="table table-bordered order_table">
                <thead>
                    <tr>
                        <th>OrderId</th>
                        <th>OrderProductId</th>
                        <th>OrderFullfilmentDate</th>
                        <th>OrderFullfilmentTime</th>
                        <th>OrderAddrsId</th>
                        <th>OrderPrice</th>
                        <th>OrderStatus</th>
                        <th>PartyId</th>
                        <th>BedStatus</th>
                        <th>Actions</th>
                            
                    </tr>
                
                <%
                	//looping doctor-order-details
                	for(int i =0;i<getorderDetailsMap.size();i++)
        			{	
        		
                %>
                <tbody>
                
                
                  	<td><a href="Doctor_Patient_Details.jsp?OrderId=<%=getorderDetailsMap.get(i).get("ORDERID")%>"><%=getorderDetailsMap.get(i).get("ORDERID")%></a></td> 
                  	<td> <%=getorderDetailsMap.get(i).get("ORDERPRODUCTID")%> </td>
                    <td> <%=getorderDetailsMap.get(i).get("ORDERFULLTDATE")%> </td>
                    <td> <%=getorderDetailsMap.get(i).get("ORDERFULLTIME")%> </td>
                    <td> <%=getorderDetailsMap.get(i).get("ORDERADDRSID")%> </td>
                    <td> <%=getorderDetailsMap.get(i).get("ORDERPRICE")%> </td>
                    <td> <%=getorderDetailsMap.get(i).get("ORDERSTATUS")%> </td>
                    <td> <%=getorderDetailsMap.get(i).get("PARTYID")%> </td>
                    
                    <td>  
                    	<form action="Update_Bed_Status" method="post" name="hidden_form">
                        	<input type="hidden" name="orderid" value="<%=getorderDetailsMap.get(i).get("ORDERID")%>"/>
                        <!-- 	<input type="hidden" name="bed_status" value="" name="bed_staus" id="status_bed" />  -->
                    		<select name="bed_status" id="bed_Status">
                    				<option value="Yes"  <% if(getorderDetailsMap.get(i).get("BEDSTATUS").equals("Yes")){ %> selected="selected"
                    				<%
                    					}
                    				%>>Yes</option>
                    				<option value="No" <% if(getorderDetailsMap.get(i).get("BEDSTATUS").equals("No")){ %> selected ="selected"
                    				<%
                    					}
                    				%>>No</option>
                    		</select>	
                    </td>
                    
                    
                    <td>
                    		<button type="submit" class="doctor_details_edit place_order_submit_btn" id="change_status"><i class="fas fa-pencil-alt"></i>Change Status</button>&nbsp;
                        </form>
                    </td>

                </tbody>
                <%
        			}
                %>
                </thead>
            </table>
        
    </section>

<script>
$(document).ready(function() {
	
    		$('select#bed_Status').change(function() {
        		var selectedbedstatus = $(this).find('option:selected').val();
        			$("#status_bed").val(selectedbedstatus);
					//$("#hidden_form").submit()
   	 		});
});
</script> 
<%@include file="Footer.jsp"%>