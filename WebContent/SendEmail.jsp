<%@include file="header.jsp"%>

<section class="reset_card">
        <div class="card login-form">
            <div class="card-body reset_card_body">
                <h3 class="card-title text-center reset_title"> Reset Password </h3>

                <div class="card-text align-items-center">
                    <form class="reset_form" action="Sendemail" method="post">
                        <div class="form-group">
                            <label class="reset_msg_label">Enter your email address and we will send you a OTP to reset your password.</label>
                            <input type="email" class="form-control form-control-sm" name="resetemail" placeholder="Enter your email address" required="required">
                             <button type="submit" class="btn btn-primary btn-block btn_reset_pwd">Send password reset email</button>   
                        </div>
                    </form>
                </div>
            </div>
        </div>
</section>

<%@include file="Footer.jsp"%>
