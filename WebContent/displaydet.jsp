   <%@page import="java.sql.DriverManager"%>
		<%@page import="java.sql.ResultSet"%>
		<%@page import="java.sql.Statement"%>
		<%@page import="java.sql.Connection"%>
		<%@page import="java.text.*"%>
		<%@ page import="java.sql.*"%>
<%
Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root","");
ResultSet rs= null;
PreparedStatement pst = conn.prepareStatement("SELECT `order_details`.order_id, `order_details`.ord_status, `dept_details`.dept_name, `dept_details`.dept_id, `user_details`.full_name, `order_details`.po_No, `order_details`.q_No, `order_details`.item_list, `order_details`.grand_total, `order_details`.currency, `order_details`.ord_date, `order_details`.ord_vendor FROM `order_details`,`user_details`,`dept_details` WHERE order_details.user_id=user_details.user_id AND user_details.dept_id=dept_details.dept_id");
rs = pst.executeQuery();
int permit = (int)session.getAttribute("permit");
String full_name= (String)session.getAttribute("full_name");
String user_name = (String)session.getAttribute("user_name");
int user_id = (int)session.getAttribute("user_id");
int dept_id = (int)session.getAttribute("dept_id");
System.out.println("dept id : ");
System.out.println(dept_id);
int row_permit=0;
%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" href="jquery.dataTables.min.css"> -->
<link rel="stylesheet" href="new.css">
<!-- <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css"> -->
<link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.1.7/css/fixedHeader.dataTables.min.css">
<style>
.option_select{
			font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
                appearance: none; 
                font-size: 18px;
                /* font-weight: bold; */
                background: #4CAF50; 
                background-image: none; 
                width: 10%; 
                height: 150%; 
                
                cursor: pointer; 
                text-align: left;
                /* border:1px solid black;*/
                border-radius:3px; 
                color: white;
                border:0px;
   outline:0px;
}

.option_select2{
			font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
                appearance: none; 
                font-size: 18px;

                background: #4CAF50; 
                background-image: none; 
                width: 10%; 
                height: 150%; 
                
                cursor: pointer; 
                text-align: left;
                /* border:1px solid black;*/
                border-radius:3px; 
                color: white;
                border:0px;
   outline:0px;
}

.status_dropdown { 
				font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
                appearance: none; 
                font-size: 18px;
                font-weight: bold;
                background: #4CAF50; 
                background-image: none; 
                width: 100%; 
                height: 100%; 
                
                cursor: pointer; 
                text-align: left;
                /* border:1px solid black;*/
                border-radius:3px; 
                color: white;
                border:0px;
   outline:0px;
}
thead input {
        width: 100%;
    }
