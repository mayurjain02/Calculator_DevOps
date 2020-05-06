FROM openjdk:8
EXPOSE 8086
ADD target/calculator.jar calculator.jar
ENTRYPOINT ["java", "-jar", "/calculator.jar"]
