FROM openjdk:17-jdk-slim

WORKDIR /app

# Copie os arquivos de build do servidor
COPY ./server/build/libs/*.jar /app/server.jar

# Exponha a porta que seu servidor utiliza
EXPOSE 8080

# Comando para iniciar o servidor
CMD ["java", "-jar", "/app/server.jar"]
