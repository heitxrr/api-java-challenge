# =============================
# Dockerfile para aplicação Java 21 com Maven
# =============================

# Stage 1: Build da aplicação usando Java 21 + Maven instalado manualmente
FROM eclipse-temurin:21-jdk AS build

# Diretório de trabalho
WORKDIR /app

# Instala Maven
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# Copia arquivos do projeto
COPY pom.xml .
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
