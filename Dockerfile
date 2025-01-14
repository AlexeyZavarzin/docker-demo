FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /app

COPY pom.xml ./pom.xml
COPY src ./src

RUN mvn clean package

FROM openjdk:11-jre-slim AS prod
EXPOSE 8080

COPY --from=build /app/target/spring-petclinic-*.jar /app.jar

CMD ["java","-jar","/app.jar"]