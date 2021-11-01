<%@include file="header.jsp"%>

 <section class="form_party">

        <form action="Admin_Add_Party" method="post">

            <div class="container">

                <div class="party_form">

                    <h1 class="Form_title"> Admin Party Form </h1>
                    <span class="party_title">Party Info:</span>

                    <div class="party_basic_details">
                        <label for="party_id" class="party_ID">Party Id:</label>
                        <input type="text" placeholder="Party id" class="partyid_input" name="party_id" required />

                        <label for="party_type" class="party_type_label">Party Type:</label>
                        <select id="party_Type" name="party_type" class="p_type_select" required>
                            <option value="patient"> Patient </option>
                            <option value="doctor"> Doctor </option>
                        </select>
                        <span class="partytype_msg"> (*select one party type ) </span>
                    </div>

                    <div class="party_names">
                        <label for="fname">FirstName:</label>
                        <input type="text" name="firstname" placeholder="FirstName" class="party_namefield" required />

                        <label for="fname" class="mname_label">MiddleName:</label>
                        <input type="text" name="middlename" placeholder="MiddleName" class="party_namefield" required />

                        <label for="fname" class="lname_label">LastName:</label>
                        <input type="text" name="lastname" placeholder="LastName" class="party_namefield" required />
                    </div>

                    <div class="dob_gender">
                        <label for="dob"> Date of Birth: </label>
                        <input type="date" class="admin_datepicker" name="date" required="required"
                            data-date-format="dd/mm/yyyy" />

                        <label for="Gender" class="admin_gender">Gender:</label>
                        <input type="radio" name="gender" id="male" />
                        <label for="Gender_Male">Male</label>

                        <input type="radio" name="gender" id="female" />
                        <label for="Gender_Female">Female</label>

                        <input type="radio" name="gender" id="other" />
                        <label for="Gender_other">Other</label>
                    </div>

                    <div class="party_phone_email">
                        <label> Phone : </label>
                        <input type="text" id="phnm" class="register_input" name="phone" placeholder=" +91 888 888 8888"
                            pattern="[0-9]{3} [0-9]{3} [0-9]{4}" maxlength="16" title="Ten digits code" required
                            size="12" />
                        <label class="phonenum_format"> (Eg :+91 989 928 9878) </label>

                        <label> Email: </label>
                        <input type="email" name="email" placeholder="abc@gmail.com"
                            pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" class="admin_eml_field">
                    </div>

                    <div class="party_password">
                        <label> Password: </label>
                        <input type="password" name="pswd" id="password" class="admin_pwd"
                            pattern="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\S+$).{6,}$" required="required" />
                        &nbsp;&nbsp;
                        <label> Confirm Password: </label>
                        <input type="password" name="cnfrmpswd" id="confirm_password" class="admin_pwd"
                            pattern="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\S+$).{6,}$" required="required" />
                    </div>

                    <div class="party_address">
                        <label> Address: </label><br>
                        <input id="sad1" type="text" class="register_input" name="saddrs1" width="10" height="10"
                            size="20" />
                        <label> (Street Address) </label>
                        <input id="sad2" type="text" class="register_input" name="saddrs2" width="10" height="10"
                            size="20" />
                        <label> (Street Address Line 2) </label>
                        <input id="city" type="text" class="register_input" name="city" width="10" height="10"
                            size="20" />
                        <label> (City) </label>
                        <input id="state" type="text" class="register_input" name="state" width="10" height="10"
                            size="20" />
                        <label> (State) </label>
                        <input id="zpcode" type="text" class="register_input" name="zcode" width="10" height="10"
                            size="20" />
                        <label> (Postal/ZipCode) </label>
                    </div>

                    <div class="registerbtn_container">
                        <button type="submit" class="registerbtn">Add Party</button>
                    </div>
                </div>
            </div>
        </form>
	<div class="clearfix"></div>
	
    </section>	

<%@include file="Footer.jsp"%>
