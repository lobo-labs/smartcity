# Usa o Gradle com OpenJDK para compilar o Kotlin/JS
FROM gradle:jdk17 AS build
WORKDIR /app
COPY . .
RUN ./gradlew jsBrowserProductionWebpack

# Usa o Nginx para servir os arquivos Web gerados
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /app/build/distributions/ .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
