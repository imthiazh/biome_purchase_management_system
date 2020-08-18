<%@ page import ="java.sql.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.Date" %>
<% 
		Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
				"root", "");
        
  
        int dept_id = (int)session.getAttribute("dept_id");
        int user_id = (int)session.getAttribute("user_id");
        
        String po_No = request.getParameter("po_No");
        String q_No = request.getParameter("q_No");
        String order_no = request.getParameter("order_no");
        String currency = request.getParameter("currency");
        //String grand_total = request.getParameter("grand_total");
        System.out.println(currency);
        session.setAttribute("currency",currency);
        
        String validity_date=request.getParameter("q_validity");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//give format in which you are receiving the `String date_updated`
	    java.util.Date date = sdf.parse(validity_date);
	    java.sql.Date q_validity = new java.sql.Date(date.getTime());
        System.out.println(q_validity);
        String get_date=request.getParameter("ord_date");
	    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");//give format in which you are receiving the `String date_updated`
	    java.util.Date date2 = sdf2.parse(get_date);
	    java.sql.Date ord_date = new java.sql.Date(date2.getTime());
	    System.out.println(ord_date);
	    String ord_vendor = request.getParameter("ord_vendor");
	    String vendor_address = request.getParameter("vendor_address");
        System.out.println(vendor_address);
		int item_no = Integer.parseInt(request.getParameter("item_no"));
		
		/*System.out.println(po_No);
		System.out.println(q_No);
		System.out.println(order_no);
		System.out.println(ord_date);
		System.out.println(ord_vendor);
		System.out.println(item_no);*/
		
		String[] item_name_array = new String[item_no];
		float[] quantity_array = new float[item_no];
		float[] rate_array = new float[item_no];
		String[] unit_array = new String[item_no];
		float[] cost_array = new float[item_no];
		float grand_total = 0.00f ;
		
		PreparedStatement pst = conn.prepareStatement(
				"INSERT INTO `order_details`(`user_id`,`po_No`,`q_No`,`q_validity`,`order_no`,`currency`,`ord_date`,`ord_vendor`,`vendor_address`) VALUES (?,?,?,?,?,?,?,?,?)"
				);
		pst.setInt(1,user_id);
		pst.setString(2,po_No);
		pst.setString(3,q_No);
		pst.setDate(4,q_validity);
		pst.setString(5,order_no);
		pst.setString(6,currency);
		pst.setDate(7,ord_date);
		pst.setString(8,ord_vendor);
		pst.setString(9,vendor_address);
		pst.executeUpdate();
		
		ResultSet rs_ord;
		PreparedStatement pst_ord = conn.prepareStatement("SELECT MAX(order_id) FROM order_details");
        rs_ord = pst_ord.executeQuery();
        rs_ord.next();
        int max_ord_id = rs_ord.getInt("MAX(order_id)");
        String item_list = " ";
		
		for(int i=1;i<=item_no;i++)
		{
			String curr = String.valueOf(i);
			String item_name = request.getParameter("item_name_"+curr);
			float rate = Float.parseFloat(request.getParameter("rate_"+curr));
			float quantity = Float.parseFloat(request.getParameter("quantity_"+curr));
			String unit = request.getParameter("unit_"+curr);
			float cost = Float.parseFloat(request.getParameter("cost_"+curr));
			
			item_name_array[i-1]=item_name;
			quantity_array[i-1]=quantity;
			rate_array[i-1]=rate;
			unit_array[i-1] = unit;
			cost_array[i-1] = cost;
			grand_total+=cost;
			String qt = String.valueOf(quantity);
			String ut = String.valueOf(unit);
			item_list+=item_name+": "+qt+" "+ut+", ";
			
			PreparedStatement pst2 = conn.prepareStatement(
					"INSERT INTO `add_order_details`(`order_id`, `item_name`, `rate`, `quantity`, `unit`, `cost`) VALUES (?,?,?,?,?,?)"
					);
			pst2.setInt(1,max_ord_id);
			pst2.setString(2,item_name);
			pst2.setFloat(3,rate);
			pst2.setFloat(4,quantity);
			pst2.setString(5,unit);
			pst2.setFloat(6,cost);
			pst2.executeUpdate();
		}
		
		PreparedStatement pst3 = conn.prepareStatement(
				"UPDATE `order_details` SET `item_list`=?, `grand_total`=? WHERE `order_id` = ?;"
				);
		pst3.setString(1,item_list);
		pst3.setFloat(2,grand_total);
		pst3.setInt(3,max_ord_id);
		pst3.executeUpdate();
		session.setAttribute("order_id",max_ord_id);
		session.setAttribute("grand_total",grand_total);
		
		/*int dept_id = (int)session.getAttribute("id");
		String ord_name = request.getParameter("ord_name");
		
		String get_date=request.getParameter("ord_date");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//give format in which you are receiving the `String date_updated`
	    Date date = sdf.parse(get_date);
	    java.sql.Date ord_date = new java.sql.Date(date.getTime());
	    
	    String ord_vendor=request.getParameter("ord_vendor");
	    float ord_cost = Float.parseFloat(request.getParameter("ord_cost"));
	    System.out.println("Here:");
	    System.out.println(ord_cost);
		
		PreparedStatement pst = conn.prepareStatement(
				"INSERT INTO `order_details`(`dept_id`, `ord_name`, `ord_date`, `ord_vendor`, `ord_cost`)VALUES (?,?,?,?,?)"	
				);
		pst.setInt(1,dept_id);
		pst.setString(2,ord_name);
		pst.setDate(3,ord_date);
		pst.setString(4,ord_vendor);
		pst.setFloat(5,ord_cost);
		pst.executeUpdate();
		*/
		/* float mainbudget = (float)session.getAttribute("mainbudget");
		float addbudget = (float)session.getAttribute("addbudget");
		float totalbudget = (float)session.getAttribute("totalbudget");
		float diff = mainbudget-grand_total;
		float bigdiff = addbudget-(grand_total-mainbudget);
		float lessdiff = addbudget - grand_total;
		if(diff>=0){
			PreparedStatement pst2 = conn.prepareStatement("UPDATE `user_details` SET `main_budget`=? WHERE user_id=?");
			pst2.setFloat(1,diff);
			pst2.setInt(2,user_id);
			pst2.executeUpdate();
		}
		else if(bigdiff>0){
			PreparedStatement pst6 = conn.prepareStatement("UPDATE `user_details` SET `main_budget`=?,`add_budget`=? WHERE user_id=?");
			pst6.setFloat(1,0.0f);
			pst6.setFloat(2,bigdiff);
			pst6.setInt(3,user_id);
			pst6.executeUpdate();
		}
		else if(mainbudget==0 && lessdiff>=0)
		{
			PreparedStatement pst4 = conn.prepareStatement("UPDATE `user_details` SET `add_budget`=? WHERE user_id=?");
			pst4.setFloat(1,lessdiff);
			pst4.setInt(2,user_id);
			pst4.executeUpdate();
		}
		else if(grand_total==totalbudget)
		{
			PreparedStatement pst5 = conn.prepareStatement("UPDATE `dept_details` SET `main_budget`=0.00,`add_budget`=0.00 WHERE dept_id=?");
			pst5.setInt(1,dept_id);
			pst5.executeUpdate();
		}
	 */	String redirectURL = "payment.jsp";
	    response.sendRedirect(redirectURL);
%>
<!--   <!DOCTYPE html>
<html>  
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>-->