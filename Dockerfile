FROM gradle:7-jdk11 AS build

RUN echo "Copiando arquivos"
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

RUN echo "Gerando ServerJar"
RUN gradle buildFatJar --no-daemon

RUN echo "Gerando WebApp"
RUN gradle wasmJsBrowserDistribution --no-daemon

FROM openjdk:11
EXPOSE 8080:8080

RUN echo "Criando dir do projeto no container"
RUN mkdir /app

RUN echo "Copiando ServerJar pro container"
COPY --from=build /home/gradle/src/server/build/libs/*.jar /app/smartcity.jar

RUN echo "Copiando WebApp pro container"
COPY --from=build /home/gradle/src/composeApp/build/dist/wasmJs/productionExecutable /app/wasm

ENTRYPOINT ["java","-jar","/app/smartcity.jar"]