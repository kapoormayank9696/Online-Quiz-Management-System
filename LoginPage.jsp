<!--The Qizz Login Page-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
    <head>

        <title>
            Login Page 
        </title>
        
        <style>
            * {
                box-sizing: border-box;
            }

            body{
                margin: 0;
                min-height: 100vh;
                padding: 30px 15px;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: Arial, Helvetica, sans-serif;
                background: linear-gradient(135deg, #eee7ff, #f8edff, #e4e9ff);
                color: #29213b;
            }
            
            .form-container {
                width: 100%;
                max-width: 500px;
                padding: 25px 20px;
                background: white;
                border-radius: 16px;
                box-shadow: 0 8px 25px rgba(72, 39, 105, 0.15);
            }

                        
            h1 {
                margin: 0 0 10px;
                color: darkmagenta;
                text-align: center;
                font-size: 28px;
            }

            .subtitle {
                margin: 0 0 30px;
                color: #766b83;
                text-align: center;
                font-size: 14px;
                line-height: 1.5;
            }

            .block{
                width: 100%;
                padding: 5px 10px;
                margin-top: 0 0 16px;
                background: transparent;
            }

            .block {
                margin-bottom: 18px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                color: #4b245f;
                font-size: 14px;
                font-weight: bold;
            }

            input[type="submit"]{
                background-color: darkmagenta;
                padding:8px 16px;
                cursor: pointer;
                color:white;
            }

            input[type="text"],
            input[type="email"] {
                display: block;
                width: 100%;
                padding: 12px 14px;
                border: 1px solid #d8cce8;
                border-radius: 8px;
                background: #ffffff;
                font-size: 15px;
                outline: none;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            input[type="text"]:focus,
            input[type="email"]:focus {
                border-color: darkmagenta;
                box-shadow: 0 0 5px rgba(139, 0, 139, 0.25);
            }

            .button-group {
                display: flex;
                gap: 12px;
                margin-top: 15px;
            }

            input[type="submit"],
            input[type="reset"] {
                flex: 1;
                padding: 12px 18px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
            }

            input[type="submit"] {
                background: #8b008b;
                color: white;
            }

            input[type="submit"]:hover {
                background: #681078;
                transform: translateY(-1px);
            }

            input[type="reset"] {
                background: #eee5f5;
                color: #681078;
            }

            input[type="reset"]:hover {
                background-color: #dfd0ed;
            }

            .footer {
                margin: 22px 0 0;
                color: #8a8093;
                text-align: center;
                font-size: 12px;
                line-height: 1.6;
            }

            @media (max-width: 480px) {
            .form-container {
                padding: 25px 20px;
            }

            h1 {
                font-size: 24px;
            }
        }

        </style>
    </head>
    <body>

            <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String enterUsername = request.getParameter("Username");
                String enterEmail = request.getParameter("Email");
                String enterEnrollmentno = request.getParameter("Enrollnumber");
                
                if (enterUsername != null && enterEmail != null
                && enterEnrollmentno != null
                && !enterUsername.trim().isEmpty()
                && !enterEmail.trim().isEmpty()
                && !enterEnrollmentno.trim().isEmpty()) {

                    HttpSession mySession = request.getSession(true);

                    mySession.setAttribute("userName", enterUsername.trim());
                    mySession.setAttribute("email", enterEmail.trim());
                    mySession.setAttribute("Enrollno", enterEnrollmentno.trim());

                    response.sendRedirect("Qizz.jsp");
                    return;
                }
            }
            %>

            <main class="form-container">
            
                <h1>Student Login</h1>
            
                <p class="subtitle">
                    Enter your details to start the quiz.
                </p>
                
                <form action="LoginPage.jsp" method="POST">
                    <div class="block">
                        <label for="Username">NAME OF STUDENT*</label>
                        <input type="text" id="Username" name="Username" placeholder="Enter your full name" maxlength="100" autocomplete="name"
                            required>
                    </div>

                    <div class="block">
                        <label for="Email">EMAIL*</label>
                        <input type="email" id="Email" name="Email" placeholder="Enter your email" maxlength="254" autocomplete="email"
                                required>
                    </div>

                    <div class="block">
                        <label for="Enrollnumber">ENROLLMENT NO*</label>
                        <input type="text" id="Enrollnumber" name="Enrollnumber" placeholder="Enter your enrollment number" maxlength="50"
                            required>
                    </div>
                        
                    <div class="button-group">
                        <input type="submit" value="Next">
                        <input type="reset" value="Clear Form">
                    </div>
                </form>
                <p class="footer">
                    Please check your details before continuing.
                </p>
        </main>
    </body>
</html>

