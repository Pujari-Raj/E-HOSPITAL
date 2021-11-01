<%@include file="header.jsp"%>

<%
	//checking whether password is same(in database) or not
	// if the session object of errmsg not return null and true then call err_call function (and display error)
	
	if(request.getAttribute("invalid_otp_err_msg")!=null && (boolean)request.getAttribute("invalid_otp_err_msg")==true)
	{
	%>
	<!-- if username and password is not same on click of signup btn display error message  -->
	<script>
 		window.onload =	function on_err_call(){
			$('p#invalid_otp_err_msg').show()
	}	
	</script>				
	<% 	
	}
%>

<section class="reset_password_card reset_card">
        <div class="card login-form">
            <div class="card-body reset_password_card_body">
                <h3 class="change_password_title card-title reset_title">Change Password</h3>

                <div class="card-text">
                	
                    <form action="Change_Password" method="post" class="reset_form">
                    		<input type="hidden" value="<%=request.getAttribute("EmailOTP")%>" name="sentOtp"/>	
                        	<input type="hidden" value="<%=request.getAttribute("Email")%>" name="partyEmail"/>	
                        	
                        <div class="form-group">
                        	
                            <label for="forOtp" class="otp_label">Enter Otp:</label>
                            <input type="text" class="form-control form-control-sm" name="enteredOTP" placeholder="Enter OTP" required />
							<p style="color: red; text-align: center; display: none;" id="invalid_otp_err_msg"> (Please Enter valid OTP) </p>
                            <label for="forOtp" class="">Your New Password:</label>
                            <input type="password" class="form-control form-control-sm reset_new_password" name="newPassword1"
                                placeholder="Enter new Password" required />
							<p class="reset_new_password password_hint" > (Password must contain one lowercase&uppercase letter, one number, and be at least 7 characters long.) </p>
                            <label for="forOtp">Repeat New Password:</label>
                            <input type="password" class="form-control form-control-sm reset_new_password" name="newPassword2" placeholder="Repeat new Password" required />

                            <button type="submit" class="btn btn-primary btn-block submit-btn btn_reset_pwd">Confirm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
</section>
    

<%@include file="Footer.jsp"%>