#FROM openjdk:17.0.2
#COPY . /usr/src/myapp
#WORKDIR /usr/src/myapp
#RUN chmod +x mvnw
#RUN ./mvnw clean package
#CMD ./mvnw cargo:run -P tomcat90 

FROM tomcat:9.0

COPY target/jpetstore.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
