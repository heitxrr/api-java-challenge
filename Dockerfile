# =============================
# Dockerfile para aplicação Java com Gradle
# =============================

# Stage 1: Build da aplicação usando Gradle
FROM gradle:8.3-jdk17 AS build

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos do projeto para dentro do container
COPY . .

# Executa o build da aplicação (gera o JAR)
RUN gradle clean build --no-daemon

# Stage 2: Imagem mínima para rodar a aplicação
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copia o JAR gerado no stage de build
COPY --from=build /app/build/libs/*.jar app.jar

# Expõe a porta da aplicação
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
