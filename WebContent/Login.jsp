		<!-- Hello From Login JSP --->
<%@include file="header.jsp"%>
		
	<!--   Once user gets registeres then user gets forward to login.jsp 
	//And when user login using (email & Password) user gets redirect to login_validate.java servlet -->	
<form action="Login_validate" method="post">

	<%
		//checking whether password is same(in database) or not
		// if the session object of errmsg not return null and true then call err_call function (and display error)
		if(request.getAttribute("err_msg")!=null && (boolean)request.getAttribute("err_msg")==true)
		{
			%>
			<!-- if username and password is not same on click of signup btn display error message  -->
			<script>
		 		window.onload =	function on_err_call(){
					$('p#pswd_err_msg').show()
				}	
			</script>				
		<% 	
			
		}
	%>
	
	<%
		//checking whether password is same(in database) or not
		// if the session object of errmsg not return null and true then call err_call function (and display error)
		if(request.getAttribute("usrnm_err_msg")!=null && (boolean)request.getAttribute("usrnm_err_msg")==true)
		{
			%>
			<!-- if username and password is not same on click of signup btn display error message  -->
			<script>
		 		window.onload =	function on_err_call(){
					$('p#usrnm_err_msg').show()
				}	
			</script>				
		<% 	
			
		}
	%>
	
	<!-- taking the value of productid from Process_checkout and passing it to next page(proceess_checkout)   --> 
	<% 
	if(request.getAttribute("lastVisitedPage")!=null) 
	{
	%>
		<input type="hidden" name="lastVisitedProductId" value="<%=request.getAttribute("lastVisitedPage").toString()%>"/>
	<% 
	}
	%>	 
  <div class="container register_container"> 
   
   <h1 class="Form_title"  style="font-size: 1.75rem; font-weight: bold;"> Login Form</h1>   
    
    
   <div class="Patient_Detail"> 
  <label>  </label>   
	<input id ="fnm" class="register_input login_detail" type="email" style="margin-bottom: 20px;" name="login_email" placeholder= "Enter Email.." size="20" required />   
  <label> </label>   
	<input  id="mdnm" type="password"   class="register_input login_detail"  name="login_password" placeholder="Enter Password" size="15" required />   
  		<!-- Error message if email & password is wrong  -->
  		<p style="color: red; text-align: center; display: none;" id="pswd_err_msg"> (Incorrect username or password) </p>
  		<p style="color: red; text-align: center; display: none;" id="usrnm_err_msg"> (Please enter correct username) </p>
  		
  </div>
 	
	<div class ="registerbtn_container">
       <button type="submit" class="registerbtn" >SignUp</button>    
		<a href="SendEmail.jsp" class="btn_reset"> Reset </a>
	</div><br>
</div>
</form> 
		
<%@include file="Footer.jsp" %> 