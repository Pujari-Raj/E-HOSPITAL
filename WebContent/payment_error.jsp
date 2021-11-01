<%@include file="header.jsp"%>

 <section class="payment_error_section">
        <div class="container error_block">
            <div class="ui middle aligned center aligned grid">
              <div class="ui eight wide column">
             
                <form  class="ui large form">
                          
                    <div class="ui icon negative ">
                        
                    <div class="content payment_error_message">
                        
                        <div class="header wrong_err_msg">
                            <span> <i class="fas fa-exclamation pay_error_icon"></i></span>
                          Invalid Credentials/Oops! Something went wrong.
                        </div>
                        <p class="try_agian_para"> While trying to pay, Try again later </p>
                        
                      <a  href="Services.jsp" class="ui large teal submit fluid button btn_try">Continue</a>
                
                    </div>
                      
                   </div>
                
                </form>
              </div>
            </div>
          </div>
</section>



<%@include file="Footer.jsp"%>