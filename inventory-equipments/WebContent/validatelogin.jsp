<%@ page import="java.sql.*"%>
<%
session.removeAttribute("errorMsg");
Class.forName("com.mysql.jdbc.Driver"); // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");
String username_local = request.getParameter("username");
String pass_local  = request.getParameter("pass");
//PreparedStatement pst = conn.prepareStatement("SELECT user_details.dept_id, user_details.pass, user_details.user_code, dept_details.dept_code, user_details.full_name, user_details.username, user_details.permit, user_details.main_budget, user_details.add_budget, user_details.user_id from user_details, dept_details where username=? and pass=? and user_details.dept_id = dept_details.dept_id");
PreparedStatement pst = conn.prepareStatement("SELECT user_details.dept_id, user_details.pass, user_details.user_code, dept_details.dept_code, dept_details.dept_total_budget,dept_details.add_budget AS dept_add_budget ,dept_details.main_budget AS dept_main_budget,dept_details.dept_commit,dept_details.dept_spent, user_details.full_name, user_details.username, user_details.permit, user_details.main_budget, user_details.add_budget, user_details.user_total_budget,user_details.user_commit,user_details.user_spent, user_details.user_id from user_details, dept_details where username=? and pass=? and user_details.dept_id = dept_details.dept_id");
pst.setString(1,username_local);
pst.setString(2,pass_local);
ResultSet rs = pst.executeQuery();
if(!rs.next()){
	//session.removeAttribute("flag");
	System.out.println("inside null");
	String redirectURL1 = "login.jsp";
	//session.setAttribute("flag",1);
	session.setAttribute("errorMsg","Wrong password");
	response.sendRedirect(redirectURL1);
}
else
{
int dept_id = 0;
int user_id = 0;
String dept_code = "local_dept_code";
String username = "local";
String pass = "default_pass";
String user_code = "default_code";
String full_name = "local_full_name";

float dept_total_budget = 0.00f;
float dept_main_budget = 0.00f;
float dept_add_budget = 0.00f;
float dept_commit = 0.00f;
float dept_spent = 0.00f;

float user_total_budget = 0.00f;
float main_budget = 0.00f;
float add_budget = 0.00f;
float user_commit = 0.00f;
float user_spent = 0.00f;
session.setAttribute("flag",1);
int permit = 0;

do{
dept_id = rs.getInt("dept_id");
user_id = rs.getInt("user_id");
dept_code = rs.getString("dept_code");
pass = rs.getString("pass");
user_code = rs.getString("user_code");
full_name = rs.getString("full_name");
System.out.println(full_name);
username = rs.getString("username");
permit = rs.getInt("permit");

dept_total_budget = rs.getFloat("dept_total_budget");
dept_main_budget = rs.getFloat("dept_main_budget");
dept_add_budget = rs.getFloat("dept_add_budget");
dept_commit = rs.getFloat("dept_commit");
dept_spent = rs.getFloat("dept_spent");

user_total_budget = rs.getFloat("user_total_budget");
main_budget = rs.getFloat("main_budget");
add_budget = rs.getFloat("add_budget");
user_commit = rs.getFloat("user_commit");
user_spent = rs.getFloat("user_spent");




System.out.println("Permit is:");
System.out.println(permit);
}while(rs.next());
session.setAttribute("dept_id",dept_id);
session.setAttribute("user_id",user_id);
session.setAttribute("dept_code",dept_code);
session.setAttribute("user_code",user_code);
session.setAttribute("username",username);
session.setAttribute("pass",pass);
session.setAttribute("full_name",full_name);
session.setAttribute("permit",permit);

session.setAttribute("dept_total_budget",dept_total_budget);
session.setAttribute("dept_main_budget",dept_main_budget);
session.setAttribute("dept_add_budget",dept_add_budget);
session.setAttribute("dept_commit",dept_commit);
session.setAttribute("dept_spent",dept_spent );

session.setAttribute("user_total_budget",user_total_budget);
/* session.setAttribute("main_budget ",main_budget );
session.setAttribute("add_budget ",add_budget ); */
session.setAttribute("user_commit",user_commit);
session.setAttribute("user_spent",user_spent);

String redirectURL = "displaydet.jsp";
response.sendRedirect(redirectURL);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>