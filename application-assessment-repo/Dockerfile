# Stage 1: Build the application
FROM maven:3.6.3-jdk-11 as builder
WORKDIR /app

# Copy the project files to the image
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Deploy the WAR to Tomcat
FROM tomcat:9.0-jdk11-openjdk

# Remove default web applications from Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the builder stage to the Tomcat webapps directory
# Ensure the WAR file name matches the output from the Maven build
COPY --from=builder /app/target/spring-petclinic-*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the port Tomcat listens on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
