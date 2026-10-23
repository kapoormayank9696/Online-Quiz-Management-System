<!-- Quizz Question Page -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quiz Questions | Online Quiz</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
           * {
               box-sizing: border-box;
           }

           html {
               min-height: 100%;
           }

           body {
               margin: 0;
               min-height: 100vh;
               padding: 32px 18px;
               background:
                   radial-gradient(ellipse at top left, #e7dcff 0%, transparent 45%),
                   linear-gradient(135deg, #f5f0ff, #fff8ff, #e9edff);
               font-family: "Segoe UI", Arial, Helvetica, sans-serif;
               color: #29213b;
           }

           .container {
               width: 100%;
               max-width: 900px;
               margin: 0 auto;
           }

           .quiz-heading {
               background: linear-gradient(135deg, #3d1058, #701ca0 65%, #8736b8);
               color: white;
               padding: 28px 30px;
               border-radius: 20px;
               margin-bottom: 22px;
               box-shadow: 0 12px 30px rgba(72, 39, 105, 0.18);
               overflow-wrap: anywhere;
           }

           .quiz-heading h1 {
               margin: 0 0 22px;
               font-size: clamp(25px, 4vw, 32px);
               font-weight: 750;
               letter-spacing: 0.3px;
           }

           .quiz-heading p {
               display: inline-block;
               max-width: 100%;
               margin: 5px 8px 5px 0;
               padding: 10px 13px;
               background: rgba(255, 255, 255, 0.12);
               border: 1px solid rgba(255, 255, 255, 0.2);
               border-radius: 9px;
               font-size: 13px;
               line-height: 1.6;
               overflow-wrap: anywhere;
           }

           .quiz-heading u {
               text-underline-offset: 3px;
           }

           .block {
               width: 100%;
               margin: 0 0 18px;
               padding: 24px 26px;
               background: rgba(255, 255, 255, 0.97);
               border: 1px solid #e9def8;
               border-radius: 17px;
               box-shadow: 0 6px 22px rgba(72, 39, 105, 0.07);
           }

           .block h2 {
               margin: 0 0 18px;
               color: #351449;
               font-size: 19px;
               font-weight: 700;
               line-height: 1.65;
               overflow-wrap: anywhere;
           }

           .category {
               display: inline-block;
               max-width: 100%;
               margin: 0 0 14px;
               padding: 6px 11px;
               border-radius: 20px;
               background: #f3e8fc;
               color: #77269b;
               font-size: 12px;
               font-weight: 700;
               line-height: 1.5;
               overflow-wrap: anywhere;
           }

           .options {
               display: flex;
               align-items: flex-start;
               gap: 11px;
               width: 100%;
               margin: 10px 0;
               padding: 13px 14px;
               border: 1px solid #e7deef;
               border-radius: 11px;
               background: #fff;
               color: #44344f;
               font-size: 15px;
               line-height: 1.6;
               cursor: pointer;
               overflow-wrap: anywhere;
               transition: background-color 0.2s, border-color 0.2s;
           }

           .options:hover {
               background: #faf5ff;
               border-color: #c9a8e0;
           }

           input[type="radio"] {
               flex: 0 0 auto;
               width: 18px;
               height: 18px;
               margin: 2px 0 0;
               accent-color: #8415a3;
               cursor: pointer;
           }           

           .options:has(input[type="radio"]:checked) {
               background: #f5eaff;
               border-color: #923bb7;
           }

           .actions {
               display: flex;
               justify-content: center;
               gap: 14px;
               margin: 24px 0 8px;
           }

           input[type="submit"],
           input[type="reset"] {
               min-width: 150px;
               min-height: 48px;
               padding: 13px 22px;
               border: none;
               border-radius: 10px;
               font-family: inherit;
               font-size: 14px;
               font-weight: 700;
               cursor: pointer;
               transition: background-color 0.2s, transform 0.2s;
           }

           input[type="submit"] {
               background: linear-gradient(135deg, #7916a3, #9418a0);
               color: white;
               box-shadow: 0 5px 12px rgba(121, 22, 163, 0.18);
           }

           input[type="submit"]:hover {
               background: #681078;
           }

           input[type="reset"] {
               background: #eee5f5;
               color: #681078;
           }

           input[type="reset"]:hover {
               background: #dfd0ed;
           }

           @media (hover: hover) {
               .options:hover {
                   transform: translateY(-1px);
               }
           }

           @media (max-width: 700px) {
               body {
                   padding: 20px 12px;
               }

               .quiz-heading {
                   padding: 23px 20px;
                   border-radius: 16px;
               }

               .quiz-heading p {
                   display: block;
                   margin: 9px 0;
               }

               .block {
                   padding: 20px 17px;
                   border-radius: 14px;
               }

               .block h2 {
                   font-size: 17px;
               }

               .options {
                   padding: 13px 11px;
                   font-size: 14px;
               }
           }

           @media (max-width: 480px) {
               body {
                   padding: 12px 8px;
               }

               .quiz-heading {
                   padding: 21px 15px;
                   margin-bottom: 14px;
               }

               .quiz-heading h1 {
                   font-size: 25px;
                   margin-bottom: 17px;
               }

               .quiz-heading p {
                   font-size: 12px;
               }

               .block {
                   padding: 17px 12px;
                   margin-bottom: 13px;
               }

               .block h2 {
                   font-size: 16px;
                   line-height: 1.6;
               }

               .options {
                   gap: 9px;
                   margin: 9px 0;
                   padding: 12px 10px;
               }

               .actions {
                   flex-direction: column;
                   gap: 10px;
                   margin-top: 20px;
               }

               input[type="submit"],
               input[type="reset"] {
                   width: 100%;
                   min-height: 48px;
               }
           }

           @media (max-width: 340px) {
               .quiz-heading h1 {
                   font-size: 22px;
               }
           
               .block {
                   padding: 14px 10px;
               }
           
               .options {
                   font-size: 13px;
               }
           }

           @media (prefers-reduced-motion: reduce) {
               *,
               *::before,
               *::after {
                   transition: none !important;
                   animation: none !important;
                   scroll-behavior: auto !important;
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
                dbHost = "gateway01.ap-southeast-1.prod.aws.tidbcloud.com";
            }
            if (dbPort == null || dbPort.isBlank()) {
                dbPort = "4000";
            }
            if (dbName == null || dbName.isBlank()) {
                dbName = "quizz";
            }
            String url = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
           + "?sslMode=VERIFY_IDENTITY";

            if (dbusername == null || dbusername.isBlank()) {
                dbusername = "49syBFwdW3xXqRg.root";
            }
            if (password == null || password.isBlank()) {
                    out.println("MYSQLPASSWORD environment variable is not configured.");
                    return;
            }
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch(ClassNotFoundException e) {
                out.println(e.getMessage());
            }

            try {
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
           } catch(SQLException e) {
            application.log("Error loading quiz questions from database.", e);
            out.println("<p>Unable to load quiz questions. Please try again later.</p>");
        }
            %>
        </div>
    </body>
</html>


