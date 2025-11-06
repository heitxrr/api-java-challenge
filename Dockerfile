# =============================
# Dockerfile para aplicação Java com Maven
# =============================

# Stage 1: Build da aplicação usando Maven
FROM maven:3.9.2-eclipse-temurin-17 AS build

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos do projeto para dentro do container
COPY pom.xml .
COPY src ./src

# Executa o build da aplicação (gera o JAR)
RUN mvn clean package -DskipTests

# Stage 2: Imagem mínima para rodar a aplicação
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copia o JAR gerado no stage de build
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta da aplicação
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
