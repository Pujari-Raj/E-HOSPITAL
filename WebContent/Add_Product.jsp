<%@include file="header.jsp"%>

	<section class="product_form_section">
        <form action="Admin_Add_Product" method="post" enctype="multipart/form-data">
            <div class="container">
                <div class="product_form">
                    
                    <h1 class="Form_title"> Add Product Form </h1>
                    <span class="party_title">Product Info:</span>
 
                    <div class="product_dscrptn">
                        <label for="party_id" class="party_ID">Product Description:</label>
                        <input type="text" placeholder="Product Description" class="Product_dscrptn_input" name="product_dscrptn" required />    
                    </div>

                    <div class="product_name">
                        <label for="party_id" class="party_ID">Product Name:</label>
                        <input type="text" placeholder="Product Name" class="Product_dscrptn_input" name="product_name" required />    
                        
                        <span class="partytype_msg"> (*If Product is Doctor then mention Qualification) </span>
                    </div>
                    
                    <div class="product_price">
                        <label for="party_id" class="party_ID">Product Price(MRP):</label>
                        <input type="text" placeholder="Product Price" class="Product_price_input" name="product_mrp" required />    
                        
                        <label for="party_id" class="party_ID product_discountprice">Product Price(DiscountPrice):</label>
                        <input type="text" placeholder="Product Price" class="Product_price_input" name="product_discount" required />    
                    </div>

                    
                    <div class="product_details">
                        <label for="party_id" class="party_ID"> Cateogry Id:</label>
                        <input type="text" placeholder="Cateogry Id" class="Product_price_input" name="product_category" required />    
                        
                        <label for="party_id" class="party_ID"> Product Type:</label>
                        <input type="text" placeholder="Product Type" class="Product_price_input" name="product_type" required /><br>    
                        
                           
                        <span class="partytype_msg"> (*If Product is Doctor then Partyid should be same else null) </span>
                       
                    </div>

					<div class="product_img">
                        <label for="Product_img" class="party_ID"> Product Image: </label>
                        <input type="file" name="product_img"/>
                    </div>
                    	
					<div class="registerbtn_container">
                        <button type="submit" class="add_product_btn">Add Product </button>
                    </div>
                
                </div>
            </div>
        </form>
    </section>

<%@include file="Footer.jsp"%>
