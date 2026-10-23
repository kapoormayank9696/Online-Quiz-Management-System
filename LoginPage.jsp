<!--The Qizz Login Page-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
    <head>

    <title>Student Login | Online Quiz</title>
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
            min-height: 100dvh;
            padding: 28px 16px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: "Segoe UI", Arial, Helvetica, sans-serif;
            background:
            radial-gradient(ellipse at top left, #e5d7ff 0%, transparent 45%),
            linear-gradient(135deg, #f5f0ff, #fff8ff, #e9edff);
            color: #29213b;
        }

        .form-container {
            width: 100%;
            max-width: 460px;
            padding: 36px 32px;
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid #e9def8;
            border-radius: 22px;
            box-shadow: 0 18px 55px rgba(72, 39, 105, 0.13);
        }

        h1 {
            margin: 0 0 10px;
            color: #65149a;
            text-align: center;
            font-size: clamp(26px, 4vw, 32px);
            font-weight: 750;
            letter-spacing: -0.5px;
        }

        .subtitle {
            margin: 0 0 28px;
            color: #766b83;
            text-align: center;
            font-size: 14px;
            line-height: 1.7;
        }

        .block {
            width: 100%;
            padding: 0;
            margin: 0 0 20px;
            background: transparent;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #4b245f;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.65px;
        }

        input[type="text"],
        input[type="email"] {
            display: block;
            width: 100%;
            min-width: 0;
            min-height: 48px;
            padding: 13px 14px;
            border: 1px solid #d9cce9;
            border-radius: 10px;
            background: #fff;
            color: #29213b;
            font-family: inherit;
            font-size: 15px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input[type="text"]::placeholder,
        input[type="email"]::placeholder {
            color: #a39aaf;
        }

        input[type="text"]:focus,
        input[type="email"]:focus {
            border-color: #8b35b5;
            box-shadow: 0 0 0 4px rgba(139, 53, 181, 0.11);
        }

        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        input[type="submit"],
        input[type="reset"] {
            flex: 1;
            min-width: 0;
            min-height: 47px;
            padding: 12px 14px;
            border: none;
            border-radius: 10px;
            font-family: inherit;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.2s;
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #7916a3, #9518a0);
            color: white;
            box-shadow: 0 5px 12px rgba(121, 22, 163, 0.18);
        }

        input[type="submit"]:hover {
            background: #681078;
        }
        
        input[type="submit"]:hover,
        input[type="reset"]:hover {
            transform: translateY(-1px);
        }

        input[type="submit"]:focus-visible,
        input[type="reset"]:focus-visible {
            outline: 3px solid #c9a4e8;
            outline-offset: 3px;
        }

        input[type="reset"] {
            background: #f0e7f8;
            color: #681078;
        }

        input[type="reset"]:hover {
            background: #e3d3f0;
        }

        .footer {
            margin: 24px 0 0;
            color: #8a8093;
            text-align: center;
            font-size: 12px;
            line-height: 1.7;
        }

        @media (max-width: 480px) {
            body {
                padding: 18px 12px;
                align-items: center;
            }

            .form-container {
                max-width: 100%;
                padding: 28px 20px;
                border-radius: 18px;
            }

            h1 {
                font-size: 26px;
            }

            .subtitle {
                margin-bottom: 24px;
            }

            .block {
                margin-bottom: 18px;
            }

            .button-group {
                gap: 9px;
            }

            input[type="submit"],
            input[type="reset"] {
                padding: 12px 8px;
                font-size: 13px;
            }
        }

        @media (max-width: 340px) {
            .form-container {
                padding: 24px 14px;
            }

            .button-group {
                flex-direction: column;
            }

            input[type="submit"],
            input[type="reset"] {
                width: 100%;
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
                            autocomplete="off" required>
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

