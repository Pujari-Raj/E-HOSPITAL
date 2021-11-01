<%@page import="java.util.Map"%>
<%@page import="com.framework.entity.EntityQuery"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Medicinal Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, Sony Ericsson, Motorola web design" />
<script type="applisalonion/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

<!-- Imported theme files -->
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>

<!-- Custom Theme files -->
<link href="css/style.css" rel='stylesheet' type='text/css' />	
<link href="css/slider.css" rel="stylesheet" >

<!-- Script File -->
<script src="js/jquery-1.11.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>

<!--/web-font-->
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/blitzer/jquery-ui.css" rel="stylesheet" type="text/css" />
<!--/script--> <!-- - -->
<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event){		
					event.preventDefault();
					$('html,body').animate({scrollTop:$(this.hash).offset().top},900);
				});
			});
</script>
<title> Medicare.com </title>
</head>
<body>
	<!-- JSP code to change the signup&signin input after user sigin and user logout -->
<%   
      String username="SignUp";//setting the displayname as Signup to register for new user
      String logout="SignIn";//setting the name as SignIn to login for new user
      String logouturl = "Login.jsp"; //if user clicks on SignIn then go to login.jsp
      String myaccounturl = "Register.jsp";//if user clicks on signup button to register himself then got to register.jsp 
      String usereml = "";
    		  
	 if(session.getAttribute("customer")!=null){
		 	usereml = session.getAttribute("customer").toString();
   			username= EntityQuery.queryOne("PARTY", "EMAIL ='"+usereml+"'").get("FNAME").toString();//changing  the signup button to username button
   			logout="Logout";//if user session gets started then change singin button name from signin to logout
   			logouturl = "Logout_Invalidate"; //if user clicks on logout then invalidate the session of the user session invalidate code(logout_invalidate.java)
   			myaccounturl = "MyAccount.jsp"; // myaccount page code(jsp)
	 }
	 
%> 
<%
	if(request.getAttribute("success_message") != null){
	%>
	<div class="msg_box animate slide-in-down"><%=request.getAttribute("success_message")%>!</div>
	<% 		
	}
	else if(request.getAttribute("error_message") != null){
	%>
	<div class="error_box animate slide-in-down"><%=request.getAttribute("error_message")%>!</div>
	<%
	}
%>
  <!--//login ,logout code-->
 
<!--start-home-->

