<!-- Quizz Question Page -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>
            Quizz Question Print
        </title>

        <style>
            * {
                box-sizing: border-box;
            }

            body{
                margin: 0;
                min-height: 100vh;
                padding: 30px 15px;
                background: linear-gradient(135deg, #eee7ff, #f8edff, #e4e9ff);
                font-family: Arial, Helvetica, sans-serif;
                color: #29213b;
            }
            
            .container {
                width: 100%;
                max-width: 900px;
                margin: 0 auto;
            }

            .block{
                width: 100%;
                background-color: white;
                border-radius: 12px;
                padding: 20px 24px;
                margin-bottom: 18px;
                box-shadow: 0 4px 15px rgba(72, 39, 105, 0.08);
            }

            .quiz-heading {
                background-color: darkmagenta;
                color: white;
                padding: 10px 20px;
                border-radius: 10px;
                margin-bottom: 5px;
            }

            .quiz-heading h1 {
                margin: 0;
                font-size: 22px;
            }

            .block h2 {
                margin-top: 0;
            }
            
            h2 {
                color: #4b245f;
                font-size: 18px;
                line-height: 1.5;
            }

            .category {
                text-align: right;
                color: #8b008b;
                font-size: 13px;
            }

            .options {
                display: block;
                margin: 12px 0;
                line-height: 1.5;
            }

            input[type="radio"]{
                margin-right: 8px;
                accent-color: darkmagenta;
            }

            .actions {
                display: flex;
                gap: 12px;
                margin-top: 20px;
            }

            input[type="submit"],
            input[type="reset"] {
                padding: 12px 22px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
            }
            
            input[type="submit"] {
                background: darkmagenta;
                color: white;
            }

            input[type="reset"]{
                background: #eee5f5;
                color: #681078;
            }

            @media (max-width: 480px) {
                .block {
                    padding: 16px;
                }

                h2 {
                    font-size: 16px;
                }
            }
        </style>
    </head>
    <body>
        <%
        HttpSession mySession = request.getSession(true);
        String userName = (String)mySession.getAttribute("userName");
        String email = (String)mySession.getAttribute("email");
        String enrollno = (String)mySession.getAttribute("Enrollno");

        if(userName == null || enrollno == null || email == null){
            response.sendRedirect("LoginPage.jsp");
            return;
        }
        %>

        <div class="container">
            <div class="quiz-heading">
                <h1> QUIZ QUESTIONS </h1>
                <p> Roll No.:- <u><%= enrollno %> </u></p>
                <p> NAME OF STUDENT:- <u><%= userName %> </u></p>
                <p> EMAIL:- <u><%= email %> </u></p>
            </div>

            <%
            String dbHost = System.getenv("MYSQLHOST");
            String dbPort = System.getenv("MYSQLPORT");
            String dbName = System.getenv("MYSQLDATABASE");
            String dbusername = System.getenv("MYSQLUSER");
            String password = System.getenv("MYSQLPASSWORD");

            if (dbHost == null || dbHost.isBlank()) {
                dbHost = "host.docker.internal";
            }
            if (dbPort == null || dbPort.isBlank()) {
                dbPort = "3306";
            }
            if (dbName == null || dbName.isBlank()) {
                dbName = "quizz";
            }

            String url = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName;
            if (dbusername == null || dbusername.isBlank()) {
                dbusername = "root";
            }
            if (password == null) {
                password = System.getenv("LOCAL_MYSQL_PASSWORD");
            }
            
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
            }catch(ClassNotFoundException e){
                out.println(e.getMessage());
            }

            try{
                Connection connection=DriverManager.getConnection(url,dbusername,password);
                Statement statement=connection.createStatement();
                String query="SELECT * FROM questions";
                ResultSet resultSet=statement.executeQuery(query);
                %>

                <form action="Result.jsp" method="POST" >
                    <%
                    
                    while(resultSet.next()){
                        int questions_id = resultSet.getInt("id");
                        String question = resultSet.getString("question");
                        String category = resultSet.getString("category");
                        %>
                       
                        <div class="block">
                            <h2><%= questions_id %>    <%= question %></h2>
                            <p class="category"> <%= category %> </p>
                            
                            <%
                            String query1="SELECT id,option_text FROM options WHERE question_id=?";
                            PreparedStatement preparedStatement = connection.prepareStatement(query1);
                            preparedStatement.setInt(1,questions_id);
                            ResultSet rst=preparedStatement.executeQuery();
                            
                            while(rst.next()){
                                int id = rst.getInt("id");
                                String option_text = rst.getString("option_text");
                                %>

                                <label class="options">
                                    <input type="radio" 
                                    name="answer_<%= questions_id %>" 
                                    value="<%= id %>" 
                                    required/>
                                    <%= option_text %>
                                </label>
                                
                                <%
                            }
                            
                            rst.close();
                            preparedStatement.close();
                            %>
                        </div><%
                    }
                    %><br>
                    <div class="actions">
                        <input type="submit" value="Submit">
                        <input type="reset" value="Clear form">
                    </div>
                </form>

                <%
                statement.close();
                connection.close();
            }catch(SQLException e){
                e.printStackTrace();
            }
            %>
        </div>
    </body>
</html>


