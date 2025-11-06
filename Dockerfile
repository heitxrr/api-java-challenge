# =============================
# Dockerfile para aplicação Java 21 com Maven
# =============================

# Stage 1: Build da aplicação usando Maven + JDK 21
FROM maven:3.9.2-eclipse-temurin-21 AS build

WORKDIR /app

# Copia apenas o pom.xml primeiro para aproveitar cache
COPY pom.xml .

# Copia o código fonte
COPY src ./src

# Executa o build da aplicação (gera o JAR)
RUN mvn clean package -DskipTests

# Stage 2: Imagem mínima para rodar a aplicação
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copia o JAR gerado no stage de build
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta da aplicação
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
