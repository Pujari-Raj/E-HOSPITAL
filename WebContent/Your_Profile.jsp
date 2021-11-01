<%@include file="header.jsp"%>
<%@page import="java.util.Map"%>

<%
		//Getting session value of user to get user details and fecth orders related to user
			String getusereml = (String) session.getAttribute("customer");
			System.out.println("Getting Customer Email- "+getusereml);
		
			//Getting party email using session value
			Map<String, Object> getpartyDetailsMap = EntityQuery.queryOne("PARTY", "EMAIL='"+getusereml+"'");
			String partyid = getpartyDetailsMap.get("PARTYID").toString();
			System.out.print("party id-"+partyid);
%>

<section class="profile_card">
        <h1 class="your_profile_tile"> Your Profile </h1>
        <div class="container">

		<form action="Update_Party_Profile" method="post" id="update_form">	
			<input type="hidden" name="partyid" value="<%=getpartyDetailsMap.get("PARTYID")%>"/>
            <div class="profile_box">
                <ul>
                    <li>
                        <div class="name_card">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="user_name">
                                        <h4 class="user_name_title"> Name: </h4>
                                        <input type="text" name="party_name" value="<%=getpartyDetailsMap.get("FNAME")%>" disabled="disabled" />
                                    	<input type="text" name="party_mname" value="<%=getpartyDetailsMap.get("MNAME")%>" disabled="disabled" />
                                    	
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <a href="#" class="edit_btn" id="party_edit"> Edit </a>
                                    <a href="#" class="update_btn" id="party_detail_update"> Update Changes </a>
                                    
                                </div>
                            </div>
                        </div>
                    </li>

                    <li>
                        <div class="name_card1">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="user_name">
                                        <h4 class="user_name_title"> Email: </h4>
                                       <input  type="text" name="party_email" value="<%=getpartyDetailsMap.get("EMAIL")%>" disabled="disabled"/>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </li>
                    <li> 
                        <div class="name_card1">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="user_name">
                                        <h4 class="user_name_title"> Mobile Phone Number: </h4>
                                       <input type="text" name="party_mobil_no" value="<%=getpartyDetailsMap.get("PHONENO")%>" disabled="disabled"/>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </li>
                    <li> 
                        <div class="name_card1">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="user_name">
                                        <h4 class="user_name_title"> Password: </h4>
                                       <input type="text" name="party_pswd" value="<%=getpartyDetailsMap.get("PSWD")%>" disabled="disabled"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li> </li>
                </ul>
            </div>
         </form> 
        </div>
    </section>

<script>
	$(document).ready(function (){
			$("#party_edit").click(function () {
				$(".profile_box :input").css({"background": "#fff", "border": "1px solid gray", "border-radius": "4px"});
				$(".profile_box :input").prop("disabled", false);
			});
	});
	$(document).ready(function () {
			$("#party_detail_update").click(function () {
				$("#update_form").submit();
			});
	});
</script>
<%@include file="Footer.jsp"%>