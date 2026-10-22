FROM tomcat:9.0-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY *.jsp /usr/local/tomcat/webapps/ROOT/
COPY ["Project Images/", "/usr/local/tomcat/webapps/ROOT/Project Images/"]
COPY WEB-INF/ /usr/local/tomcat/webapps/ROOT/WEB-INF/

EXPOSE 8080

CMD ["catalina.sh", "run"]
