#### Stage 1: Build the application
FROM eclipse-temurin:17-jdk-slim AS build

WORKDIR /app

# Copy Maven wrapper
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies (cached)
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src src

# Build app
RUN ./mvnw package -DskipTests

# Extract dependencies for minimal image
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

#### Stage 2: Minimal runtime image
FROM eclipse-temurin:17-jre-slim

ARG DEPENDENCY=/app/target/dependency

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

ENTRYPOINT ["java","-cp","app:app/lib/*","com.example.polls.PollsApplication"]
