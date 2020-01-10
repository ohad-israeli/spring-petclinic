# Pull base image.
FROM openjdk:8-jre-alpine
# copy application WAR (with libraries inside)
COPY target/*.jar /petclinic.jar
# specify default command
CMD ["/usr/bin/java", "-jar", "/petclinic.jar"]