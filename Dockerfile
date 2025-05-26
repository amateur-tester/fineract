# Stage 1: Build
FROM maven:3.8.6-openjdk-21 AS build
WORKDIR /app
COPY . .
RUN ./gradlew build -x test

# Stage 2: Run
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/build/libs/fineract-provider.jar .
EXPOSE 8443
ENTRYPOINT ["java", "-jar", "fineract-provider.jar"]
