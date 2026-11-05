
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /app

# Copy Maven wrapper and pom.xml first (layer caching for deps)
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./

# Download dependencies (cached layer if pom.xml unchanged)
RUN ./mvnw dependency:go-offline -B

# Copy source and build the fat JAR, skipping tests
COPY src/ src/
RUN ./mvnw package -DskipTests -B

# Build Stage
FROM eclipse-temurin:21-jre-alpine AS runtime

WORKDIR /app

# Copy only the executable JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]