<div class="main-header" id="house">
			<div class="header-strip">
			   <div class="container">
				<p class="location"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span><a href="mailto:info@example.com">basvarajpujari607@gmail.com</a></p>
				<p class="phonenum"><span class="glyphicon glyphicon-earphone" aria-hidden="true"></span> + 91 8108958529 </p>
				
				<!-- Using jsp expression tag to get the dynamic values  -->
				
				<%
					if(session.getAttribute("customer")==null)
					{
				%>
					<p class="location"><span class="" aria-hidden="true"><i class="fas fa-user"></i><a href="<%=myaccounturl %>"><%=username %></a></span> </p>
					<p class="location"><span class="" aria-hidden="true"><i class="fas fa-user"></i><a href="<%=logouturl %>"><%=logout %></a></span> </p>
				
				<% 		
					}
				%>
				
				<%
					if(session.getAttribute("customer")!=null)
					{
						String userEmail = session.getAttribute("customer").toString();
						System.out.print("user email In Index Page- "+userEmail);
						
						Map<String, Object> partyMap = EntityQuery.queryOne("PARTY", "EMAIL ='"+userEmail+"'");
						
						String partyType = (String) partyMap.get("PARTYTYPE");
						System.out.print("PARTYTYPE In Index Page- "+partyType);
						
						if(partyType.equals("Patient"))
						{	
				%>
					<p class="location"><span class="" aria-hidden="true"><i class="fas fa-user"></i><a href="<%=myaccounturl %>"><%=username %></a></span> </p>
					<p class="location"><span class="" aria-hidden="true"><i class="fas fa-user"></i><a href="<%=logouturl %>"><%=logout %></a></span> </p>
				<% 		
						}
					}	
				%>
				
				<%
					if(session.getAttribute("customer")!=null)
					{
						String userEmail = session.getAttribute("customer").toString();
						System.out.print("user email In Index Page- "+userEmail);
						
						Map<String, Object> partyMap = EntityQuery.queryOne("PARTY", "EMAIL ='"+userEmail+"'");
						
						String partyType = (String) partyMap.get("PARTYTYPE");
						System.out.print("PARTYTYPE In Index Page- "+partyType);
						
						if(partyType.equals("Admin"))
						{	
				%>
					<p class="location"><span class="" aria-hidden="true"><i class="fas fa-user"></i><a href="<%=myaccounturl %>"><%=username %></a></span> </p>
					<p class="location"><span class="" aria-hidden="true"><i class="fas fa-user"></i><a href="<%=logouturl %>"><%=logout %></a></span> </p>
					<a href="Admin_Add_Party.jsp" class="admin_party"> Add Party </a>
					<a href="Add_Product.jsp" class="admin_party"> Add Product </a>
					<a href="Update_Delete_Product.jsp" class="admin_party"> Product Details </a>
					<a href="Update_Delete_Party.jsp" class="admin_party"> Party Details </a>
					
				<% 		
						}
					}	
				%>
				
				<%
					if(session.getAttribute("customer")!=null)
					{
						String userEmail = session.getAttribute("customer").toString();
						System.out.print("user email In Index Page- "+userEmail);
						
						Map<String, Object> partyMap = EntityQuery.queryOne("PARTY", "EMAIL ='"+userEmail+"'");
						
						String partyType = (String) partyMap.get("PARTYTYPE");
						System.out.print("PARTYTYPE In Index Page- "+partyType);
						
						if(partyType.equals("Doctor"))
						{	
				%>
					<p class="location"><span class="" aria-hidden="true"><i class="fas fa-user"></i><a href="<%=myaccounturl %>"><%=username %></a></span> </p>
					<p class="location"><span class="" aria-hidden="true"><i class="fas fa-user"></i><a href="<%=logouturl %>"><%=logout %></a></span> </p>
					<a href="Doctor_Order_Details.jsp" class="admin_party"> Patient Details </a> 
				<% 		
						}
					}	
				%>
				
				
				
				
				<div class="social-icons">
					<ul>					
						<li><a href="#"><i class="twitter"> </i></a></li>
						<li><a href="#"><i class="google-plus"> </i></a></li>	
						<li><a href="#"><i class="dribble"> </i></a></li>										
					</ul>
				</div>
				<div class="clearfix"></div>
			</div>
			</div>
			<div class="header-middle">
			  <div class="header-search">
			   <form action="#" method="post">
				<div class="search">
					<input type="search" value="Search" name="search" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Search';}" required="">
				</div>
				<div class="sear-sub">
					<input type="submit" value=" ">
				</div>
				<div class="clearfix"></div>
			</form>
		</div>
	</div>
</div>	
		<!--header-top-->
			<div class="header-top">
			  <div class="container">
					 <nav class="navbar navbar-default">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
					  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					  </button>
						<div class="logo">
							<h1><a class="navbar-brand" href="index.jsp"><span>M</span>edicinal  <img src="images/logo.png" alt=" " /></a></h1>
						</div>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
						  <div class="top-menu">
							<nav class="menu menu--francisco">
									<ul class="nav navbar-nav menu__list">
										<!-- <li class="menu__item"><a href="gallery.jsp" class="menu__link"><span class="menu__helper">Departments</span></a></li>
										 -->
										<li class="menu__item"><a href="index.jsp" class="menu__link"><span class="menu__helper">Home</span></a></li>
										<li class="menu__item"><a href="aboutus.jsp" class="menu__link"><span class="menu__helper">About Us</span></a></li>
										<li class="menu__item"><a href="contactus.jsp" class="menu__link"><span class="menu__helper">Contact Us</span></a></li>
										<li class="menu__item"><a href="Services.jsp" class="menu__link"><span class="menu__helper">Services</span></a></li>
										<li class="menu__item"><a href="DoctorServices.jsp" class="menu__link"><span class="menu__helper">Book Appointment</span></a></li>
									 <!-- 	
									 	<li class="menu__item"><a href="Bed_check.jsp" class="menu__link"><span class="menu__helper">Book Bed</span></a></li>
									 -->	 	
										<li class="menu__item"><a href="FAQ.jsp" class="menu__link"><span class="menu__helper">FAQ</span></a></li>
										
									</ul>
								</nav>
							</div>
					</div>
					<!-- /.navbar-collapse -->
				</nav>
			   <div class="clearfix"></div>
			</div>
	</div>
<!--//header-top-->
