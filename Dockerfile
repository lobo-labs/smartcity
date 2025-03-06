FROM gradle:7-jdk11 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle buildFatJar --no-daemon
RUN gradle wasmJsBrowserDistribution --no-daemon

FROM openjdk:11
EXPOSE 8080:8080
RUN mkdir /app
COPY --from=build /home/gradle/server/build/libs/*.jar /app/kmp-server.jar
COPY --from=build /home/gradle/composeApp/build/dist/wasmJs/productionExecutable /app/wasm
ENTRYPOINT ["java","-jar","/app/kmp-server.jar"]