button{
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
/* input[type=search]{
  align: center;
  float: center;
  background-color: #4CAF50;
} */
body{
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
table {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
  table-layout:fixed;
  white-space: nowrap; 
}
table td{
	white-space: nowrap;
    overflow: hidden;
}
table  border: 1px solid #ddd;
  padding: 8px;
  overflow: hidden;
  /* white-space: nowrap; */
}
.cell {
  max-width: 100px; /* tweak me please */
  white-space : nowrap;
  overflow : hidden;
}

.hoverclass:hover {
  max-width : 200px; 
  text-overflow: ellipsis;
  overflow : visible;
  white-space : normal;
}
table tr:nth-child(even){background-color: #f2f2f2;}

table tr:hover {background-color: #ddd;}

table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
  
}
th:hover{
     cursor:pointer;
    background:#AAA;
}
input{
  width: 18%;
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
.search_total{
	width: 30%;
}
.search_total2{
	width: 30%;
}
.short_plus_box{
	width: 100%;
}
.searchInput{
	width: 100%;
}
.searchInput2{
	width: 100%;
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

/* .dataTables_wrapper .dataTables_filter {
	float: right;
	text-align: right
} */
</style>


<meta charset="ISO-8859-1">
<title>Home</title>

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script> -->
<!-- <script>
$( function() {
	alert("hello");
});
</script> -->
<script>
function printpdf()
{
var element = document.getElementById('element-to-print');
html2pdf(element);
}
</script>
<script>
function doSubmit()
{
	location.href="logout.jsp";
	//location.href="C:\\Users\Imthiaz\eclipse-workspace\inventory-equipments\WebContent\test\HelloWorld12345.pdf";
	
}
function doSubmit2()
{
	location.href="change_pass.jsp";
}
function doSubmit3()
{
	<%if(permit<=3){%>
		location.href="user_budget_display.jsp";
	<%} else{%>
		location.href="admin_budget_display.jsp";
	<%}%>
}
</script>

</head>
<body id="element-to-print">

<script src="//code.jquery.com/jquery-3.5.1.js"></script>
<script src="//code.jquery.com/jquery-1.8.3.js"></script>
<!-- <script src="//code.jquery.com/jquery-1.6.1.min.js"></script> -->
<script src="html2pdf.bundle.min.js"></script>

<script src="//cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="//cdn.datatables.net/fixedheader/3.1.7/js/dataTables.fixedHeader.min.js"></script>
<!-- <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.1.min.js"></script> -->
<script src="rc3.js"></script>
<script>
    /* Custom filtering function which will search data in column four between two values */
    $.fn.dataTable.ext.search.push(
        function( settings, data, dataIndex ) {
            var min = parseInt( $('#min').val(), 10 );
            var max = parseInt( $('#max').val(), 10 );
            var age = parseFloat( data[3] ) || 0; // use data for the age column
     
            if ( ( isNaN( min ) && isNaN( max ) ) ||
                 ( isNaN( min ) && age <= max ) ||
                 ( min <= age   && isNaN( max ) ) ||
                 ( min <= age   && age <= max ) )
            {
                return true;
            }
            return false;
        }
    );
    
    /* $(document).ready(function() {
        var table = $('#example').DataTable();
         
        // Event listener to the two range filtering inputs to redraw on input
        $('#min, #max').keyup( function() {
            table.draw();
        } );
    } ); */
    </script>
<script>
$(document).ready(function() {
    // Setup - add a text input to each footer cell
    $('#example thead tr').clone(true).appendTo( '#example thead' );
    $('#example thead tr:eq(1) th').each( function (i) {
        var title = $(this).text();
        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
 
        $( 'input', this ).on( 'keyup change', function () {
            if ( table.column(i).search() !== this.value ) {
                table
                    .column(i)
                    .search( this.value )
                    .draw();
            }
        } );
    } );
 
    var table = $('#example').DataTable( {
        orderCellsTop: true,
        fixedHeader: true
    } );
    
    $('#min, #max').keyup( function() {
        table.draw();
    } );
} );
$(document).ready(function(){
    /* $('table td').click(function(){ */
    $('.clicklink').click(function(){
        window.location = $(this).attr('href');
        return false;
    });
});
</script>
<script>
//2nd part
    /* Custom filtering function which will search data in column four between two values */
    $.fn.dataTable.ext.search.push(
        function( settings, data, dataIndex ) {
            var min2 = parseInt( $('#min2').val(), 10 );
            var max2 = parseInt( $('#max2').val(), 10 );
            var age = parseFloat( data[5] ) || 0; // use data for the age column
     
            if ( ( isNaN( min2 ) && isNaN( max2 ) ) ||
                 ( isNaN( min2 ) && age <= max2 ) ||
                 ( min2 <= age   && isNaN( max2 ) ) ||
                 ( min2 <= age   && age <= max2 ) )
            {
                return true;
            }
            return false;
        }
    );
    
    /* $(document).ready(function() {
        var table = $('#example2').DataTable();
         
        // Event listener to the two range filtering inputs to redraw on input
        $('#min, #max').keyup( function() {
            table.draw();
        } );
    } ); */
    </script>
<script>
$(document).ready(function() {
    // Setup - add a text input to each footer cell
    $('#example2 thead tr').clone(true).appendTo( '#example2 thead' );
    $('#example2 thead tr:eq(1) th').each( function (i) {
        var title = $(this).text();
        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
 
        $( 'input', this ).on( 'keyup change', function () {
            if ( table2.column(i).search() !== this.value ) {
                table2
                    .column(i)
                    .search( this.value )
                    .draw();
            }
        } );
    } );
 
    var table2 = $('#example2').DataTable( {
        orderCellsTop: true,
        fixedHeader: true
    } );
    
    $('#min2, #max2').keyup( function() {
        table2.draw();
    } );
} );
$(document).ready(function(){
    /* $('table td').click(function(){ */
    $('.clicklink').click(function(){
        window.location = $(this).attr('href');
        return false;
    });
});
</script>
<!-- <script type="text/javascript">
        $(document).ready(function() {

            $('.hoverclass').each(function() {
                $(this).qtip({
                    content : $(this).text()/*  + "_" + $(this).attr('id') */
                });
            });
        });
    </script> -->
    
<script>
/* comment start
$(document).ready(function() {
    // Setup - add a text input to each footer cell
    $('#example2 thead tr').clone(true).appendTo( '#example2 thead' );
    $('#example2 thead tr:eq(1) th').each( function (i) {
        var title = $(this).text();
        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
 
        $( 'input', this ).on( 'keyup change', function () {
            if ( table.column(i).search() !== this.value ) {
                table
                    .column(i)
                    .search( this.value )
                    .draw();
            }
        } );
    } );
 comment end*/
   /*  var table = $('#example2').DataTable( {
        orderCellsTop: true,
        fixedHeader: true
    } ); */
//comment line } );
/* $(document).ready(function(){
    $('table td').click(function(){
        window.location = $(this).attr('href');
        return false;
    });
}); */
//function status_select_fn() {
	
$(document).ready(function(){
    $('#option_select').on('change', function() {
      
    	if ( this.value == 'Amount')
      {
        $("#date_filter_div").hide();
    	  $("#grand_total_filter_div").show();
      }
      else if ( this.value == 'Date')
      {
        $("#date_filter_div").show();
        $("#grand_total_filter_div").hide();
      }
      else
      {
          $("#grand_total_filter_div").hide();
          $("#date_filter_div").hide();
      }
    });
});

$(document).ready(function(){
    $('#option_select2').on('change', function() {
      
    	if ( this.value == 'Amount')
      {
        $("#date_filter_div2").hide();
    	  $("#grand_total_filter_div2").show();
      }
      else if ( this.value == 'Date')
      {
        $("#date_filter_div2").show();
        $("#grand_total_filter_div2").hide();
      }
      else
      {
          $("#grand_total_filter_div2").hide();
          $("#date_filter_div2").hide();
      }
    });
});

//}
$(document).ready(function(){
	  $("#status_select").on("change", function() {
	   
	    var value = $(this).val().toLowerCase();
	    
	    
	    $("#example tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	  });
	});
</script>
<ul>
  <li><a href="displaydet.jsp" class="active">Home</a></li>
  <%if(permit<=3){%>
  <li><a href="user_budget_display.jsp">My Budget</a></li>
	<%} else{%>
	<li><a href="admin_budget_display.jsp">My Budget</a></li>
	<%}%>
  
  <li><a href="orderform.jsp">Place Order</a></li>
  
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
<%-- <h1>Welcome, <%=full_name%></h1> --%>

<!-- <button type="button" onclick="doSubmit()" style="float:right">Logout</button>
<button type="button" onclick="doSubmit2()" style="float:right">Change Password</button>
<button type="button" onclick="doSubmit3()" style="float:right">Budget Analysis</button> -->
<!-- <a href = "C:/Users/Imthiaz/eclipse-workspace/inventory-equipments/WebContent/test/HelloWorld12345.pdf">Click</a> -->
<center>
<br><h1>All Orders</h1>

<!-- <input id="searchFrom" class="searchInput" type="text" placeholder="From"/>
<input id="searchTo" class="searchInput" type="text" placeholder="To" >
<table class="search_total" border="0" cellspacing="5" cellpadding="5">
        <tbody><tr>
            <td>Minimum age:</td>
            <td><input class="short_plus_box" type="text" id="min" name="min"></td>
        </tr>
        <tr>
            <td>Maximum age:</td>
            <td><input class="short_plus_box" type="text" id="max" name="max"></td>
        </tr>
    </tbody></table> -->


<p align="right"><!-- Filter By: -->
<select name='option_select' id='option_select' class="option_select" align="right">
<option value="Choose" selected>Filter By:</option>
<option value="Amount">Amount</option>
<option value="Date">Date</option>
</select>
<div style='display:none;' id="grand_total_filter_div" name="grand_total_filter_div">

<table class="search_total" border="0" cellspacing="5" cellpadding="5" align="right">
        <tr>
            <td><input class="short_plus_box" type="text" id="min" name="min" placeholder="Min. Total"></td>
            <td><input class="short_plus_box" type="text" id="max" name="max" placeholder="Max. Total"></td>
        </tr>
</table>
</div>
<div style='display:none;' id="date_filter_div" id="date_filter_div">
<table class="search_total" border="0" cellspacing="5" cellpadding="5" align="right">
        <tr>
            <td><input id="searchFrom" class="searchInput" type="text" placeholder="From Date"/></td>
            <td><input id="searchTo" class="searchInput" type="text" placeholder="To Date" ></td>
        </tr>
</table>
</div>
</p>
<table id="example" class="example" border=0>
	<thead>
	<tr>
		<th>Order ID</th>
		<th>Dept Name</th>
		<%if(permit>4){%>
		<th>Faculty</th>
		<th>PO No.</th>
		<th>Q No.</th>
		<%
		row_permit = 2;
		}%>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<%if(permit>4){%>
		<th>View PO</th>
		<%}%>
		<th>Status</th>
	</tr>
	</thead>
	<!-- <tr>
            <th><input type="text" data-column="1"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="2"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="3"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="4"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="5"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="6"  class="form-control" placeholder="Search"></th>
        </tr>   -->   
    <tbody>
	<!-- <tr>
	<td colspan=2 align="center"><input type="text" id="order_id" onkeyup="myFunction()" placeholder="Search for id" title="Type in a id"></input></td>
	</tr> -->
	<!-- <tr>
		<td id="order_id">Order ID</td>
		<td id="po_No">PO No.</th>
		<td id="dept_name">Dept Name</th>
		<td id="item_list">Items</th>
		<td id="grand_total">Grand Total</th>
		<td id="ord_date">Date</th>
	</tr> -->
	<%while(rs.next()){%>
			<tr>
			<td href="show_details.jsp?order_id=<%=rs.getInt("order_id")%>&row_permit=<%=row_permit%>"><%=rs.getInt("order_id")%></td>
			<%-- <td><%=rs.getString("po_No")%></td> --%>
			<td><%=rs.getString("dept_name")%></td>
			<%if(permit>4){%>
			<td ><%=rs.getString("full_name")%></td>
			<td ><%=rs.getString("po_No")%></td>
			<td ><%=rs.getString("q_No")%></td>
			<%}%>
			<td class="hoverclass"><%=rs.getString("item_list")%></td>
			<%String final_total = Float.toString(rs.getFloat("grand_total"))+" "+rs.getString("currency");%>
			<td ><%=final_total%></td>
			<td ><%=rs.getString("ord_vendor")%></td>
			<td ><%=rs.getDate("ord_date")%></td>
			<!-- <td href="login.jsp">Click</td> -->
			<%if(permit>4){%>
			<td><a href="call_printer.jsp?order_id=<%=rs.getInt("order_id")%>" target="_blank">View</a></td>
			<%-- <td class="clicklink" href="call_printer.jsp?order_id=<%=rs.getInt("order_id")%>" target="_blank">View</td> --%>
			<%}%>
			<%if(rs.getInt("ord_status")==0){%>
			<td>Cancelled</td>
			<%} else if(rs.getInt("ord_status")==1){%>
			<td>In Process</td>
			<%} else if(rs.getInt("ord_status")==2){%>
			<td>Completed</td>
			<%} %>
	   </tr>
	<% } %>
	</tbody>
	<tfoot>
	<tr>
		<th>Order ID</th>
		<th>Dept Name</th>
		<%if(permit>4){%>
		<th>Faculty</th>
		<th>PO No.</th>
		<th>Q No.</th>
		<%}%>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<%if(permit>4){%>
		<th>View PO</th>
		<%}%>
		<th>Status</th>
	</tr>
	</tfoot>
</table>
<script>

$(".searchInput").on("input", function() {
		/* alert("inside1"); */
	  var from = stringToDate($("#searchFrom").val());
	  var to = stringToDate($("#searchTo").val());
	  /* alert("inside2"); */
	  $(".example tr").each(function() {
		 /* alert("inside3"); */
	    var row = $(this);
	    <%if(permit>4) {%>
	    /* alert(row.find("td").eq(8).text()); */
	    var date = stringToDate2(row.find("td").eq(8).text());
	    <%} else {%>
	    /* alert(row.find("td").eq(5).text()); */
	    var date = stringToDate2(row.find("td").eq(5).text());
	    <%}%>
	    //show all rows by default
	    var show = true;

	    //if from date is valid and row date is less than from date, hide the row
	    if (from && date < from)
	      show = false;
	    
	    //if to date is valid and row date is greater than to date, hide the row
	    if (to && date > to)
	      show = false;

	    if (show)
	      row.show();
	    else
	      row.hide();
	  });
	});

	//parse entered date. return NaN if invalid
	function stringToDate(s) {
	  var ret = NaN;
	  var parts = s.split("-");
	  date = new Date(parts[0], parts[1], parts[2]);
	  /* date = new Date(parts[2], parts[0], parts[1]); */
	  /* alert(date); */
	  if (!isNaN(date.getTime())) {
	    ret = date;
	  }
	  return ret;
	}
	
	function stringToDate2(s) {
		  var ret = NaN;
		  var parts = s.split("-");
		  date = new Date(parts[0], parts[1], parts[2]);
		  /* date = new Date(parts[2], parts[0], parts[1]); */
		  /* alert(date); */
		  if (!isNaN(date.getTime())) {
		    ret = date;
		  }
		  return ret;
		}
</script>

<%rs.beforeFirst();%>
<%-- <%if(permit>=3){ %>
<table id="mytable" border=1>
	<tr>
		<th id="order_id">Order ID</th>
		<th id="po_No">PO No.</th>
		<th id="dept_name">Dept Name</th>
		<th id="full_name">Faculty</th>
		<th id="item_list">Items</th>
		<th id="grand_total">Grand Total</th>
		<th id="ord_date">Date</th>
	</tr>
	
	<%while(rs.next()){%>
			<tr>
			<center><td><%=rs.getInt("order_id")%></td></center>
			<td><%=rs.getString("po_No")%></td>
			<td><%=rs.getString("dept_name")%></td>
			<td><%=rs.getString("full_name")%></td>
			<td><%=rs.getString("item_list")%></td>
			<td><%=rs.getFloat("grand_total")%></td>
			<td><%=rs.getDate("ord_date")%></td>
		</tr>
	<% } %>
	<tfoot>
    <tr>
		<th>Order ID</th>
		<th>PO No.</th>
		<th>Dept Name</th>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Date</th>
	</tr>
    </tfoot>
</table>
<%}%> --%>
<%-- <table style="width:60%" id="customers">
<thead>
	<tr>
		<th>Order ID</th>
		<th>Dept. Name</th>
		<th>Order Name</th>
		<th>Date</th>
		<th>Vendor</th>
		<th>Expenditure</th>
	</tr>
</thead>
<tbody>
	<%while(rs2.next()){%>
			<tr>
			<center><td><%=rs2.getInt("order_details.ord_id")%></td></center>
			<td><%=rs2.getString("dept_details.dept_name")%></td>
			<td><%=rs2.getString("order_details.ord_name")%></td>
			<td><%=rs2.getDate("order_details.ord_date")%></td>
			<td><%=rs2.getString("order_details.ord_vendor")%></td>
			<td><%=rs2.getFloat("order_details.ord_cost")%></td>
		</tr>
	<% } %>
</tbody>
</table> --%>

<h1>My Dept. Orders</h1>
<p align="right"><!-- Filter By: -->
<select name='option_select2' id='option_select2' class="option_select2" align="right">
<option value="Choose" selected>Filter By:</option>
<option value="Amount">Amount</option>
<option value="Date">Date</option>
</select>
<div style='display:none;' id="grand_total_filter_div2" name="grand_total_filter_div2">

<table class="search_total2" border="0" cellspacing="5" cellpadding="5" align="right">
        <tr>
            <td><input class="short_plus_box" type="text" id="min2" name="min2" placeholder="Min. Total"></td>
            <td><input class="short_plus_box" type="text" id="max2" name="max2" placeholder="Max. Total"></td>
        </tr>
</table>
</div>
<div style='display:none;' id="date_filter_div2" id="date_filter_div2">
<table class="search_total2" border="0" cellspacing="5" cellpadding="5" align="right">
        <tr>
            <td><input id="searchFrom2" class="searchInput2" type="text" placeholder="From Date"/></td>
            <td><input id="searchTo2" class="searchInput2" type="text" placeholder="To Date" ></td>
        </tr>
</table>
</div>
</p>
<table class="example2" id="example2" border=0>
	<thead>
	<tr>
		<th>Order ID</th>
		<!-- <th>Dept Name</th> -->
		<th>Faculty</th>
		<th>PO No.</th>
		<th>Q No.</th>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<th>View PO</th>
		<th>Cancel PO</th>
	</tr>
	</thead>
	<!-- <tr>
            <th><input type="text" data-column="1"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="2"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="3"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="4"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="5"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="6"  class="form-control" placeholder="Search"></th>
        </tr>   -->   
    <tbody>
	<!-- <tr>
	<td colspan=2 align="center"><input type="text" id="order_id" onkeyup="myFunction()" placeholder="Search for id" title="Type in a id"></input></td>
	</tr> -->
	<!-- <tr>
		<td id="order_id">Order ID</td>
		<td id="po_No">PO No.</th>
		<td id="dept_name">Dept Name</th>
		<td id="item_list">Items</th>
		<td id="grand_total">Grand Total</th>
		<td id="ord_date">Date</th>
	</tr> -->
	<%while(rs.next()){
		if(rs.getInt("dept_id")==dept_id){
			%>
			<tr>
			<td href="show_details.jsp?order_id=<%=rs.getInt("order_id")%>&row_permit=2"><%=rs.getInt("order_id")%></td>
			<%-- <td><%=rs.getString("po_No")%></td> --%>
			<%-- <td><%=rs.getString("dept_name")%></td> --%>
			<td><%=rs.getString("full_name")%></td>
			<td><%=rs.getString("po_No")%></td>
			<td><%=rs.getString("q_No")%></td>
			<td><%=rs.getString("item_list")%></td>
			<%String final_total = Float.toString(rs.getFloat("grand_total"))+" "+rs.getString("currency");%>
			<%//System.out.println("hello");%>
			<td><%=final_total%></td>
			<%-- <td><%=Float.toString(rs.getFloat("grand_total"))+rs.getString("currency")%></td> --%>
			<td><%=rs.getString("ord_vendor")%></td>
			<td><%=rs.getDate("ord_date")%></td>
			<td><a href="call_printer.jsp?order_id=<%=rs.getInt("order_id")%>" target="_blank">View</a></td>
			<td><a href="call_cancel.jsp?order_id=<%=rs.getInt("order_id")%>" target="_blank">Cancel</a></td>
	   		</tr>
	<% } %>
	<% } %>
	</tbody>
	<tfoot>
	<tr>
		<th>Order ID</th>
		<!-- <th>Dept Name</th> -->
		<th>Faculty</th>
		<th>PO No.</th>
		<th>Q No.</th>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<th>Export</th>
		<th>Cancel PO</th>
	</tr>
	</tfoot>
</table>
<!-- <input type="button" value="print" onclick="printpdf()"/> -->
<% 
if(permit==3||permit==4||permit==5){%>
<form action="orderform.jsp">
	<input type="submit" value="Place Order"></submit>
</form>
<%
}
%>
</center>
<script>
	
	//document.getElementById("example").rows[3].cells[4].innerHTML="Hello";
	var i = "0";
	//alert("here");
	if(<%=permit%><=4){
		//alert("here1");
		document.getElementById("example").rows[0].deleteCell(6);
		document.getElementById("example").rows[0].insertCell(6);
	document.getElementById("example").rows[0].cells[6].innerHTML="<select class='status_dropdown' id='status_select'><option value='Status' selected>Status</option><option value='In Process'>In Process</option><option value='Cancelled'>Cancelled</option>";
	document.getElementById("example").rows[0].cells[6].style.backgroundColor = "#4CAF50";
	}
	else{
		//alert("here2");
		document.getElementById("example").rows[0].deleteCell(10);
		document.getElementById("example").rows[0].insertCell(10);
		document.getElementById("example").rows[0].cells[10].innerHTML="<select class='status_dropdown' id='status_select'><option value='Status' selected>Status</option><option value='In Process'>In Process</option><option value='Cancelled'>Cancelled</option>";
		document.getElementById("example").rows[0].cells[10].style.backgroundColor = "#4CAF50";
	}
</script>
<script>

$(".searchInput2").on("input", function() {
		/* alert("inside1");  */
		// 2014-01-01 2018-01-01
	  var from2 = stringToDate3($("#searchFrom2").val());
	  var to2 = stringToDate3($("#searchTo2").val());

	  /* alert("inside2"); */
	  $(".example2 tr").each(function() {
		  
	  
		 /* alert("inside3"); */
	    var row = $(this);

	    /* alert(row.find("td").eq(8).text()); */
	    var date = stringToDate4(row.find("td").eq(7).text());
	    /* alert(date); */
	    <%-- <%} else {%>
	    /* alert(row.find("td").eq(5).text()); */
	    var date = stringToDate2(row.find("td").eq(5).text());
	    <%}%> --%>
	    //show all rows by default
	    var show = true;

	    //if from date is valid and row date is less than from date, hide the row
	    if (from2 && date < from2)
	      show = false;
	    
	    //if to date is valid and row date is greater than to date, hide the row
	    if (to2 && date > to2)
	      show = false;

	    if (show)
	      row.show();
	    else
	      row.hide();
	  });
	});

	//parse entered date. return NaN if invalid
	function stringToDate3(s) {
	  var ret = NaN;
	  var parts = s.split("-");
	  date = new Date(parts[0], parts[1], parts[2]);
	  /* date = new Date(parts[2], parts[0], parts[1]); */
	  /* alert(date); */
	  if (!isNaN(date.getTime())) {
	    ret = date;
	  }
	  return ret;
	}
	
	function stringToDate4(s) {
		  var ret = NaN;
		  var parts = s.split("-");
		  date = new Date(parts[0], parts[1], parts[2]);
		  /* date = new Date(parts[2], parts[0], parts[1]); */
		  /* alert(date); */
		  if (!isNaN(date.getTime())) {
		    ret = date;
		  }
		  return ret;
		}
</script>

<!-- <script>
	document.querySelector("#example").rows[0].cells[6].innerHTML=" ";
</script> -->
</body>
</html>