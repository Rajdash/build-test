FROM java:8
WORKDIR /java/app
COPY ./target/spring-boot-web-0.0.1-SNAPSHOT.jar /java/app
CMD java -jar spring-boot-web-0.0.1-SNAPSHOT.jar
