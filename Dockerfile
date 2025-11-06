# Build stage
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

# Instala Maven manualmente
RUN apt-get update && apt-get install -y maven

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage final
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
