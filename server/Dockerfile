# FROM gradle:7-jdk11 AS build

# RUN echo "---> Copiando arquivos"
# COPY --chown=gradle:gradle . /home/gradle/src
# WORKDIR /home/gradle/src

# RUN echo "---> Gerando ServerJar"
# RUN gradle buildFatJar --no-daemon

# RUN echo "---> Gerando WebApp"
# RUN gradle :composeApp:wasmJsBrowserDistribution --no-daemon

# FROM openjdk:11
# EXPOSE 8080:8080

# RUN echo "---> Criando dir do projeto no container"
# RUN mkdir /app

# RUN echo "---> Copiando ServerJar pro container"
# COPY --from=build /home/gradle/src/server/build/libs/*.jar /app/smartcity.jar

# RUN echo "---> Copiando WebApp pro container"
# COPY --from=build /home/gradle/src/composeApp/build/dist/wasmJs/productionExecutable /app/wasm

# RUN echo "---> Definindo ponto de entrada do Server"
# ENTRYPOINT ["java","-jar","/app/smartcity.jar"]

# --- Estágio de Build ---
# Use uma imagem base do Gradle com JDK compatível
FROM gradle:8.5-jdk17 AS builder

# Copie todo o código-fonte para o container
WORKDIR /app
COPY . .

# Execute o build do Gradle para criar o Fat JAR
# Certifique-se que :seuModuloServidor está correto
RUN gradle :server:shadowJar --no-daemon

# --- Estágio de Execução ---
# Use uma imagem base JRE menor para execução
FROM openjdk:17-jre 

WORKDIR /app

# Copie apenas o Fat JAR do estágio de build
COPY --from=builder /app/server/build/libs/*.jar ./app.jar

# Exponha a porta que o Render fornecerá via variável de ambiente PORT
# O comando CMD usará essa variável
# A porta interna, o Render mapeará externamente
EXPOSE 8080

# Comando para iniciar a aplicação
# O Ktor/Spring Boot precisa ouvir em 0.0.0.0 na porta fornecida por $PORT
# A configuração feita anteriormente para ler System.getenv("PORT") cuidará disso.
CMD ["java", "-jar", "app.jar"]
