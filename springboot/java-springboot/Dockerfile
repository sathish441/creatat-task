# Package stage
FROM openjdk:8-jdk-alpine
COPY $WORKSPACE/springboot/java-springboot/target/*.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]

