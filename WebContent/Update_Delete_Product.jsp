<%@page import="java.util.List"%>
<%@include file="header.jsp"%>

<%
		List<Map<String, Object>> productsMap  = EntityQuery.queryList("PRODUCT", null);
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
                                <th>Product Id</th>
                                <th>Product Descprtn</th>
                                <th>Product Name</th>
                                <th>MRP Price</th>
                                <th>Discount Price</th>
                                <th>Product Image</th>
                                <th>Cateogory</th>
                                <th>Product Type</th>
                                <th>Party Id</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        	for(int i=0;i<productsMap.size();i++)
                        	{
                        %>
                            <td><a href="Product_Details.jsp?ProductId=<%=productsMap.get(i).get("PID")%>"> <%=productsMap.get(i).get("PID")%></a></td>
                            <td><%=productsMap.get(i).get("PRDTDSCRPTN")%></td>
                            <td><%=productsMap.get(i).get("PRDTNAME")%></td>
                            <td><%=productsMap.get(i).get("PRDTMRPPRICE")%></td>
                            <td><%=productsMap.get(i).get("PRDTDSCTPRICE")%></td>
                            <td><%=productsMap.get(i).get("PIMAGEURL")%></td>
                            <td><%=productsMap.get(i).get("CATERGORYID")%></td>
                            <td><%=productsMap.get(i).get("PRODUCTTYPE")%></td>
                            <td><%=productsMap.get(i).get("PARTYID")%></td>
                             
                            <td>
                            
                            
                             <form action="Product_Delete" method="post">
                             	<input  type="hidden" name="productid" value="<%=productsMap.get(i).get("PID")%>"/>
                                <button type="submit" id="btn_delete" class="delete place_order_submit_btn" data-toggle="modal"><i class="fas fa-trash product_delete" data-toggle="tooltip" title="Delete">&#xE872;</i>Delete</button>
                            </form>
                            </td>
                              <div id="snackbar">User Deleted Successfully..</div>
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

<script type="text/javascript">

$(function() {
	  function myFunction() {
	        var x = document.getElementById("snackbar")
	        x.className = "show";
	        setTimeout(function(){ x.className = x.className.replace("show", ""); }, 8000);
	  }

	  $("#btn_delete").on('click', function(e) {
	    myFunction();
	  })
 
</script>

<%@include file="Footer.jsp"%>