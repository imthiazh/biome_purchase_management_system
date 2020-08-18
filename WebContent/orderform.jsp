<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.sql.*"%>
<%

	Class.forName("com.mysql.jdbc.Driver"); // MySQL database connection
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
			"root","");
	int user_id = (int)session.getAttribute("user_id");
	int permit = (int)session.getAttribute("permit");
	String full_name = (String)session.getAttribute("full_name");
	PreparedStatement pst = conn.prepareStatement("SELECT user_commit,user_spent,user_total_budget, main_budget, add_budget from user_details where user_id = ?");
	pst.setInt(1,user_id);
	float main_budget = 0.00f;
	float add_budget = 0.00f;
	float user_total_budget = 0.00f;
	float user_commit = 0.00f;
	float user_spent = 0.00f;
	ResultSet rs = pst.executeQuery();
	while(rs.next()){
			main_budget =  rs.getFloat("main_budget");
			add_budget =  rs.getFloat("add_budget");
			user_total_budget = rs.getFloat("user_total_budget");
			user_commit =  rs.getFloat("user_commit");
			user_spent =  rs.getFloat("user_spent");
		}
	session.setAttribute("mainbudget", main_budget);
	session.setAttribute("addbudget", add_budget);
	float total_budget = main_budget + add_budget;
	session.setAttribute("totalbudget", total_budget);
	
	
	int dept_id = (int)session.getAttribute("dept_id");
	String dept_code = (String)session.getAttribute("dept_code");
	String user_code = (String)session.getAttribute("user_code");
	PreparedStatement pst2 = conn.prepareStatement("SELECT COUNT(*) FROM order_details, user_details WHERE user_details.user_id=order_details.user_id AND user_details.dept_id = ?");
	pst2.setInt(1,dept_id);
	ResultSet rs2 = pst2.executeQuery();
	rs2.next();
	int next_ord_no = rs2.getInt("COUNT(*)")+1;
	/* int user_id = (int)session.getAttribute("user_id"); */
	String dt = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
	String next_yr_date = dt;
	next_yr_date = next_yr_date.substring(next_yr_date.length() - 2);
	
	int next_year_date_int = Integer.parseInt(next_yr_date);
	next_year_date_int+=1;
	next_yr_date = String.valueOf(next_year_date_int);
	
	String default_po_No = "123"+"/"+dt+"-"+next_yr_date+"/"+dept_code+"/"+user_code+"/"+  String.valueOf(  new DecimalFormat("00").format(user_id)  )+"/"+String.valueOf(  new DecimalFormat("0000").format(next_ord_no)  );
	session.setAttribute("default_po_No",default_po_No);
/* 	session.setAttribute("dept_id",3);
	session.setAttribute("user_id",4); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script>
	function validate(){
		var x = document.forms["order_form"]["grand_total"].value;
		var total_budget =  <%=main_budget+add_budget %>
		if(x>total_budget){
			alert("You have exceeded budget !");
			return false;
		}
	}
</script>
<title>Purchase</title>
<style>
body{
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
.class1_div {
  width: 80%;
  border-radius: 5px;
  border-color: green;
  background-color: #E0E0E0;
  padding: 5px;
}
table
{
	width: 100%;
}
form {
	width: 80%;
}
input {
  width: 15%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  border: 3px solid #ccc;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  outline: none;
}
input:focus {
  border: 3px solid #555;
}
.large_size{
	width: 70%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  border: 3px solid #ccc;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  outline: none;
}
.pcalc{
	width: 22%;
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 16px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
}
input[type=submit]{
  width: 30%;
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 16px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
}
.redbutton {
  width: 30%;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  background-color: #f44336;
}
.input{
	vertical-align: middle;
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
 
  border: 1px solid #e7e7e7;
  background-color: #D3D3D3;
}

li {
  border-right: 1px solid #bbb;
  float: left;
}



li a:hover:not(.active) {
  /* background-color: #22ce22; */
  background-color: #5bc25b;
  
}

li:last-child {
  border-right: none;
}

.active {
  color: white;
  background-color: #4CAF50;
}

li a {
  display: inline-block;
  color: #666;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.dropbtn {
  display: inline-block;
  color: #666;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover, .dropdown:hover .dropbtn {
  background-color: #4CAF50;
  color: white;
}

