<%@include file="header.jsp"%>

<!-- 	// After user submit the form it will go to Register_User.java servlet to get insert into DBase -->
<form action="Register_User" method="post">
	<div class="container register_container">

		<h1 class="Form_title" style="font-size: 1.75rem; font-weight: bold;">
			Patient Registration Form</h1>

		<!-- Using input type as hidden to get the Partytype and storing it-->
		<input type="hidden" name="Partytype" placeholder="Hidden field"
			value="Patient" />

		<div class="Patient_Name">
			<label> Firstname: </label> 
			<input id="fnm" class="register_input" type="text" name="firstname" placeholder="Firstname" size="15" required /> 
			<label> Middlename: </label> 
			<input id="mdnm" type="text" class="register_input" name="middlename" placeholder="Middlename" size="15" required /> 
			<label> Lastname: </label> 
			<input type="text" id="lnm" class="register_input" name="lastname" placeholder="Lastname" size="15" required />
		</div>

		<div class="dob">
			<label> Date of Birth: </label> <input type="date" class="datepicker"
				name="date" required="required" data-date-format="dd/mm/yyyy" />

		</div>
		<br>

		<div>
			<label> Gender : </label><br> <input type="radio" value="Male"
				name="gender" checked> Male <input type="radio"
				value="Female" name="gender"> Female <input type="radio"
				value="Other" name="gender"> Other
		</div>
		<br>

		<div>
			<label> Phone : </label> <input type="text" id="phnm"
				class="register_input" name="phone" placeholder=" 888 888 8888"
				pattern="[0-9]{3} [0-9]{3} [0-9]{4}" maxlength="20"
				title="Ten digits code" required size="12" > <label
				style="font-size: 15px; padding-left: 20px"> (Eg :989
				928 9878) </label> <br>
		</div>

		<div>
			<label> Email &nbsp;&nbsp;&nbsp; </label> <input type="email"
				name="email" placeholder="abc@gmail.com"
				pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" s>
		</div>
		<br>
		<br>

		<div class="password">
			<label> Password: </label> <input type="password" name="pswd"
				id="password"
				pattern="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\S+$).{6,}$"
				required="required" /> &nbsp;&nbsp;&nbsp;&nbsp; <label>
				Confirm Password: </label> <input type="password" name="cnfrmpswd"
				id="confirm_password"
				pattern="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\S+$).{6,}$"
				required="required" />
			<p id="message" class="passsword_message"></p>
		</div>
		<br> <br>

		<div class="address">
			<label> Address: </label><br> <input id="sad1" type="text"
				class="register_input" name="saddrs1" width="10" height="10"
				size="20" / required="required"> 
				<label style=""> (Street Address) </label> <input
				id="sad2" type="text" class="register_input" name="saddrs2"
				width="10" height="10" size="20"  required="required"> 
				<label style=""> (Street
				Address Line 2) </label> <input id="city" type="text" class="register_input"
				name="city" width="10" height="10" size="20" required="required" > 
				<label style="">
				(City) </label> <input id="state" type="text" class="register_input"
				name="state" width="10" height="10" size="20" required="required" /> <label style="">
				(State) 
				</label> <input id="zpcode" type="number" class="register_input"
				name="zcode" width="10" height="10" size="20" required="required" /> <label style="">
				(Postal/ZipCode) </label>
		</div>

		<div class="registerbtn_container">
			<button type="submit" class="registerbtn">Register</button>
		</div>

	</div>
</form>
<div class="clearfix"></div>

<!-- script for checking the whether Password& Confirm password is same or not-->
<script>
	$('#password, #confirm_password').on(
			'keyup',
			function() {
				if ($('#password').val() == $('#confirm_password').val()) {
					$('#message').html('Password and Confirm Password matched')
							.css('color', 'green');
				} else
					$('#message').html(
							'Password and Confirm Password not matched').css(
							'color', 'red');
			});
</script>
<%@include file="Footer.jsp"%>
