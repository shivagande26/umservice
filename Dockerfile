# stage-1
FROM amazoncorretto:11-alpine-jdk AS builder
WORKDIR /app/source
COPY . .
RUN ./mvnw clean package

# stage-2
FROM amazoncorretto:11-alpine-jdk
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]