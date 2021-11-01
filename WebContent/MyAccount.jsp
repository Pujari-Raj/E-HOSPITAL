<%@include file="header.jsp"%>

	<section class="my_account">
          <div class="container">
              <span>
                  <h1 class="account_title"> Your Account </h1>
              </span>
            <div class="row">
            	
                <div class="col-md-4">  
                   <div class="Your_order_card">
                   <a href="Your_Orders.jsp" class="account_anchor">
			
                    <div class="Your_order">
                        <img src="images/myaccount/e-hsptl_order_box.png" alt="box_img">
                    	 <h4 class="your_ordercontent_title"> Your Orders </h4> 
                    </div>
                    
                   </div>    
                </div>
                <div class="col-md-4">
                    <div class="Your_order">
                        <a href="Your_Profile.jsp">
                            <div class="Your_order">
                                <img src="images/myaccount/e-hsptl_user_profile.jpg" alt="box_img">
                          		<h4 class="your_ordercontent_title"> Your Profile </h4> 
                            </div>
                          
                    </div>    
                </div>        
                
                <div class="col-md-4">
                    <div class="Your_order">
                        <a href="Your_Address.jsp">
                            <div class="Your_order">
                                <img src="images/myaccount/e-hsptl_user_addrs.png" alt="box_img">
                                <h4 class="your_ordercontent_title"> Your Address </h4> 
                           </div>
                          </a> 
                    </div>    
                </div>
            </div>  
            </div>                   
        </section>
	 
<%@include file="Footer.jsp"%>