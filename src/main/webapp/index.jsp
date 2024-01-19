<%@ page import="java.io.*"%> <%@ page import = "java.sql.*"%> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="style.css" />
    <title>Shopify</title>
    <style>
    *, *::before, *::after{
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    --main-blue: #155c96;
    --white: #ffff;
    --black: #0000;
}

.navigation {
    width: 100%;
    height: 5%;
    background-color: var(--main-blue);
    display: flex;
    justify-content: center;
    align-items: center;
}
.navigation h1 {
    font-size: 4rem;
    color: var(--white);
}

.navigation .search-container {
    position: absolute;
    left: 50px;

}

.navigation .search-container input {
    height: 40px;
    width: 400px;
    border: none;
    border-radius: 20px;
    padding-left: 10px;
}
.navigation .search-container button {
    height: 40px;
    width: 100px;
    border: none;
    border-radius: 20px;
}
.center {
    height: 80%;
    width: 90%;
    position: absolute;
    top: 52%;
    left: 50%;
    transform: translate(-50%, -50%);
    display: grid;
    grid-template-columns: repeat(5, 300px);
    grid-auto-rows: repeat(2, 500px);
    gap: 20px;
    justify-content: center;
}

.center .con {
    background-color: var(--main-blue);
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: var(--white);
    cursor: pointer;
}

img.product-image {
    width: 100%;
    height: 50%;
}
h4 {
	color: var(--white);
}
.view-product-button{
	height: 40px;
	width: 100px;
	background-color: var(--white);
	color: black;
}
.footer {
    height: 5%;
    width: 100%;
    background-color: var(--main-blue);
    position: absolute;
    bottom: 0%;
    color: white;
    display: flex;
    justify-content: center;
    align-items: center;
}
.footer p {
    font-size: 1.25rem;
}
.newProductButtonWrapper{
	position: absolute;
	right: 10px;
}
.addNewBtn {
	height: 30px;
	width: 150px;
	background-color: white;
	color: black;
	border: none;
	border-radius: 10px;
	 
}
    </style>
  </head>
  <body>
    <div class="navigation">
      <div class="search-container">
        <form action="WebApp/SearchServlet" method="get">
          <input type="text" name="search_this" placeholder="Search item" />
          <button type="submit">Search</button>
        </form>
      </div>
      <h1>Shopify</h1>
      
      <form class="newProductButtonWrapper" method="get" action="WebApp/Add">
      	<button class="addNewBtn" type="submit">Add New Product</button>
      </form>
    </div>

    <div class="center">
      <% Connection con =
      DriverManager.getConnection("jdbc:mysql://localhost:3306/java_assignment",
      "wise", ""); 
      String query = "SELECT * FROM products"; 
      
      PreparedStatement
      statement = con.prepareStatement(query); 
      ResultSet resultSet = statement.executeQuery(); 
      
      
      
      while(resultSet.next()){ 
	   	  int productID = resultSet.getInt("product_id");
	       String productName = resultSet.getString("product_name"); 
	       String productPrice = resultSet.getString("price");  

      	String getPicQuery = "SELECT * FROM product_images WHERE image_id = ?";
      	PreparedStatement picStatement = con.prepareStatement(getPicQuery);
      	picStatement.setInt(1, productID);
      	ResultSet pictureSet = picStatement.executeQuery();
      	
      	
      	String imageUrl = "";
      	if(pictureSet.next()){
      		imageUrl = pictureSet.getString("image_url");
      		System.out.println(imageUrl);
      	}
      	      	
      	
      	%>
      	<form action="WebApp/ProductView" method="GET" class="con">
        <img class="product-image" src="<%= imageUrl %>" alt="" />
        <h4 class="product-name"><%= productName %></h4>
        <p class="product-price"><%= productPrice %></p>
        <input name="product_id" type="text" value="<%= productID %>" style="display: none;">
        <button class="view-product-button" type="submit">View Product</button>
      </form><% 
      }%>

    </div>
    <div class="footer">
      <p>&copy Shopify. All rights reserved.</p>
    </div>

  </body>
</html>
