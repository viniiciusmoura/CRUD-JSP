<%-- 
    Document   : teste
    Created on : 28 de jul. de 2022, 16:41:14
    Author     : Vinícius Moura
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
JSONArray list = new JSONArray();
Connection con;
PreparedStatement ps;
ResultSet rs;



Class.forName("com.mysql.cj.jdbc.Driver");
con= DriverManager.getConnection("jdbc:mysql://localhost:3306/crud?useSSL=false","root","123456");
ps=con.prepareStatement("select * from usuario");
rs=ps.executeQuery();

while(rs.next())
    {
        JSONObject obj = new JSONObject();
        obj.put("id",rs.getInt(1));
        obj.put("nome", rs.getString(2));
        obj.put("sobrenome", rs.getString(3));
        obj.put("idade", rs.getInt(4));
        list.add(obj);
    }            
rs.close();
ps.close();
out.print(list.toJSONString());
out.flush();
%>