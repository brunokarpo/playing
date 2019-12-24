FROM openjdk:8-alpine as builder
WORKDIR /home/maven/src
COPY . .
RUN ./mvnw clean install

FROM openjdk:8-jre-alpine
WORKDIR /app
EXPOSE 8080 8081

ENV SERVER_PORT="8080"
ENV SERVER_CONTEXT="/playing"
ENV MANAGEMENT_SERVER_PORT="8081"
ENV MANAGEMENT_SERVER_CONTEXT="/"
ENV MANAGEMENT_ENDPOINT_WEB_PATH="/"
ENV MANAGEMENT_ENDPOINT_EXPOSURE="health,info,metrics"

COPY --from=builder /home/maven/src/app/target/app-*.jar playing.jar
ENTRYPOINT java -Dserver.port=${SERVER_PORT} \
    -Dserver.servlet.context-path=${SERVER_CONTEXT} \
    -Dmanagement.server.port=${MANAGEMENT_SERVER_PORT} \
    -Dmanagement.server.context-path=${MANAGEMENT_SERVER_CONTEXT} \
    -Dmanagement.endpoints.web.base-path=${MANAGEMENT_ENDPOINT_WEB_PATH} \
    -Dmanagement.endpoints.web.exposure.include=${MANAGEMENT_ENDPOINT_EXPOSURE} \
    -jar playing.jar