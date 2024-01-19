<%@ page import="java.io.*"%> <%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="view.css" />
<title>Product View</title>
<style type="text/css">
@charset "UTF-8";
*, *::before, *::after{
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    --main-blue: #155c96;
    --white: #ffff;
    --black: #0000;
}
body{
    padding: 10px;
}
.container {
    width: 20vw;
    height: 60vh;
    background-color: var(--main-blue);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
    position: absolute;
    top: 50%;
    transform: translate(0, -50%);
    padding: 10px;
}
.container img {
    height: 60%;
    width: 100%;

}
.container span{
    font-size: 1.55rem;
    color: var(--white);
}
.info {
  height: 30%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.related-items{
    width: 60vw;
    height: 60vh;
    background-color: var(--main-blue);
    position: absolute;
    right: 0;
    top: 50%;
    transform: translate(0, -50%);
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
}

 .con {
    background-color: var(--main-blue);
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: var(--white);
    cursor: pointer;
    display: flex;
}

img.product-image {
    width: 100%;
    height: 50%;
}
h4 {
	color: var(--white);
}
</style>
</head>
<body>
	<h1>Product View</h1>
	<%
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/java_assignment",
		      "wise", ""); 
	
	String query = "SELECT * FROM products WHERE product_id = ?";
	String queryResult = (String) request.getAttribute("product_id");
	int productID = Integer.parseInt(queryResult);
	PreparedStatement statement = con.prepareStatement(query);
	statement.setInt(1, productID);
	
	String productName = "";
	float productPrice = 0;
	String productDescription = "";
	String productCategory = "";
	String imageUrl = "";
	String category = "";
	
	ResultSet productResult = statement.executeQuery();
	
	while(productResult.next()){
		productName = productResult.getString("product_name");
		productPrice = productResult.getFloat("price");
		productDescription = productResult.getString("product_description");

		//getting image
		String getPicQuery = "SELECT * FROM product_images WHERE product_id = ?";
      	PreparedStatement picStatement = con.prepareStatement(getPicQuery);
      	picStatement.setInt(1, productID);
      	ResultSet pictureSet = picStatement.executeQuery();      	
      	
      	if(pictureSet.next()){
      		imageUrl = pictureSet.getString("image_url");
      	}
      	
      	//GETTING ALL RELATED PRODUCTS
      	category = productResult.getString("category_id");
      	String queryAllRelated = "SELECT * FROM products WHERE category_id = ?";
      	PreparedStatement categoryStatement = con.prepareStatement(queryAllRelated);
      	categoryStatement.setString(1, category);
      	
      	ResultSet allRelated = categoryStatement.executeQuery();
      	%>
      	
      	<div class="related-items">
      	
      	<% while(allRelated.next()){
      		//RENDER ALL RELATED ITEMS
      		int rID = allRelated.getInt("product_id");
      		String rName = allRelated.getString("product_name");
      		float rPrice = allRelated.getFloat("price");
      		String rDescription = allRelated.getString("product_description");
      		
      		
      		//RELATED PICTURE QUERY
      		String rPicQuery = "SELECT * FROM product_images WHERE product_id = ?";
          	PreparedStatement rPicStatement = con.prepareStatement(rPicQuery);
          	rPicStatement.setInt(1, rID);
          	ResultSet rPicSet = rPicStatement.executeQuery();
          	
          	
          	String rImageUrl = "";
          	if(pictureSet.next()){
          		rImageUrl = rPicSet.getString("image_url");
          		System.out.println(rImageUrl);
          	}
      		
      		%>
      		<form action="../WebApp/ProductView" method="GET" class="con">
      			<img src="<%=rImageUrl %>" alt="no image"/>
      			
	        	<h4 class="product-name"><%= rName %></h4>
	        	<p class="product-price"><%= rPrice %></p>
	        	<p class="product-description"><%=  rDescription%></p>
	        	<input name="product_id" type="text" value="<%= rID %>" style="display: none;">
	        	<button class="view-product-button" type="submit">View Product</button>
      		</form>
      	<% }%>
		</div><% 
	}
	
	%>
	
	<div class="container">
      <img src="<%= imageUrl %>" alt="no image" />
      <div class="info">
      	<span class="product-name">Name: <%= productName %></span>
      <span class="product-price">Price: <%= productPrice %></span>
      <span class="product-description">Description: <%= productDescription %></span>
      </div>
      
    </div>

    <%-- <div class="related-items">
        <form action="WebApp/ProductView" method="GET" class="con">
        <img class="product-image" src="<%= imageUrl %>" alt="no image" />
        <h4 class="product-name"><%= productName %></h4>
        <p class="product-price"><%= productPrice %></p>
        <input name="product_id" type="text" value="<%= productID %>" style="display: none;">
        <button class="view-product-button" type="submit">View Product</button>
      </form>
    </div> --%>
</body>
</html>