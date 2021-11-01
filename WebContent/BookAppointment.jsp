<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@include file="header.jsp"%>

<%
	List<Map<String, Object>> bedstatusMap = EntityQuery.queryList("BEDRECORD", null); 
%>
  <section>
        <div class="appt_container">
            <h4 class="bed_title"> Pick a Bed(Please select the bed which is available and click on Book Bed) : </h4>

            <ul class="showstatus">

                <li>
                  <p class="status1"><span class="status_space"><i class="fas fa-bed"></i></span>Available</p>   
                </li>
                <li>
                    <p><span class="bedicon_occupied"><i class="fas fa-bed"></i></span>Occupied</p>   
                </li>
            </ul>

            <div class="container bed_container"> 
              <div class="">
				<form action="Book_Bed" method="post" id="bed_form">              	
              <%
              		Map<String, Object> bedMap = EntityQuery.queryOne("BEDRECORD", "BEDSTATUS ='Available'");	
              		for(int row=0;row<bedstatusMap.size()/8;row++)
              		{
              %>
                <div class="row patient_bed">
                
                <%
        			for(int col=0;col<8;col++)
          			{
          				Map<String, Object> bedidMap = EntityQuery.queryOne("BEDRECORD", "BEDROW='"+row+"', BEDCOLUMN='"+col+"'");		
                %>
                    
                    <label>
                    	<% 
                    		if(bedidMap.get("BEDSTATUS").equals("Available"))
                    		{	
                    	%>
                    	  <div class="seat"><span><i class="fas fa-bed bed_size"></i> <%=bedidMap.get("BEDID")%> </span>
                    	  	<input type="radio" name="bed_number" class="book_bed_icon" value="<%=row%>,<%=col%>" autocomplete="off" />	
                    		</div>
                    	<%
                    		}
                    	%> 
                    	<% 
                    		if(bedidMap.get("BEDSTATUS").equals("Occupied"))
                    		{	
                    	%>
                    	  <div class="seat" onclick=""><span><i class="fas fa-bed bed_size bedicon_occupied"></i> <%=bedidMap.get("BEDID")%> </span>
         				 <input type="radio" name="bed_number" id="bed_btn" class="book_bed_icon" value="<%=row%>,<%=col%>"  title="cannot select this bed" onclick="handleClick(this);"  disabled="disabled"/>	
                    	  </div>
                    	<%
                    		}
                    	%> 
                    	
                    	  
                	</label>
                <%
          			}                  
                %>  
                </div> 
		<%
              		}
		%>
				<div class="">
				<button class="btn_proceed btn_return btn_book_bed" onclick="bookbed()">Book Bed</button>
				</div>
				</form>
             </div>    
            </div>
        </div>
    </section>
 
<script type="text/javascript">

$(document).ready(function(){
	 $("bed_from. input[type=radio]").each(function () {
	$(this).prop('checked', false);
	   });
	});
	
	function  showAlert() {
		
		var btn = document.getElementById("bed_btn");
		if (btn.disabled) {
	        alert("CheckBox is Disabled");
	    }
	}
	
	function bookbed()
	{
		if($("input[name='radio']:checked").val())
		{
			$("#bed_form").submit();
		}

	}
	
</script>  
<%@include file="Footer.jsp"%>