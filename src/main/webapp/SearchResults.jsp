<%@ page import="java.io.*"%> <%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
.results {
	height: 80vh;
	width: 30vw;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -35%);
	padding: 10px;
}
.item{
	width: 100%;
	height: 100px;
	background-color: var(--main-blue);
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	padding: 15px;
	border-radius: 20px;
	margin-bottom: 15px;
}
.item span {
	color: white;
}
.item span.item-name {
	font-size: 1.35rem;}
	p {
		position: absolute;
		left: 50%;
		top: 100px;
		font-size: 1.5rem;
		transform: translate(-50%);
	}
</style>
</head>
<body>
	<div class="navigation">
		<h1>Shopify</h1>
	</div>
	<div class="results">
	
		<%
		int numberOfResults = 0;
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/java_assignment",
			      "wise", ""); 
		
		String searchThis = (String) request.getAttribute("search_this");
		System.out.println(searchThis);
		if(searchThis != null){
			//SEARCH BY NAME
			String queryByName = "SELECT * FROM products WHERE product_name = ? ";
			PreparedStatement qByName = con.prepareStatement(queryByName);
			qByName.setString(1, searchThis);
			
			ResultSet qByNameResult = qByName.executeQuery();
			
			//SEARCH BY CATEGORY
			
			String queryByCat = "SELECT * FROM products where category_id = ?";
			PreparedStatement qByCatStatement = con.prepareStatement(queryByCat);
			qByCatStatement.setString(1, searchThis);
			
			ResultSet qByCatResult = qByCatStatement.executeQuery();
			
			while(qByNameResult.next()){
				numberOfResults++;
				String itemName = qByNameResult.getString("product_name");
				System.out.println(itemName);
				float itemPrice = qByNameResult.getFloat("price");
				String itemCategory = qByNameResult.getString("category_id");
				%>
				<div class="item">
					<span class="item-name"><%= itemName %></span>
					<span class="item-price"><%= itemPrice %></span>
					<span class="item-category"><%= itemCategory %></span>
				</div>
	<% 
			}
			while(qByCatResult.next()){
					numberOfResults++;
					String itemName = qByCatResult.getString("product_name");
					System.out.println(itemName);
					String itemPrice = qByCatResult.getString("price");
					String itemCategory = qByCatResult.getString("category_id");
					%>
					
					<div class="item">
					<span class="item-name"><%= itemName %></span>
					<span class="item-price"><%= itemPrice %></span>
					<span class="item-category"><%= itemCategory %></span>
				</div>
				<%
			}
		}
		
		
	%>
	
	
		<!-- <div class="item">
			<span class="item-name">Iphone8</span>
			<span class="item-price">R3000</span>
			<span class="item-category">Phone</span>
		</div> -->
	</div>
	<p>Result found: <%= numberOfResults %></p>
</body>
</html>















//