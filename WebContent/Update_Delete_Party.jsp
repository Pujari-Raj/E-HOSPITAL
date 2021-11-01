<%@page import="java.util.List"%>
<%@include file="header.jsp"%>

<%
		List<Map<String, Object>> productsMap  = EntityQuery.queryList("PARTY",null);
%>

<section class="products_list_section">
 
        <div class="container">
            <div class="products_wrapper row">
                <div class="">
                    <div class="list_product_div">
                        <h2 class="list_product_title">Manage Products</h2>
                    </div>
                    <table class="table table-striped table-bordered products_table">
                        <thead>
                            <tr>
                                <th>Party Id</th>
                                <th>Party Type</th>
                                <th>First Name</th>
                                <th>Middle Name</th>
                                <th>Last Name</th>
                                <th>DOB</th>
                                <th>Gender</th>
                                <th>Mobile No</th>
                                <th>Email</th>
                                <th>Acions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        	for(int i=0;i<productsMap.size();i++)
                        	{
                        %>
                            <td><a href="Party_Details.jsp?PartyId=<%=productsMap.get(i).get("PARTYID")%>"> <%=productsMap.get(i).get("PARTYID")%></a></td>
                            <td><%=productsMap.get(i).get("PARTYTYPE")%></td>
                            <td><%=productsMap.get(i).get("FNAME")%></td>
                            <td><%=productsMap.get(i).get("MNAME")%></td>
                            <td><%=productsMap.get(i).get("LNAME")%></td>
                            <td><%=productsMap.get(i).get("DOB")%></td>
                            <td><%=productsMap.get(i).get("GENDER")%></td>
                            <td><%=productsMap.get(i).get("PHONENO")%></td>
                            <td><%=productsMap.get(i).get("EMAIL")%></td>
                            
                             
                            <td>
                            
                            
                             <form action="Party_Delete" method="post">
                             	<input  type="hidden" name="partyid" value="<%=productsMap.get(i).get("PARTYID")%>"/>
                                <button type="submit" class="delete place_order_submit_btn" data-toggle="modal"><i class="fas fa-trash product_delete" data-toggle="tooltip" title="Delete">&#xE872;</i></button>
                            </form>
                            
                            </td>
                        </tbody>
                        <%
                        	}
                        %>
                    </table>
                </div>
            </div>
        </div>
<div class="clearfix"></div>
   	  
    </section>


<%@include file="Footer.jsp"%>