<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add new Product</title>
<style>
    *, *::before, *::after{
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    --main-blue: #155c96;
    --white: #ffff;
    --black: #0000;
}
	form {
		height: 60vh;
		width: 40vw;
		background-color: var(--main-blue);
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		display: flex;	
		flex-direction: column;
		justify-content: space-around;
		align-items: center;
		padding: 20px;
		border-radius: 10px;
	}
	form input, select {
		width: 100%;
		height: 10%;
		border-radius: 20px;
		padding-left: 20px;
		font-size: 1.25rem;
		border: none;
	}
	
	form button {
	width: 70%;
	height: 10%;
	border-radius: 20px;
		
	}
	h1 {
	text-align: center;
	font-size: 5rem;
	}
</style>
</head>
<body>
	<h1>ADD NEW PRODUCT</h1>
	<form class="container" method="POST" action="../WebApp/Add">
		<input type="text" name="product_name" placeholder="Name"/>
		<input type="number" name="price"  placeholder="Price"/>
		<input type="text" name="product_description"  placeholder="Description"/>
	<select  name="product_category">
        <option value="phone">phone</option>
        <option value="smartwatch">smartwatch</option>
        <option value="tv">tv</option>
        <option value="laptop">laptop</option>
    </select>
    	<input type="file" name="picture_path"/>
		<button type="submit">Add</button>
	</form>
</body>
</html>