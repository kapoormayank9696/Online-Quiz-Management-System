<!-- Result of Quizz -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quiz Result</title>

        <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px 16px;
            background: linear-gradient(135deg, #eee7ff, #f8edff, #e4e9ff);
            font-family: Arial, Helvetica, sans-serif; 
            color: #291044;
        }

        .container {
            max-width: 1100px;
            margin: auto;
        }

        .block {
            max-width: 700px;
            margin: 25px auto;
            padding: 25px;
            background: white;
            border: 1px solid #ded5ff;
            border-radius: 14px;
            text-align: center;
            box-shadow: 0 5px 18px #4b176522;
        }

        .block h1 {
            color: #65149a;
            margin-top: 0;
        }

        .block h2 {
            color: #291044;
            font-size: 18px;
        }

        .result-header {
            background: linear-gradient(20deg, #451064, #65149a);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 5px 18px #4b176522;
        }

        .result-header h1 {
            color: white;
            margin: 0 0 20px;
            font-size: 30px;
        }

        .result-header h2 {
            color: white;
            font-size: 18px;
            margin: 8px 0;
        }

        .student-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            padding-top: 20px;
            text-align: center;
        }
        
        .student-info p {
            margin: 0;
            padding: 12px;
            background: #ffffff20;
            border: 1px solid #ffffff40;
            border-radius: 8px;
            overflow-wrap: anywhere;
        }

        /* Circular Percentage Score */
        .score-circle {
            --percentage: 0%;
            width: 160px;
            height: 160px;
            margin: 20px auto;
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
            width: 125px;
            height: 125px;
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
            font-size: 32px;
            color: #65149a;
        }

        .score-circle-content p {
            margin: 5px 0 0;
            font-size: 13px;
            color: #6b5a78;
        }

        .score-summary {
            margin-top: 20px;
            padding: 25px;
            background: #ffffffb8;
            border: 1px solid #ded5ff;
            border-radius: 14px;
            text-align: center;
        }

        .score-number {
            font-size: 38px;
            font-weight: bold;
            color: #65149a;
            margin: 8px 0;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin: 20px 0;
        }

        .stats-card {
            padding: 18px 10px;
            background: white;
            border-radius: 12px;
            text-align: center;
            border: 1px solid #e4dcff;
        }

        .stats-card h2 {
            margin: 0 0 8px;
            font-size: 27px;
        }

        .stats-card p {
            margin: 0;
            font-size: 14px;
        }


        @media (max-width: 600px) {
            body {
                padding: 15px 10px;
            }

            .student-info {
                grid-template-columns: 1fr;
            }

            .stats {
                grid-template-columns: 1fr;
            }

            .result-header h1 {
                font-size: 24px;
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
        // Database Information
	String dbHost = System.getenv("MYSQLHOST");
	String dbPort = System.getenv("MYSQLPORT");
	String dbName = System.getenv("MYSQLDATABASE");
	String dbuser = System.getenv("MYSQLUSER");
	String dbpass = System.getenv("MYSQLPASSWORD");

	// Local MySQL defaults for Docker on Windows
	if (dbHost == null || dbHost.isBlank()) {
    	dbHost = "host.docker.internal";
	}

	if (dbPort == null || dbPort.isBlank()) {
    	dbPort = "3306";
	}

	if (dbName == null || dbName.isBlank()) {
    	dbName = "quizz";
	}

	if (dbuser == null || dbuser.isBlank()) {
   	 dbuser = "root";
	}

	if (dbpass == null || dbpass.isBlank()) {
    	dbpass = System.getenv("LOCAL_MYSQL_PASSWORD");
	}

	if (dbpass == null) {
    	throw new Exception("Database password is not configured.");
	}

	String url = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName;

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
                            <%= userName %>
                        </p>
            
                        <p>
                            <strong>Email:</strong>
                            <%= email %>
                        </p>
            
                        <p>
                            <strong>Roll Number:</strong>
                            <%= enrollno %>
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