li.dropdown {
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {background-color: #f1f1f1;}

.dropdown:hover .dropdown-content {
  display: block;
}
</style>
</head>
<body>
<ul>
  <li><a href="displaydet.jsp">Home</a></li>
  <%if(permit<=3){%>
  <li><a href="user_budget_display.jsp"  >My Budget</a></li>
	<%} else{%>
	<li><a href="admin_budget_display.jsp"  >My Budget</a></li>
	<%}%>
  
  <li><a href="orderform.jsp" class="active">Place Order</a></li>
  
  <li style="float:right" class="dropdown">
    <a href="javascript:void(0)" class="dropbtn"><%=full_name%></a>
    <div class="dropdown-content">
      <a href="logout.jsp">Logout</a>
      <a href="change_pass.jsp">Change Password</a>
    </div>
  </li>
  <li style="float:right"><img src="icon-user.png" width="40" height="40"></li>
  <!-- <li style="float:right"><a href="logout.jsp">Logout</a></li>
  <li style="float:right"><a href="change_pass.jsp">Change Password</a></li> -->
</ul>
<!-- <script type="text/javascript">
function get_total(){
	var item_no = document.getElementById("item_no");
	alert(item_no);
	function sum(){
		var grand_total_calc = 0.00;
		for(int)
		result.textContent=((form_input.a.value*1)+(form_input.b.value*1)+(form_input.c.value*1));
	}
	var form=document.forms[0],result=document.getElementById('result');
	form.addEventListener('keyup',sum,false);
}
</script> -->
	<script>
	/*function addFields(){
        var number = document.getElementById("member").value;
        var container = document.getElementById("container");
        while (container.hasChildNodes()) {
            container.removeChild(container.lastChild);
        }
        for (i=0;i<number;i++){
  			var parent_div = document.createElement("div");
  			parent_div.classList.add("my_div");
  			
  			var item_identify = document.createTextNode("Item_No" + (i+1)));
  			//item_identify = "Item Name " + (i+1).toString(10);
  			//System.out.println(item_identify);
  			var input = document.createElement("input");
            input.type = "text";
            var curr = i+1;
            var cur = curr.toString(10);
            var item_name = "item_name_";
            var final = detail.concat(cur);
            input.id = final;
            input.name = final;
            //input.name = final;
            parent_div.appendChild(item_identify);
            parent_div.appendChild(input);
            
            var example = document.getElementById('container');
            example.appendChild(parent_div);

            //$(".my_div Text, .my_div input").css('display', 'inline-block')
            
            
            
      
        }
    }*/
 /*    function getCost(var number){
    	
    } */
    
    function addFields(){
        number = document.getElementById("item_no").value;
        /* getCost(number); */
        /* alert(number); */
        /* function sum(){
    		var grand_total_calc = 0.00;
    		for(var i=1;i<=number;i++){
    			
    		}
    		result.textContent=((form_input.a.value*1)+(form_input.b.value*1)+(form_input.c.value*1));
    	} */
        /* var a = 0; */
        var flg = 0;
        if(number<1){
        	alert("Minimum no. of items is 1");
        	return;
        }
        flag = 1;
        /* var container1 = document.getElementById("container1");
        while (container1.hasChildNodes()) {
            container1.removeChild(container1.lastChild);
        } */
        var container2 = document.getElementById("container2");
        while (container2.hasChildNodes()) {
            container2.removeChild(container2.lastChild);
        }
        for (i=0;i<number;i++){
        	container2.appendChild(document.createTextNode("Item " + (i+1)+" :"));
            //container1.appendChild(document.createTextNode("Item Name " + (i+1)));
            
            var input = document.createElement("textarea");
			//var button = document.createElement("button");
			var curr = i+1;
            var cur = curr.toString(10);
            var item_name = "item_name_";
            var item_name_rd = "Item Name";
            var assign = item_name.concat(cur);
            var assign_rd = item_name_rd;
            input.id = assign;
            input.name = assign;
            input.className = "input";
            input.placeholder = assign_rd;
            input.required=true;
			input.maxLength = "5000";
			input.cols = "12";
			input.rows = "2";
			container2.appendChild(input);
			//div.appendChild(button);
            
            /* var input = document.createElement("input");
            input.type = "text";
            //input.class="small_size";
            var curr = i+1;
            var cur = curr.toString(10);
            var item_name = "item_name_";
            var item_name_rd = "Item Name";
            var assign = item_name.concat(cur);
            var assign_rd = item_name_rd;
            input.id = assign;
            input.name = assign;
            input.placeholder = assign_rd;
            input.required=true;
            container2.appendChild(input); */
            
            
            
            var input2 = document.createElement("input");
            input2.type = "number";
            //input.class="small_size";
            var curr = i+1;
            var cur = curr.toString(10);
            var quantity = "quantity_";
            var quantity_rd = "Quantity";
            var assign = quantity.concat(cur);
            var assign_rd = quantity_rd;
            input2.id = assign;
            input2.name = assign;
            input2.placeholder = assign_rd;
            input2.required=true;
            input2.value=1;
            container2.appendChild(input2);
            
            var input4 = document.createElement("input");
            input4.type = "text";
            //input.class="small_size";
            var curr = i+1;
            var cur = curr.toString(10);
            var unit = "unit_";
            var unit_rd = "Measuring Units";
            var assign = unit.concat(cur);
            //var assign_rd = unit_rd.concat(cur);
            input4.id = assign;
            input4.name = assign;
            input4.placeholder = unit_rd;
            input4.required=true;
            container2.appendChild(input4);
            
            
            //container1.appendChild(document.createTextNode("Rate of Item " + (i+1)));
            var input3 = document.createElement("input");
            input3.type = "number";
            //input.class="small_size";
            var curr = i+1;
            var cur = curr.toString(10);
            var rate = "rate_";
            var rate_rd = "Rate";
            var assign = rate.concat(cur);
            var assign_rd = rate_rd;
            input3.id = assign;
            input3.name = assign;
            input3.placeholder = assign_rd;
            input3.required=true;
            container2.appendChild(input3);
            /* container1.appendChild(document.createElement("br"));
            container1.appendChild(document.createElement("br"));
            container1.appendChild(document.createElement("br")); */
            
            
            var input5 = document.createElement("input");
            input5.type = "number";
            //input.class="small_size";
            var curr = i+1;
            var cur = curr.toString(10);
            var cost = "cost_";
            var cost_rd = "Cost";
            var assign = cost.concat(cur);
            //var assign_rd = unit_rd.concat(cur);
            input5.id = assign;
            input5.name = assign;
            input5.placeholder = cost_rd;
            input5.required=true;
            /* float q = document.getElementById("quantity_"+i+1);
            float r = document.getElementById("rate_"+i+1);
            input5.value = q*r; */
            container2.appendChild(input5);
            
            var values = ["INR", "USD", "EURO", "JPY", "GBP", "CHF"];
            /* var value_display = ["INR (Indian rupee)", "USD (United States dollar)",
            	"EUR (European euro)", "JPY (Japanese yen)",
            	"GBP (Pound sterling)", "CHF (Swiss franc)"];
			var i = 0;*/
            /*
            <option value="INR">INR (Indian rupee)</option>
		    <option value="USD">USD (United States dollar)</option>
		    <option value="EURO">EUR (European euro)</option>
		    <option value="JPY">JPY (Japanese yen)</option>
		    <option value="GBP">GBP (Pound sterling)</option>
		    <option value="CHF">CHF (Swiss franc)</option>
            */
            var select = document.createElement("select");
            select.name = "currency";
            select.id = "currency";

            for (const val of values) {
              var option = document.createElement("option");
              option.value = val;
              //option.text = value_display[i];
              //i=i+1;
              option.text = val;
              select.appendChild(option);
            }

            container2.appendChild(select);
            
            
            container2.appendChild(document.createElement("br"));
        }
        
        var input7 = document.createElement("input");
        input7.type = "number";
        input7.id = "grand_total";
        input7.name = "grand_total";
        /* input7.value = grand_total_calc; */
        input7.placeholder = "Grand Total";
        input7.required=false;
        input7.readOnly=true;
        
        container2.appendChild(input7);
        
        container2.appendChild(document.createElement("br"));
        /*var input_submit = document.createElement("input");
        input_submit.type = "submit";
        input_submit.value = "Submit";
        container2.appendChild(input_submit);*/
    }
	</script>
	<script>
	function auto_calc(){
		var item_no = document.getElementById("item_no").value;
		var grand_total_calc = 0.00;
		for(var i=0;i<item_no;i++){
			var curr = i+1;
            var cur = curr.toString(10);
            var cost = "cost_";
            var assign = cost.concat(cur);
			grand_total_calc+=parseFloat(document.getElementById(assign).value);
		}
		document.getElementById("grand_total").value=grand_total_calc;
	}
	</script>
	<center><br><br>
	<b>---- Available Funds ----</b><br></br>
			<b>Allotted Budget: <%=(float)user_total_budget%>&emsp;
			<%Float user_total_used_budget = (float)user_commit+(float)user_spent;%>
			Used Budget: <%=(float)user_total_used_budget%>&emsp;
			Available Budget: <%=(float)main_budget%>&emsp;      
			
			Total Available Budget (Addl. 10%): <%=(float)total_budget%>&emsp;</b>
			<br><br><br>
		<div class="class1_div">
		<br>
		<form name="order_form" action="record.jsp" onsubmit="return validate()" method="get">
		<table border="0">
		<tr>
		<td colspan=2 align=center>
			<h1>Purchase Form</h1>
		</tr>
		<tr>
			<td><b>PO Number:</b></td> 
			<td><input class="large_size" type="text" id="po_No" name="po_No" value="<%=default_po_No%>" required></input></td>
		</tr>
		
		<tr>
			<td><b>PO Date:</b></td> 
			<td><input type="date" class="large_size" id="ord_date" name="ord_date" required></input></td>
		</tr>
		
		<tr>
			<td><b>Quotation No.:</b></td> 
			<td><input type="text" class="large_size" id="q_No" name="q_No" required></input></td>
		</tr>
		<tr>
			<td><b>Quotation Valid Till:</b></td> 
			<td><input type="date" class="large_size" id="q_validity" name="q_validity" required></input></td>
		</tr>
		<!-- <tr>
			<td><b>Order No.:</b></td> 
			<td><input type="text" class="large_size" id="order_no" name="order_no" required></input></td>
		</tr> -->
		<tr>
			<td><b>Vendor Name:</b></td> 
			<td><input type="text" class="large_size" id="ord_vendor" name="ord_vendor" required></input></td>
		</tr>
		<tr>
			<td><b>Vendor Address:</b></td> 
			<td><textarea class="large_size" id="vendor_address" name="vendor_address" rows="7" required></textarea></td>
		</tr>
		<tr>
			<td><b>Number of items:</b></td>
			<td><input type="number" class="large_size" id="item_no" name="item_no" value=1 required><br /></td>
		</tr>
		
		<!-- <tr>
			<td colspan=2 align=center><a href="https://google.com" class="button">Go to Google</a></td>
		</tr> -->
		
		<tr>
			<td colspan=2 align=center><input type="button" value="Enter Item List" onclick="addFields()"></input></td>
		</tr>
		
		<!-- <tr>
			<td colspan=2 align=center><button onclick="auto_calc()">Auto Calculate</button></td>
		</tr> -->
		<tr>
			<!-- <td><div id="container1"/></td> -->
			<td  colspan=2 align=center><div id="container2"/></td>
		</tr>
		<tr>
			<td colspan=2 align=center><p class="pcalc" onclick="auto_calc()">Auto Calculate</p></td>
		</tr>
		<!-- <tr>
			<td colspan=2 align=center><button onclick="auto_calc()">Auto Calculate</button></td>
		</tr> -->
		<!-- <tr>
		<td colspan=2 align=center><br><br><input type="submit" value="Submit"/></td>
		</tr> -->
		
		<!-- <tr>
			<td><b>Item Name:&nbsp;&nbsp;&nbsp;&emsp;&emsp;</b></td>
			<td><input type="text" id="ord_name" name="ord_name" required></input></td>
		</tr>
		
		<tr>
			<td><b>Date:</b></td> 
			<td><input type="date" id="ord_date" name="ord_date" required></input></td>
		</tr>
		<tr>
			<td><b>Name:</b></td> 
			<td><input type="text" id="ord_vendor" name="ord_vendor" required></input></td>
		</tr>
		<tr>
			<td><b>Cost:</b></td> 
			<td><input type="number" id="ord_cost" name="ord_cost" required step="0.01"></input></td> 
		</tr>
		<tr>
		<td colspan=2 align=center><br><br><input type="submit" value="Submit" /></td>
		</tr> -->
		<tr>
		<td colspan=2 align=center><input type="submit" value="Add Payment Option"/></td>
		</tr>
		
		<tr>
		<td colspan=2 align=center><button class="redbutton" onclick="document.location = 'displaydet.jsp'">Cancel Process</button></td>
		</tr>
		</table>
		<br><br>
		</form>
		</div>
		</center>
</body>
</html>