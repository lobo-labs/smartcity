FROM gradle:7-jdk11 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

RUN chmod +x ./gradlew

RUN gradle buildFatJar --no-daemon
RUN ./gradlew wasmJsBrowserDistribution --no-daemon

FROM openjdk:11
EXPOSE 8080:8080
RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/smartcity.jar
COPY --from=build /home/gradle/src/build/dist/wasm /app/wasm
ENTRYPOINT ["java","-jar","/app/smartcity.jar"]