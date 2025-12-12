# Etapa de construcción (Build)
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Etapa de ejecución (Run)
FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.jar app.jar
# Render asigna el puerto automáticamente, pero Spring Boot usa 8080 por defecto
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]