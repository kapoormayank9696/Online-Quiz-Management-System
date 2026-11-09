# Online Quiz Management System

A web-based **Online Quiz Management System** developed using JavaServer Pages (JSP), Java, Apache Tomcat, and MySQL. This application allows students to log in using their personal details, attempt multiple-choice questions, and view their quiz results with automatically calculated scores and percentages.

The system provides a simple and user-friendly platform for conducting online quizzes and managing student performance records.

## 🚀 Live Demo

**Live Application:**  
https://online-quiz-management-system-1-70cn.onrender.com/LoginPage.jsp

## ✨ Features

- **Student Login:** Students can enter their name, email, and enrollment number.
- **Multiple-Choice Questions:** Interactive quiz containing MCQ-based questions.
- **Database Integration:** Questions and answer options are retrieved from MySQL.
- **Automatic Evaluation:** Automatically calculates scores based on submitted answers.
- **Result Generation:** Displays obtained marks and percentage.
- **Result Storage:** Saves student details and quiz results in the database.
- **User-Friendly Interface:** Simple interface with custom CSS styling.
- **Docker Support:** Supports containerized deployment using Docker.
- **Persistent Records:** Stores quiz results for future reference.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend programming |
| JSP | Dynamic web pages |
| HTML5 | Frontend structure |
| CSS3 | UI styling |
| JDBC | Database connectivity |
| MySQL | Database management |
| Apache Tomcat 9 | Web server |
| MySQL Connector/J | MySQL JDBC driver |
| Docker | Containerization |
| Git & GitHub | Version control and source code management |

## 📂 Project Structure

```text
Online-Quizz-Management-System/
│
├── LoginPage.jsp
├── Qizz.jsp
├── Result.jsp
├── MysqlCommand.txt
├── Dockerfile
├── README.md
│
├── Project Images/
│
└── WEB-INF/
    └── lib/
        └── mysql-connector-j.jar
```

## ⚙️ Prerequisites

Make sure the following software is installed:

- Java Development Kit (JDK)
- Apache Tomcat 9
- MySQL Server 8.0 or later
- MySQL Connector/J
- Docker Desktop (optional)
- MySQL Workbench (recommended)

## 🗄️ Database Configuration

The project uses MySQL as its database.

**Step 1: Start MySQL Server**

Start your MySQL service and open MySQL Workbench or the MySQL command-line client.

**Step 2: Create the Database**

Execute the SQL commands available in `MysqlCommand.txt`.

**Step 3: Database Tables**

The application uses the following tables:

| Table Name | Description |
|---|---|
| `questions` | Stores quiz questions and related information. |
| `options` | Stores multiple-choice options and correct-answer indicators. |
| `quiz_results` | Stores student details, scores, and quiz results. |

**Step 4: Configure Database Connectivity**

Update the database connection details in the JSP files according to your MySQL configuration.

Example:

```java
String url = "jdbc:mysql://localhost:3306/quizz";
String username = "root";
String password = "your_password";
```

Make sure the MySQL Connector/J JAR file is available to the application.

**Note:** Never upload actual database passwords or sensitive credentials to GitHub.

## ▶️ Run the Project Locally

Follow these steps to run the application on your local machine.

1. Install JDK, Apache Tomcat 9, and MySQL.
2. Start the MySQL server.
3. Execute `MysqlCommand.txt` to create the database and required tables.
4. Configure database credentials in the JSP files.
5. Copy the project files into the Tomcat webapps directory.
6. Ensure the MySQL Connector/J driver is available.
7. Start the Apache Tomcat server.
8. Open your browser and visit:

```text
http://localhost:8080/Online-Quizz-Management-System/LoginPage.jsp
```

If the project is deployed as the Tomcat ROOT application, use:

```text
http://localhost:8080/LoginPage.jsp
```

## 🐳 Docker Deployment

The project supports Docker-based deployment using Apache Tomcat.

**Step 1: Install Docker Desktop**

Make sure Docker Desktop is installed and running.

**Step 2: Build the Docker Image**

Open PowerShell or Command Prompt in the directory containing the Dockerfile.

```bash
docker build -t online-quiz .
```

**Step 3: Run the Docker Container**

```bash
docker run -d --name online-quiz -p 8081:8080 online-quiz
```

**Step 4: Access the Application**

```text
http://localhost:8081/LoginPage.jsp
```

**Important Docker Configuration:**

- The MySQL database must be accessible separately from the Tomcat container.
- When connecting to MySQL installed on the Windows host, `host.docker.internal` can be used as the database hostname.
- Configure the correct database name, port, username, and password.
- Ensure the database connection URL matches the deployment environment.

## 📸 Application Screenshots

Add your project screenshots inside the `Project Images` folder and display them here.

Example:

```markdown
### Login Page
![Login Page](Project%20Images/LoginPage.png)

### Quiz Page
![Quiz Page](Project%20Images/QuizPage.png)

### Result Page
![Result Page](Project%20Images/ResultPage.png)
```

## 🔮 Future Enhancements

- Admin dashboard for managing quiz questions.
- Secure student authentication and password management.
- Randomized questions and answer options.
- Countdown timer with automatic quiz submission.
- Multiple quiz categories and difficulty levels.
- Leaderboard and student performance analytics.
- Improved mobile responsiveness.
- Environment-based database configuration.
- Enhanced security and input validation.

## 🎯 Project Purpose

The main purpose of this project is to simplify the process of conducting online examinations and evaluating student performance.

It demonstrates the practical implementation of Java, JSP, JDBC, MySQL, and Docker in developing a database-driven web application.

## 👨‍💻 Author

**Mayank Kapoor**

- Project: Online Quiz Management System
- Technologies: Java, JSP, JDBC, MySQL, Apache Tomcat, Docker
- GitHub: (https://github.com/kapoormayank9696/Online-Quiz-Management-System)
- Live Demo: https://online-quiz-management-system-1-70cn.onrender.com/LoginPage.jsp

## 📄 License

This project is developed for educational and learning purposes. You may add an appropriate open-source license if you intend to distribute or reuse the project publicly.