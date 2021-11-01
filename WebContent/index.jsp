		<%@page import="com.learning.hospital.Utility"%>
		<%@page import="java.util.HashMap"%>
		<%@include file="header.jsp" %>
		<%@page import="java.util.Map"%>
		<%@page import="java.util.List"%>
		<%@page import="com.hospital.productServices.*"%>
		<%@page import="com.framework.entity.*"%>
		
		<!-- //Line Slider -->
		
		<%
			List<Map<String, Object>> listMap = EntityQuery.queryList("PRODUCT","CATERGORYID ='main_product'");
			//Map<String, Object> productMapquery = EntityQuery.queryOne("PARTY", "PARTYID=8 ,PARTYTYPE='Patient'");
			
			Map<String, Object> inParameter = new HashMap<>();
			inParameter.put("PID", new Integer(1));
				
			Map<String, Object> inParameter2 = new HashMap<>();
			inParameter2.put("PRDTMRPPRICE", new Integer(800));
			inParameter2.put("PRDTDSCTPRICE ", new Integer(400));
			
			boolean insertResult = EntityQuery.insertData("PARTYADDRESS", inParameter);
			
			int partyid = 4;	
			int pswd = 10;
			String state = "goa";
			boolean deleteData = EntityQuery.deleteData("STUDENT", "SID="+partyid+", SPSWD="+pswd);
			
			boolean updateData = EntityQuery.updateData("product", inParameter2,inParameter);
				
			// Map<String,Object> paytmMap = Utility.getpaytmtransaction_token(getServletContext().getInitParameter("callback_url"), getServletContext().getInitParameter("Inittransaction_Baseurl"), getServletContext().getInitParameter("Test_Merchant_ID"), getServletContext().getInitParameter("Test_Merchant_Key"), getServletContext().getInitParameter("Website"), "10", "1", getServletContext().getInitParameter("Channel_ID"));
		%>
	 <div class="top_banner">
		<!-- SVG Arrows -->
		<div class="svg-wrap">
			<svg width="64" height="64" viewBox="0 0 64 64">
				<path id="arrow-left" d="M46.077 55.738c0.858 0.867 0.858 2.266 0 3.133s-2.243 0.867-3.101 0l-25.056-25.302c-0.858-0.867-0.858-2.269 0-3.133l25.056-25.306c0.858-0.867 2.243-0.867 3.101 0s0.858 2.266 0 3.133l-22.848 23.738 22.848 23.738z" />
			</svg>
			<svg width="64" height="64" viewBox="0 0 64 64">
				<path id="arrow-right" d="M17.919 55.738c-0.858 0.867-0.858 2.266 0 3.133s2.243 0.867 3.101 0l25.056-25.302c0.858-0.867 0.858-2.269 0-3.133l-25.056-25.306c-0.858-0.867-2.243-0.867-3.101 0s-0.858 2.266 0 3.133l22.848 23.738-22.848 23.738z" />
			</svg>
			
		</div>
		

		<!-- JavaScripts -->
		<script type="text/javascript" src="js/sleekslider.min.js"></script>
		<script type="text/javascript" src="js/app.js"></script>
      <!--welcome-->
 </div>
        <!-- /Line Slider -->
	 <!--footer-->
	 
	<!-- Services  	<img alt="" src="productcontent\IMG-20210313-WA0021.jpg">  -->
		<div class="services" id="services">
			<div class="container">


				<div class="inner_tabs">
				    <h2 class="tittle">Welcome to Medicinal</h2>
					<p class="sub-para">
						We are a solution-driven provider dedicated to exceeding expectations for our residents, patients, employees, and business associates. Our professional doctors deliver compassion, comfort and healing with personalized attention and individualized treatment in every setting.
					</p>
					<div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
						<ul id="myTab" class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#expeditions" id="expeditions-tab" role="tab" data-toggle="tab" aria-controls="expeditions" aria-expanded="true">Medical Surgery</a></li>
							<li role="presentation"><a href="#tours" role="tab" id="tours-tab" data-toggle="tab" aria-controls="tours">Departments</a></li>
							<li role="presentation"><a href="#tree" role="tab" id="tree-tab" data-toggle="tab" aria-controls="tree">Patient life</a></li>
							<li role="presentation"><a href="#safari" role="tab" id="safari-tab" data-toggle="tab" aria-controls="safari">Baby Birth</a></li>
							<li role="presentation"><a href="#trekking" role="tab" id="trekking-tab" data-toggle="tab" aria-controls="trekking">Lab Testing</a></li>
						</ul>
						<div id="myTabContent" class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active" id="expeditions" aria-labelledby="expeditions-tab">
								<div class="col-md-5 col-sm-5 tab-image">
									<img src="images/4.jpg" alt="Medicinal">
								</div>
								<div class="col-md-7 col-sm-7 tab-info">
									<p>
									Medicinal has a well established department of GI Surgery, which focuses on surgical management of diseases of the digestive tract. Our surgeons specialize in performing a variety of procedures on the gastrointestinal system and Liver viz. endoscopy, ultrasound and scope guided biopsies, minimally invasive procedures, bariatric surgeries and advanced surgeries for cancer.
									The department is also equally supported by latest technology to ensure maximum patient safety and excellent procedure outcomes. We also have round the clock laboratory, blood bank, ICU, radiology and emergency services to ensure patients receive the highest level of care in a timely manner.
									</p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tours" aria-labelledby="tours-tab">
								<div class="col-md-5 col-sm-5 tab-image">
									<img src="images/8.jpg" alt="Medicinal">
								</div>
								<div class="col-md-7 col-sm-7 tab-info">
									<p>
										We offer an integrated range of healthcare services from out-patient treatment and diagnostics to advanced clinical care which also extends to personalised home-care services. We keep pace with the latest technological breakthroughs in medical science and equip our hospitals with state-of-the-art facilities on par with global standards. From the simplest to the most complex medical problems, we deliver the most cutting-edge treatment. We serve thousands of patients through our network of hospitals every day and offer quality healthcare to people from India and overseas.
									</p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tree" aria-labelledby="tree-tab">
								<div class="col-md-5 col-sm-5 tab-image">
									<img src="images/5.jpg" alt="Medicinal">
								</div>
								<div class="col-md-7 col-sm-7 tab-info">
									<p> The Patient Department at Medicinal is dedicated to ensuring that international patients have a hassle-free, comfortable medical journey. Our department works extensively with doctors, companies, and NGOs around the world to provide access to quality healthcare at affordable prices. </p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="safari" aria-labelledby="safari-tab">
								<div class="col-md-5 col-sm-5 tab-image">
									<img src="images/6.jpg" alt="Medicinal">
								</div>
								<div class="col-md-7 col-sm-7 tab-info">
									<p>Our mission is to promote evidence based benefits and best practices for childbirth in India by advocating for women reproductive rights and spreading awareness on mother-baby-friendly care. We are a comprehensive network that serves to connect pregnant couples with birth professionals, research, educational, and advocacy organisations in order to provide a platform for professionals and families across India to engage with one another in a supportive and truthful manner.</p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="trekking" aria-labelledby="trekking-tab">
								<div class="col-md-5 col-sm-5 tab-image">
									<img src="images/7.jpg" alt="Medicinal">
								</div>
								<div class="col-md-7 col-sm-7 tab-info">
									<p> Medicinal has a team of 200 senior pathologists and over 2000 technicians delivering diagnostic solutions in the areas of routine, semi specialty and super specialty domains like Oncology, Neurology, Gynaecology, Nephrology and many more.
										We offer a comprehensive range of 4000+ clinical laboratory tests and profiles, which are used for prediction, early detection, diagnostic screening, confirmation and/or monitoring of the disease.</p>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</div>	
			</div>
		</div>
		<!-- //Services -->
			
		<!--medicinal-->
			<div class="medicinal-w3">
				<div class="container">
				    <div class="sub-hd">
						<h3 class="tittle two">OUR <span>SERVICES</span></h3>
					</div>
					<div class="medicinal-w3-grids one">
						<div class="col-md-6 medicinal-w3-grid">
							<div class="col-md-8 medicinal-w3-left">
								<h4>PATIENTS</h4>
								<p> Our Clinical Excellence is rooted in our exceptional team of medical specialists, and highly trained nurses and para medical professionals. Patient centricity is at the heart of everything we do at Medicinal. </p>
							</div>
							<div class="col-md-4 medicinal-w3-right">
								<div class="hi-icon-wrap hi-icon-effect-7 hi-icon-effect-7b">
									<a href="#" class="hi-icon icon1"></a>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="col-md-6 medicinal-w3-grid">
							<div class="col-md-4 medicinal-w3-right">
								<div class="hi-icon-wrap hi-icon-effect-7 hi-icon-effect-7b">
									<a href="#" class="hi-icon icon2"></a>
								</div>
							</div>
							<div class="col-md-8 medicinal-w3-left1">
								<h4>BABY-CARE</h4>
								<p> The decisions you make about childbirth and the maternity care that you receive can have lasting effects on your health and well-being and that of your baby and your family. Childbirth Connection is here to help you become an active participant in your maternity care by learning about your options, thinking about your goals and seeking care that is right for you and your family. </p>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="medicinal-w3-grids">
						<div class="col-md-6 medicinal-w3-grid">
							<div class="col-md-8 medicinal-w3-left">
								<h4>TESTING</h4>
								<p> We offer a comprehensive range of 4000+ clinical laboratory tests and profiles, which are used for prediction, early detection, diagnostic screening, confirmation and/or monitoring of the disease. </p>
							</div>
							<div class="col-md-4 medicinal-w3-right">
								<div class="hi-icon-wrap hi-icon-effect-7 hi-icon-effect-7b">
									<a href="#" class="hi-icon icon3"></a>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="col-md-6 medicinal-w3-grid">
							<div class="col-md-4 medicinal-w3-right">
								<div class="hi-icon-wrap hi-icon-effect-7 hi-icon-effect-7b">
									<a href="#" class="hi-icon icon4"></a>
								</div>
							</div>
							<div class="col-md-8 medicinal-w3-left1">
								<h4>DOCTORS</h4>
								<p> Medicinal has a dedicated team of full time and visiting consultants to focus on important healthcare issues and research that affect patients of all ages. Our team of dedicated doctors is highly qualified and committed to excellence in providing an aesthetically pleasing environment to ensure quality in medical care. </p>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
			
			<!--medicinal-->
			<div class="grid_2" id="tender">
   	 <div class="container">
	       <div class="sub-hd">
						<h3 class="tittle">SUCCESSFUL <span>STORIES</span></h3>
					</div>
   	  <div class="box_1 one">
   	 	<div class="col-md-6">
   	 	       <div class="col_1_of_2 span_1_of_2 multi-gd-text">
				   <a href="#"><img src="images/n1.jpg" class="img-responsive" alt=""></a>
				   <div class="story_desc">
				   	  <h3>Billy Streu</h3>
				   	  <p>Mumbai</p>
				   </div>
 				</div>
				<div class="col_1_of_2 span_1_of_2">
				   <h4>Volunteer Firefighter Threatened By Tongue Tumor</h4>
				   <p class="p1">Billy Streu, 35, says 4 years after he completed treatment for tongue cancer, he is in the best physical shape of his life and he feels better than he has ever felt.</p>
 				</div>
				<div class="clearfix"></div>
		</div>
   	 	<div class="col-md-6">
   	 	      <div class="col_1_of_2 span_1_of_2 multi-gd-text">
				   <a href="#"><img src="images/n5.jpg" class="img-responsive" alt=""></a>
				   <div class="story_desc">
				   	  <h3> Glenn Vaughan </h3>
				   	  <p>KERALA</p>
				   </div>
 				</div>
				<div class="col_1_of_2 span_1_of_2">
				   <h4>Bentall Surgery performed successfully </h4>
				   <p class="p1">Medicinal , set another milestone in field of cardiovascular surgery by performing  highly complex 'Bentall procedure with hemi arch repair'</p>
 				</div>
				<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
   	  </div>
   	  <div class="box_2">
   	 	<div class="col-md-6">
   	 	       <div class="col_1_of_2 span_1_of_2 multi-gd-text">
				   <a href="#"><img src="images/n3.jpg" class="img-responsive" alt=""></a>
				   <div class="story_desc">
				   	  <h3>N.T Jha</h3>
				   	  <p>Jaipur</p>
				   </div>
 				</div>
				<div class="col_1_of_2 span_1_of_2">
				   <h4>Heart Bypass Surgery Success Story</h4>
				   <p class="p1">The Medicinal needed to undergo a surgery as soon as possible. He was assured by Dr. Nilesh and his team of a better health and was provided a comprehensive care by the Heart Institute Team at the hospital.</p>
 				</div>
				<div class="clearfix"></div>
		</div>
   	 	<div class="col-md-6">
   	 	      <div class="col_1_of_2 span_1_of_2 multi-gd-text">
				   <a href="#"><img src="images/n4.jpg" class="img-responsive" alt=""></a>
				   <div class="story_desc">
				   	  <h3>Jay latha</h3>
				   	  <p>Mumbai</p>
				   </div>
 				</div>
				<div class="col_1_of_2 span_1_of_2">
				   <h4>Courage Can Defeat Cancer</h4>
				   <p class="p1">Dr. Darshan Krupali treated him so that he can go back to leading a normal life. Watch his story here.</p>
 				</div>
				<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
   	  </div>
   	 </div>
   </div>
	<!--//team-->
	
	
		
	<!---news-->
	
   <!--/reviews-->
	<div id="review" class="testimonials-review">
		<div class="container">
		<div class="sub-hd">
						<h3 class="tittle lost">WHAT PATIENTS ARE SAYING <span>ABOUT US</span></h3>
					</div>
				<div class="testimonials">
				  <div class="monials">
				      <!--//screen-gallery-->
						<div class="sreen-gallery-cursual">
							 <!-- required-js-files-->
							<link href="css/owl.carousel.css" rel="stylesheet">
							    <script src="js/owl.carousel.js"></script>
							        <script>
							    $(document).ready(function() {
							      $("#owl-demo").owlCarousel({
							        items : 1,
							        lazyLoad : true,
							        autoPlay : true,
							        navigation : false,
							        navigationText :  false,
							        pagination : true,
							      });
							    });
							    </script>
								 <!--//required-js-files-->
						       <div id="owl-demo" class="owl-carousel">
					                   <div class="item-owl">

                                            <p class="speech">I have made a remarkable and full recovery thanks to your quick and caring staff. I will be forever grateful to everyone for the care I received.</p>
                                            <div class="client-info">
                                                <img src="images/t1.jpg" alt=" " />

                                                <h4>Nyisha</h4>
                                                <span>Mumbai</span>
                                            </div>
                                        </div><!-- /.item -->
					                     <div class="item-owl">

                                            <p class="speech">I would recommend this hospital. It was truly a great experience. The best experience I could have asked for as a first-time. Health Chickup.</p>
                                            <div class="client-info">
                                                <img src="images/t2.jpg" alt=" " />

                                                <h4>Preetham Reddy</h4>
                                                <span>Hyderabad</span>
                                            </div>
                                        </div><!-- /.item -->
					                      <div class="item-owl">
										  <p class="speech">The doctors were prompt and quick in their actions. As soon as they knew my exact condition, they were able to make a treatment plan and start it. .</p>
                                            <div class="client-info">
                                                <img src="images/t3.jpg" alt=" " />

                                                <h4>Jay Reddy</h4>
                                                <span>Chennai</span>
                                            </div>
                                        </div><!-- /.item -->
				              </div>
						<!--//screen-gallery-->
					</div>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>	
	<!--//reviews-->
<%@include file="Footer.jsp" %>