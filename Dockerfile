FROM openjdk:8-alpine as builder
WORKDIR /home/maven/src
COPY . .
RUN ./mvnw clean install

FROM openjdk:8-jre-alpine
WORKDIR /app
EXPOSE 8080
COPY --from=builder /home/maven/src/app/target/app-*.jar playing.jar
ENTRYPOINT java -jar playing.jar