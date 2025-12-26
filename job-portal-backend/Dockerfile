FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /workspace

COPY . .

RUN mvn -q -pl modules/api -am -DskipTests=true clean package

FROM eclipse-temurin:21-jre
WORKDIR /app

COPY --from=build /workspace/modules/api/target/job-portal-api-0.0.1-SNAPSHOT.jar /app/app.jar

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java","-XX:MaxRAMPercentage=75","-jar","/app/app.jar"]
