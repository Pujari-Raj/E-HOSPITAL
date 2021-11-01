<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@include file="header.jsp"%>

	<%
		// Getting session value of user to get user details and fecth orders related to user
		String getusereml = (String) session.getAttribute("customer");
		System.out.println("Getting Customer Email- "+getusereml);
		
		//Getting party email using session value
		Map<String, Object> getpartyidMap = EntityQuery.queryOne("PARTY", "EMAIL='"+getusereml+"'");
		
		//Getting partyid value from session(email)
		String partyid = (String) getpartyidMap.get("PARTYID");
		 
		//Getting order details of party using partyid
		
		List<Map<String, Object>> getorderDetailsMap = EntityQuery.queryList("ORDERDETAIL", "PARTYID='"+partyid+"'");		
	%>
    <section>
    	<div class="container">
            <span>
                <h3 class="you_order_title"> Your orders </h3>
            </span>
            <%
            	if(getorderDetailsMap.size()<1)
            	{
            %>		
            		<h4 class="no_orders"> Oops! No order Yet </h4>
            <% 	
            	}
            
            	else
            	{	
            %>
            <div class="row"> 
            <% 
            		for(int i =0;i<getorderDetailsMap.size();i++)
            		{	
            			//Getting the orderproductid(i.e- productid) on-by-one from orderdetail table  
            			String productid =  (String) getorderDetailsMap.get(i).get("ORDERPRODUCTID");
            			
            			//Fetching the productdetails using its productid
            			Map<String, Object> getproductdetailsMap = EntityQuery.queryOne("PRODUCT", "PID='"+productid+"'");
            			
            %>
           	    
                <div class="col-md-12">
                    <div class="order_card">
                        <div class="upper_order_card">
            	        
                            <div class="row">
            
                                <div class="col-md-2">
                                    <h5 class="upper_row_card_title"> Order Id </h5>
                                    <span> <%=getorderDetailsMap.get(i).get("ORDERID")%> </span>
                                </div>
                                <div class="col-md-2">
                                    <h5 class="upper_row_card_title"> Date </h5>
                                    <p> <%=getorderDetailsMap.get(i).get("ORDERFULLTDATE")%> </p>
                                </div>
                                <div class="col-md-2">
                                    <h5 class="upper_row_card_title"> Total </h5>
                                    <p> <%=getorderDetailsMap.get(i).get("ORDERPRICE")%>Rs. </p>
                                </div>
                              </div>
                        </div>
                    
                    <div class="inner_box">
                        <div class="row">
                                
                            <div class="col-md-12">
                                <div class="inner_card">
                                    <p> Payment Staus:<span class="pay_status"> Successfull </span> </p>
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="order_detail_card">
                                                <img src="<%=getproductdetailsMap.get("PIMAGEURL")%>">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="order_detail_card1">
                                                <span class="order_product_name"> <%=getproductdetailsMap.get("PRDTDSCRPTN")%> </span>
                                                <span class="order_product_name order_price"><%=getproductdetailsMap.get("PRDTMRPPRICE")%> Rs </span>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                        	<div  class="order_detail_card1">	
                                            	<span class="order_price order_product_name"> Order Fullfilment Date:<%=getorderDetailsMap.get(i).get("ORDERFULLTDATE")%> </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                		</div>
                    </div>
                </div>
               </div> 
               <%
            		}
            	}
                %>               
                 
            </div>
                
        </div>
    </section>


<%@include file="Footer.jsp"%>