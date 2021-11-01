<%@include file="header.jsp" %>
		
<section>
	
	<div class="container payment_info_form_container">
        <form  action="Payment_Form" method="post" class="form-horizontal" role="form">
        	<input type="hidden" value="<%=request.getAttribute("ProductId")%>" name="productId">
        	<input type="hidden" value="<%=request.getAttribute("SlotDate")%>" name="slotdate">
        	<input type="hidden" value="<%=request.getAttribute("SlotTime")%>" name="slotTime">
        	<input type="hidden" value="<%=request.getAttribute("partyAddrsid")%>" name="partyaddrsId">
        	<input type="hidden" value="<%=request.getAttribute("OrderPrice")%>" name="orderPrice">
        	<input type="hidden" value="<%=request.getAttribute("PartyId")%>" name="partyId">
        	<input type="hidden" value="<%=request.getAttribute("Producttype")%>" name="productType">
        	<input type="hidden" value="<%=request.getAttribute("paymentOption")%>" name="PaymentOption">
        	
        <fieldset>
            <legend>
              <h1 class="form-top payment_form_header">Payment</h1>
            </legend>
            <div class="form-group">
              <label class="col-sm-3 control-label" for="card-holder-name">Name</label>
              <div class="col-sm-9">
                <input type="text" class="form-control payment_info_form_input" name="card-holder-name" id="card-holder-name" placeholder="Card Holder's Name" required="required">
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-3 control-label" for="card-number">Card Number:</label>
              <div class="col-sm-9">
                <input type="text" class="form-control payment_info_form_input" name="card-number" id="card-number" placeholder="Debit/Credit Card Number" required="required">
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-3 control-label" for="expiry-month">Expiration</label>
              <div class="col-sm-9">
                <div class="row">
                  <div class="col-md-6">
                    <select class="form-control payment_info_form_input  card_years" name="expiry-month" id="expiry-month" required="required">
                      <option>Month</option>
                      <option value="Jan">Jan</option>
                      <option value="Feb">Feb</option>
                      <option value="Mar">Mar</option>
                      <option value="Apr">Apr</option>
                      <option value="May">May</option>
                      <option value="June">June</option>
                      <option value="July">July</option>
                      <option value="Aug">Aug</option>
                      <option value="Sep">Sep</option>
                      <option value="Oct">Oct</option>
                      <option value="Nov">Nov</option>
                      <option value="Dec">Dec</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <select class="form-control payment_info_form_input" name="expiry-year" required="required">
                      <option value="2021">2021</option>
                      <option value="2022">2022</option>
                      <option value="2023">2023</option>
                      <option value="2024">2024</option>
                      <option value="2025">2025</option>
                      <option value="2026">2026</option>
                      <option value="2027">2027</option>
                      <option value="2028">2028</option>
                      <option value="2029">2029</option>
                      
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-3 control-label" for="cvv">Card CVV</label>
              <div class="col-sm-6">
                <input type="text" class="form-control payment_info_form_input" name="cvv" id="cvv" placeholder="Security Code" required="required">
              </div>
            </div>
            <br>
            <div class="form-group">
              <div class="col-sm-12">
                <button type="submit" class="btn btn-success" id="payment-now">Pay Now</button>
              </div>
            </div>
          </fieldset>
        </form>
      </div>
    
</section>
		
<%@include file="Footer.jsp" %>