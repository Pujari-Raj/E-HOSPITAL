<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@include file="header.jsp"%>

<%
		//checking whether  enter valid OrderId is valid or not 
		// if the session object of errmsg not return null and true then call err_call function (and display error)
		if(request.getAttribute("OrderId_err_Msg")!=null && (boolean)request.getAttribute("OrderId_err_Msg")==true)
		{
			%>
			<!-- if username and password is not same on click of signup btn display error message  -->
			<script>
		 		window.onload=	function on_err_call(){
					$('p#orderId_err_msg').show()
				}	
			</script>				
		<% 	
			
		}
		//checking whether  enter valid OrderId of patient is valid for booking bed / not  
		// if the session object of errmsg not return null and true then call err_call function (and display error)
		
		if(request.getAttribute("bed_check_msg")!=null && (boolean)request.getAttribute("bed_check_msg")==true)
		{
			%>
			<!-- if username and password is not same on click of signup btn display error message  -->
			<script>
		 		window.onload=	function on_err_call(){
					$('p#bed_check_msg').show()
				}	
			</script>				
		<% 	
			
		}

	%>
	<!-- 	<p>session data-</p>  -->
 <section class="bed_form">

        <div class="container">
            <span class="bed_form_title"> Bed Allotment Check </span>

            <div class="row">

                <div class="col-md-6">
                    <div class="form-group">

                        <form action="Bed_Check" method="post">
                            <div class="bed_check_fields">
                                <label for="exampleInputEmail1">Order Id/Appointment Id:</label>
                                <input type="text" class="form-control bed_order_id" id="exampleInputEmail1"
                                    aria-describedby="emailHelp" placeholder="Order Id" name="order_Id">

                                <button type="submit" class="btn  btn_check">Check</button>
                             <p  class="pswd_err_Msg" id="orderId_err_msg"> (Please enter valid OrderId) </p>
                             <p  class="pswd_err_Msg" id="bed_check_msg"> (You cannot book Bed) </p>
 
                            </div>
                        </form>
                    </div>
                </div>
                
            </div>
            
        </div>

</section>
<script type="text/javascript">
	$( "#order_check" ).click(function() {
	 // alert( "Handler for .click() called." );
	});
</script>

<%@include file="Footer.jsp"%>