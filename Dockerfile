# Stage 1: Build the application
FROM maven:3.6.3-openjdk-17 as build
COPY src /usr/home/github-actions-demo/src
COPY ./pom.xml /usr/home/github-actions-demo
RUN mvn -f /usr/home/github-actions-demo/pom.xml clean package -DskipTests

# Stage 2: Package the application
FROM openjdk:17-jdk
COPY --from=build /usr/home/github-actions-demo/target/*.jar /github-actions-demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/github-actions-demo.jar"]