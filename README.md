# Online Quiz Management System

A web-based quiz application developed using **JavaServer Pages (JSP), Apache Tomcat, and MySQL**. The application allows students to enter their details, attempt multiple-choice questions, and view their quiz results.

## Features

- Student login using name, email, and enrollment number
- Multiple-choice quiz questions
- Questions and answer options stored in a MySQL database
- Automatic score calculation
- Quiz result and percentage display
- Storage of quiz results in the database
- User-friendly interface with custom styling
- Docker-based deployment support

## Technologies Used

- **Frontend:** HTML, CSS, JSP
- **Backend:** Java, JSP, JDBC
- **Web Server:** Apache Tomcat 9
- **Database:** MySQL
- **Database Driver:** MySQL Connector/J
- **Containerization:** Docker

## Project Structure

```text
Online-Quizz-Management-System/
├── LoginPage.jsp
├── Qizz.jsp
├── Result.jsp
├── MysqlCommand.txt
├── Dockerfile
├── README.md
├── Project Images/
└── WEB-INF/
    └── lib/
        └── mysql-connector-j.jar
```

## Prerequisites

To run the project locally, install:

- Java Development Kit (JDK)
- Apache Tomcat 9
- MySQL Server
- MySQL Connector/J
- Docker Desktop (for Docker deployment)

## Database Setup

1. Start your MySQL server.
2. Open MySQL Workbench, phpMyAdmin, or the MySQL command-line client.
3. Execute the SQL commands from `MysqlCommand.txt`.
4. Create the `quizz` database and its tables.
5. Insert the sample questions and answer options.

The application uses these tables:

- `questions` — stores quiz questions and categories.
- `options` — stores answer options and correct-answer indicators.
- `quiz_results` — stores student details and quiz scores.

**Note:** Run the SQL setup only on a fresh database, or check existing tables and data first to avoid duplicate records.

## Run Locally

1. Configure Apache Tomcat and MySQL.
2. Place the application files in the appropriate Tomcat web application directory.
3. Ensure MySQL Connector/J is available to the application.
4. Configure the database connection URL, username, and password in the JSP files.
5. Start Tomcat and MySQL.
6. Open the application in your browser:

```text
http://localhost:8080/
```

Use the application's configured context path if it is deployed under a different directory.

## Docker Deployment

Docker can package the application and its Tomcat runtime into a container.

1. Install and start Docker Desktop.
2. Place the `Dockerfile`, JSP pages, `WEB-INF` folder, and required assets in the deployment directory.
3. Build the Docker image:

```powershell
docker build -t online-quiz .
```

4. Run the container:

```powershell
docker run --name online-quiz -p 8080:8080 online-quiz
```

5. Open the application at:

```text
http://localhost:8080/
```

**Important:** The MySQL database must be running and reachable separately. Configure the database host, port, database name, username, and password appropriately for the deployment environment. Do not commit database passwords or other secrets to GitHub.

Docker commands should be run only after the Dockerfile and database configuration are ready.

## Future Enhancements

- Secure authentication and password management
- Admin panel for managing questions and categories
- Randomized questions and answer options
- Quiz timer and automatic submission
- Improved validation and error handling
- Responsive design for mobile devices
- Detailed performance reports and leaderboards
- Secure environment-based database configuration

## Purpose

The purpose of this project is to provide a simple online platform for conducting multiple-choice quizzes, evaluating student answers automatically, and storing quiz results in a database.

## Author

Mayank Kapoor

**Project:** Online Quiz Management System

## License

This project is intended for educational and learning purposes. Add a suitable open-source license if you plan to distribute it publicly.
