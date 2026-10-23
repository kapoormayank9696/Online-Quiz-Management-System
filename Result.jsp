<!-- Result of Quizz -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, java.util.*" %>
<%! private String escapeHtml(String value) { if (value==null) return "" ; return value.replace("&", "&amp;" )
    .replace("<", "&lt;" ) .replace(">", "&gt;")
    .replace("\"", "&quot;")
    .replace("'", "&#39;");
    }
    %>
    
<!DOCTYPE html>
<html>
    <head>
        <title>Quiz Result</title>
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
            padding: 32px 16px;
            background:
                radial-gradient(ellipse at top left, #e6d9ff 0%, transparent 45%),
                linear-gradient(135deg, #f6f1ff, #fff8ff, #eaf0ff);
            font-family: "Segoe UI", Arial, Helvetica, sans-serif;
            color: #291044;
        }
        
        .container {
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
        }
        
        .block {
            width: 100%;
            max-width: 850px;
            margin: 10px auto;
            padding: 26px;
            background: #fff;
            border: 1px solid #e7dcf6;
            border-radius: 22px;
            text-align: center;
            box-shadow: 0 15px 45px rgba(75, 23, 101, 0.10);
        }
        
        .block h1 {
            color: #65149a;
            margin: 0 0 22px;
            font-size: clamp(25px, 4vw, 32px);
            font-weight: 750;
        }
        
        .block h2 {
            color: #291044;
            font-size: 18px;
        }
        
        .result-header {
            background: linear-gradient(135deg, #3f105b, #65149a, #8036b2);
            color: white;
            padding: 30px 24px;
            border-radius: 18px;
            margin-bottom: 22px;
            box-shadow: 0 9px 25px rgba(75, 23, 101, 0.18);
        }
        
        .result-header h1 {
            color: white;
            margin: 0 0 22px;
            font-size: clamp(27px, 4vw, 34px);
        }
        
        .student-info {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 12px;
            padding-top: 8px;
            text-align: left;
        }
        
        .student-info p {
            min-width: 0;
            margin: 0;
            padding: 15px;
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 11px;
            overflow-wrap: anywhere;
            line-height: 1.6;
            font-size: 14px;
        }
        
        .student-info strong {
            display: block;
            margin-bottom: 5px;
            color: #ead8ff;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .score-summary {
            margin-top: 0;
            padding: 28px 18px;
            background: linear-gradient(145deg, #fff, #faf6ff);
            border: 1px solid #e7dcf6;
            border-radius: 18px;
            text-align: center;
        }
        
        .score-summary h1 {
            margin-bottom: 12px;
        }
        
        .score-circle {
            --percentage: 0%;
            width: 185px;
            height: 185px;
            max-width: 100%;
            margin: 22px auto;
            border-radius: 50%;
            background: conic-gradient(
                #8b2bc1 var(--percentage),
                #e9ddf5 var(--percentage)
            );
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        
        .score-circle::before {
            content: "";
            position: absolute;
            width: calc(100% - 30px);
            height: calc(100% - 30px);
            background: white;
            border-radius: 50%;
        }
        
        .score-circle-content {
            position: relative;
            z-index: 1;
            text-align: center;
        }
        
        .score-circle-content h2 {
            margin: 0;
            font-size: clamp(27px, 5vw, 35px);
            color: #65149a;
            font-weight: 800;
        }
        
        .score-circle-content p {
            margin: 5px 0 0;
            font-size: 12px;
            color: #6b5a78;
        }
        
        .score-summary > p {
            margin: 14px 0 0;
            font-size: 16px;
            color: #594767;
        }
        
        .score-summary > p strong {
            color: #65149a;
        }
        
        .stats {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 14px;
            margin: 22px 0 0;
        }
        
        .stats-card {
            min-width: 0;
            padding: 22px 12px;
            background: #fff;
            border-radius: 15px;
            text-align: center;
            border: 1px solid #e7dcf6;
            box-shadow: 0 5px 16px rgba(75, 23, 101, 0.05);
        }
        
        .stats-card h2 {
            margin: 0 0 8px;
            font-size: 30px;
            font-weight: 800;
        }
        
        .stats-card p {
            margin: 0;
            font-size: 13px;
            line-height: 1.5;
            color: #6b5a78;
        }
        
        .correct-stat {
            color: #168653;
        }
        
        .wrong-stat {
            color: #d1435b;
        }
        
        .unanswered-stat {
            color: #a36a13;
        }
        
        @media (max-width: 700px) {
            body {
                padding: 20px 12px;
            }
        
            .block {
                padding: 18px;
            }
        
            .student-info {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 12px 8px;
            }
        
            .block {
                padding: 12px;
                border-radius: 16px;
            }
        
            .result-header {
                padding: 22px 14px;
                border-radius: 14px;
                margin-bottom: 14px;
            }
        
            .student-info {
                grid-template-columns: minmax(0, 1fr);
                gap: 9px;
            }
        
            .student-info p {
                padding: 12px;
            }
        
            .score-summary {
                padding: 23px 10px;
            }
        
            .score-circle {
                width: 155px;
                height: 155px;
            }
        
            .stats {
                grid-template-columns: minmax(0, 1fr);
                gap: 10px;
                margin-top: 14px;
            }
        
            .stats-card {
                padding: 17px 12px;
            }
        }
        
        @media (max-width: 340px) {
            .block {
                padding: 9px;
            }
        
            .result-header h1 {
                font-size: 24px;
            }
        
            .score-circle {
                width: 140px;
                height: 140px;
            }
        }
        
        </style>
    </head>
    <body>

        <!-- Check User All Information Is Fill -->
        <%
        String userName = (String) session.getAttribute("userName");
        String email = (String) session.getAttribute("email");
        String enrollno = (String) session.getAttribute("Enrollno");
        %>
        
        <!-- Checks Session Valid Or Not -->
        <%
        if(userName == null || email == null || enrollno == null){
            out.println("<h2>Session expired! Please login again.</h2>");
            return;
        }
        %>

        <!-- DataBase Information To Use It -->
        <%
        String dbHost = System.getenv("MYSQLHOST");
        String dbPort = System.getenv("MYSQLPORT");
        String dbName = System.getenv("MYSQLDATABASE");
        String dbuser = System.getenv("MYSQLUSER");
        String dbpass = System.getenv("MYSQLPASSWORD");

        if (dbHost == null || dbHost.isBlank()) {
            dbHost = "gateway01.ap-southeast-1.prod.aws.tidbcloud.com";
        }

        if (dbPort == null || dbPort.isBlank()) {
            dbPort = "4000";
        }

        if (dbName == null || dbName.isBlank()) {
            dbName = "quizz";
        }

        if (dbuser == null || dbuser.isBlank()) {
            dbuser = "49syBFwdW3xXqRg.root";
        }

        if (dbpass == null || dbpass.isBlank()) {
            out.println("<div class='block'><h2>Database configuration error: MYSQLPASSWORD is missing.</h2></div>");
            return;
        }

        String url = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
                   + "?sslMode=VERIFY_IDENTITY";

        int score = 0;
        int totalQuestions = 0;
        int correctCount = 0;
        int wrongCount = 0;
        int unansweredCount = 0;
        %>
        
        <!-- Function to Load the JDBC Driver -->
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            application.log("MySQL JDBC driver not found", e);
            out.println("<div class='block'>");
            out.println("<h2>MySQL JDBC driver not found.</h2>");
            out.println("</div>");
            return;
        }
        %>

        <!-- Connect to MySQL Database -->
        <%
        try (Connection conn = DriverManager.getConnection(url, dbuser, dbpass)) {
            %>
            
            <!-- Check whether the user has already submitted the quiz -->
            <%
            try (PreparedStatement check = conn.prepareStatement(
                    "SELECT score, total FROM quiz_results WHERE enrollno = ?")) {

                check.setString(1, enrollno);

                try (ResultSet rsCheck = check.executeQuery()) {
                    if (rsCheck.next()) {
                %>
                        <div class="block">
                            <h2>You have already submitted the quiz.</h2>
                            <p>
                                Your score:
                                <%= rsCheck.getInt("score") %> /
                                <%= rsCheck.getInt("total") %>
                            </p>
                        </div>
        <%
                        return;
                    }
                }
            }
            %>

            <!-- Process all quiz questions -->
            <%             
            try (Statement stmt = conn.createStatement();
                 ResultSet rsQ = stmt.executeQuery("SELECT * FROM questions")) {

                while (rsQ.next()) {

                    int qid = rsQ.getInt("id");
                    totalQuestions++;
                    %>

                    <!-- Read the user's selected option -->
                    <%
                    String userAnswer = request.getParameter("answer_" + qid);
                    int userOptionId = -1;

                    if (userAnswer != null && userAnswer.matches("\\d+")) {
                        try {
                            userOptionId = Integer.parseInt(userAnswer);
                        } catch (NumberFormatException e) {
                            userOptionId = -1;
                        }
                    }

                    String userText = "";
                    int correctId = -1;
                    %>

                    <!-- Find the correct option and the selected option text -->
                    <%
                    try (PreparedStatement pst = conn.prepareStatement(
                            "SELECT id, option_text, correct_answer FROM options WHERE question_id = ?")) {

                        pst.setInt(1, qid);

                        try (ResultSet rsOpt = pst.executeQuery()) {
                            while (rsOpt.next()) {

                                int optId = rsOpt.getInt("id");
                                String optText = rsOpt.getString("option_text");
                                int isCorrect = rsOpt.getInt("correct_answer");

                                if (isCorrect == 1) {
                                    correctId = optId;
                                }

                                if (optId == userOptionId) {
                                    userText = optText;
                                }
                            }
                        }
                    }
                    %>

                    <!-- Calculate score and statistics once per question -->
                    <%
                    if (userOptionId == -1 || userText.isEmpty()) {
                        unansweredCount++;
                    } else if (userOptionId == correctId && correctId != -1) {
                        score++;
                        correctCount++;
                    } else {
                        wrongCount++;
                    }
                }
            }
            %>

            <!-- Save the final result only once, after processing every question -->
            <%
            try (PreparedStatement save = conn.prepareStatement(
                    "INSERT INTO quiz_results(username, email, enrollno, score, total) VALUES(?, ?, ?, ?, ?)")) {

                save.setString(1, userName);
                save.setString(2, email);
                save.setString(3, enrollno);
                save.setInt(4, score);
                save.setInt(5, totalQuestions);

                save.executeUpdate();
            }
            %>
            
            <!-- Calculate percentage after all questions have been processed -->
            <%
            double percentage = totalQuestions > 0
                    ? score * 100.0 / totalQuestions
                    : 0.0;
            percentage = Math.max(0.0, Math.min(100.0, percentage));
            %>

            <!-- Final Result Section -->
            <div class="block">
            
                <!-- TOP: Quiz Result and Student Information -->
                <div class="result-header">
                    <h1>Quiz Result</h1>
            
                    <div class="student-info">
                        <p>
                            <strong>Name:</strong>
                            <%= escapeHtml(userName) %>
                        </p>
            
                        <p>
                            <strong>Email:</strong>
                            <%= escapeHtml(email) %>
                        </p>
            
                        <p>
                            <strong>Roll Number:</strong>
                            <%= escapeHtml(enrollno) %>
                        </p>
                    </div>
                </div>
            
                <!-- BOTTOM: Final Score -->
                <div class="score-summary">
                    <h1>Your Final Score</h1>
            
                    <div class="score-circle" style="--percentage: <%= percentage %>%">
                    
                        <div class="score-circle-content">
                            <h2>
                                <%= String.format(Locale.US, "%.1f" , percentage) %>%
                            </h2>
                            <p>Correct Answers</p>
                        </div>
                    
                    </div>
                    <p>
                        Score:
                        <strong>
                            <%= score %> / <%= totalQuestions %>
                        </strong>
                    </p>
                </div>
            
                <!-- Answer Statistics -->
                <div class="stats">
            
                    <div class="stats-card">
                        <h2 class="correct-stat">
                            <%= correctCount %>
                        </h2>
                        <p>Correct Answers</p>
                    </div>
            
                    <div class="stats-card">
                        <h2 class="wrong-stat">
                            <%= wrongCount %>
                        </h2>
                        <p>Wrong Answers</p>
                    </div>
            
                    <div class="stats-card">
                        <h2 class="unanswered-stat">
                            <%= unansweredCount %>
                        </h2>
                        <p>Unanswered Questions</p>
                    </div>
            
                </div>
            
            </div>

        <%
        } catch (Exception e) {
            application.log("Error while generating quiz result", e);
        %>

            <div class="block">
                <h2>Unable to generate quiz result.</h2>
                <p>Please check the database connection and server logs.</p>
            </div>

        <%
        }
        %>

    </body>
</html>

