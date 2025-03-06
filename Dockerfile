FROM gradle:7-jdk11 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle buildFatJar --no-daemon --debug
RUN gradle wasmJsBrowserDistribution --no-daemon --debug

FROM openjdk:11
EXPOSE 8080:8080
RUN mkdir /app
COPY --from=build /home/gradle/src/server/build/libs/*.jar /app/smartcity.jar
COPY --from=build /home/gradle/src/composeApp/build/dist/wasmJs/productionExecutable /app/wasm
ENTRYPOINT ["java","-jar","/app/smartcity.jar"]