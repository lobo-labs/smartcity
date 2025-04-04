FROM openjdk:17-jdk-slim as build

WORKDIR /build

# Copie todo o código fonte
COPY . .

# Execute o build (ajuste o comando conforme seu projeto)
RUN ./gradlew :server:build

# Segunda etapa para a imagem final
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copie apenas o JAR construído na etapa anterior
COPY --from=build /build/server/build/libs/*.jar /app/server.jar

EXPOSE 8080

CMD ["java", "-jar", "/app/server.jar"]
