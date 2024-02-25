# Use the official Maven image as the build environment
FROM maven:3.6.3-jdk-11 as builder
WORKDIR /app

COPY . .

# Build the application
RUN mvn clean package

# Use the official OpenJDK image for a lean production stage
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
