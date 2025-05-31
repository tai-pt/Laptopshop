# Stage 1: Build ứng dụng bằng Maven
FROM maven:3.8.4-openjdk-17 AS build

# Copy mã nguồn và các file cấu hình vào trong container build
COPY src /laptopshop/src
COPY pom.xml /laptopshop/


WORKDIR /laptopshop

# Build project và tạo file WAR, bỏ qua test để build nhanh hơn
RUN ./mvnw clean package -DskipTests

# Stage 2: Chạy ứng dụng WAR
FROM openjdk:17-slim

WORKDIR /Java/laptopshop/

# Copy file WAR từ stage build sang
COPY --from=build /laptopshop/target/*.war app.war

EXPOSE 8080

# Chạy ứng dụng WAR bằng java -jar
ENTRYPOINT ["java", "-jar", "app.war"]
