# Stage 1: Build
FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /laptopshop

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Run
FROM openjdk:17-slim

WORKDIR /Java/laptopshop/

COPY --from=build /laptopshop/target/*.war app.war

EXPOSE 9999

ENTRYPOINT ["java", "-jar", "app.war"]
