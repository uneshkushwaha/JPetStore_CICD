MyBatis JPetStore
=================

[![Java CI](https://github.com/mybatis/jpetstore-6/actions/workflows/ci.yaml/badge.svg)](https://github.com/mybatis/jpetstore-6/actions/workflows/ci.yaml)
[![Container Support](https://github.com/mybatis/jpetstore-6/actions/workflows/support.yaml/badge.svg)](https://github.com/mybatis/jpetstore-6/actions/workflows/support.yaml)
[![Coverage Status](https://coveralls.io/repos/github/mybatis/jpetstore-6/badge.svg?branch=master)](https://coveralls.io/github/mybatis/jpetstore-6?branch=master)
[![License](https://img.shields.io/:license-apache-brightgreen.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)

![mybatis-jpetstore](https://mybatis.org/images/mybatis-logo.png)

JPetStore 6 is a full web application built on top of MyBatis 3, Spring 5 and Stripes.

Essentials
----------

* [See the docs](http://www.mybatis.org/jpetstore-6)

## Other versions that you may want to know about

- JPetstore on top of Spring, Spring MVC, MyBatis 3, and Spring Security https://github.com/making/spring-jpetstore
- JPetstore with Vaadin and Spring Boot with Java Config https://github.com/igor-baiborodine/jpetstore-6-vaadin-spring-boot
- JPetstore on MyBatis Spring Boot Starter https://github.com/kazuki43zoo/mybatis-spring-boot-jpetstore

## Run on Application Server
Running JPetStore sample under Tomcat (using the [cargo-maven2-plugin](https://codehaus-cargo.github.io/cargo/Maven2+plugin.html)).

- Clone this repository

  ```
  $ git clone https://github.com/mybatis/jpetstore-6.git
  ```

- Build war file

  ```
  $ cd jpetstore-6
  $ ./mvnw clean package
  ```

- Startup the Tomcat server and deploy web application

  ```
  $ ./mvnw cargo:run -P tomcat90
  ```

  > Note:
  >
  > We provide maven profiles per application server as follow:
  >
  > | Profile        | Description |
  > | -------------- | ----------- |
  > | tomcat90       | Running under the Tomcat 9.0 |
  > | tomcat85       | Running under the Tomcat 8.5 |
  > | tomee80        | Running under the TomEE 8.0(Java EE 8) |
  > | tomee71        | Running under the TomEE 7.1(Java EE 7) |
  > | wildfly26      | Running under the WildFly 26(Java EE 8) |
  > | wildfly13      | Running under the WildFly 13(Java EE 7) |
  > | liberty-ee8    | Running under the WebSphere Liberty(Java EE 8) |
  > | liberty-ee7    | Running under the WebSphere Liberty(Java EE 7) |
  > | jetty          | Running under the Jetty 9 |
  > | glassfish5     | Running under the GlassFish 5(Java EE 8) |
  > | glassfish4     | Running under the GlassFish 4(Java EE 7) |
  > | resin          | Running under the Resin 4 |

- Run application in browser http://localhost:8080/jpetstore/ 
- Press Ctrl-C to stop the server.

## Run on Docker
```
docker build . -t jpetstore
docker run -p 8080:8080 jpetstore
```
or with Docker Compose:
```
docker compose up -d
```

## Try integration tests

Perform integration tests for screen transition.

```
$ ./mvnw clean verify -P tomcat90
```





###My_notes

1. created AWS ec2 instance (JPetStore_CICD) and connected on ubuntu with ssh -i "cicd_project_key.pem" ubuntu@ec2-13-60-170-55.eu-north-1.compute.amazonaws.com
   https://prnt.sc/lmj8_sJcom-_

   ### Jenkins
   Note: Everytime you create different ec2 server then each time you have install java, Jenkins, Docker and have to enable the PORTS , only keypair can be same for all other instances.
   1. Installed java, Jenkins on ubutntu ec2 server.
   2. sudo systemctl start jenkins, sudo systemctl enable jenkins, sudo systemctl status jenkins
   3.  Jenkins can be only accessed on the port 8080 - so, it is enbale is AWS --> Security Groups --> https://prnt.sc/DPkL9XbtB53t
   4.  Now, the Jenkins is accessible with public ip of ec2 server :8080
      https://prnt.sc/3xSsfjyHIaoU
Note: In case if you have stopped the server - the connection will be refused to connect and everytime you start the server - it will have different public_ip.

5. Once Jenkins is accessed - they will ask for the initial password from the path they provide like /var/lib/jenkins/secrets/initialAdminPassword.
6. Paste the password from the path and again customize the password as you desire.
7. Plugins Installed : - Eclipse Temurin installer
                       - SonarQube Scanner
                       - OWASP Dependency-Check
                       - Docker
                       - Docker PipelineVersion
###Creating Job:
1. job name:- PetAnimalStore
2. Job type: pipeline and clicked OK
3. Old build discarded and max of build to keep is 2.
4. Hello World - sample pipeline is considered.
5. Pipeline Syntax:- Git, main, no credentials is required if repo is public, unchecked includes, and clicked on generate pipeline script.
   https://prnt.sc/FM5pb7ZtvHLp
6. Pipeline Script:   
https://prnt.sc/VLKSU1weRO-t

 7. Sonarqube Starting: https://prnt.sc/A5JcGHqwO1QP
 https://prnt.sc/l7kXHE7seCn6
8. Sonarqube Login: https://prnt.sc/_-hXWJUA8qdu, https://prnt.sc/9hHzZ8xJmCGx, https://prnt.sc/nnPGsOR2rWKY
9. For authentication of Sonarqube with Jenkins we requires Token:
 10. PipelineSyntax:https://prnt.sc/fgZW0VhERvCk   



##################################### Error: #######################################

a. While accessing Sonarqube on port 9000 faced issuing like when i give command to start sonarqube then it get start but suddenly get crashed due to the lack of memory.

so, change the instance type from t3.micro to t3.small (2GB) - same issue in 2GB, c7i-flex.large (4GB) then it worked.





b.  6th build was failed due to error in the sonarqube script as the previous was `Dsonar.url=http://16.171.1.175:9000/` which indicates the access of sonarqube cloud server by ignoring our local sonarqube server created on ec2 instance. This was replaced by `-Dsonar.host.url=http://16.171.1.175:9000`

c. 7th build also failed as i have stopped the ec2 instance pervious for cost saving - in the new day starting the ec2 instance changes the public_ip which should replace in the script of the sonarqube and the networking issues which caused the build failed resolved here.

d. 8th build faile because of NVD returned status 409 that means too many request where Jenkins is trying to download the vulnerability from NVD (National Vulnerability Database). As a solution - API key is requested from the NVD website which is free that makes smoother to make further more requests. This comes under the OWSAP(open Web Application Security Project) - dependency check: https://prnt.sc/Lt8UCC-VNp_e

Error: String Interploation, also the actual API key is the one you get after the 100% validation of the API key which you have received in the email. The API key activated in  the email is not the actual API key.

e. In 22th build the OWSAP build was succed as the API key was wrong initally, secondly due to multiple builds - disks get occupied and no swap available for the RAM which was configured with 20GB in ec2 console before it was 8GB EBS. https://prnt.sc/nGKyUgaxR_Vc
https://prnt.sc/vKhjd7aWEpvl


f. 34th build failed - Maven build was failed due to the cargo plugin enabled in the pom.xml and also Maven enforcer was failing the build as there is not mentioned the war plugin version.
https://prnt.sc/RkvwmTJP-rLr
https://prnt.sc/2nJTaggw_0XT

g. Added jenkins in docker :--> https://prnt.sc/L9Wxarv1ie10

g. Finally, in 41th build - whole pipeline was successfully build. After Maven build - there was issues on the docker file which was changed.
https://prnt.sc/tg8R_LRfhlA-

h. Personal Access Token (PAT) was generated in app.docker.com with read,write,delete permission - intially only read permission which was failing to push the image in docker hub.  ----> https://prnt.sc/iYEnsYIQJMIy

i. https://prnt.sc/DAZPTfsPA9LK -> pushed docker imaged.

j. All stages completed: https://prnt.sc/Pg2VxAQ1l2xk





















































---------------------------------Descriptive pipeline-----------------------------------------------

pipeline {
    agent any

    tools {
        jdk 'jdk21'
        maven 'maven3'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/uneshkushwaha/JPetStore_CICD.git'
            }
        }

        stage('Compile') {
            steps {
                sh "mvn clean compile"
            }
        }

        stage('Sonarqube Analysis') {
            steps {
                sh '''
                $SCANNER_HOME/bin/sonar-scanner \
                -Dsonar.host.url=http://13.51.162.14:9000 \
                -Dsonar.login=squ_e3fc5e1608860967ed9bdf488ae689625fc32b31 \
                -Dsonar.projectName=petstore \
                -Dsonar.java.binaries=. \
                -Dsonar.projectKey=PetAnimalStore
                '''
            }
        }

        stage('OWASP Dependency') {
            steps {
                withCredentials([string(credentialsId: 'nvd-api-key', variable: 'NVD_KEY')]) {
                    dependencyCheck additionalArguments: "--scan ./ --nvdApiKey=$NVD_KEY", odcInstallation: 'DP'
                }
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }

        stage('Build') {
            steps {
                sh "mvn clean install -DskipTests -Dcargo.skip=true -Dcargo.start.skip=true"
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                 withDockerRegistry(credentialsId:'b97dcb4d-9fd2-4d14-8b49-315a678eff26') {
                        sh "docker build -t petanimalstore ."
                        sh "docker tag petanimalstore:latest uneshkushwaha/jpetstore_cicd:latest"
                        sh "docker push uneshkushwaha/jpetstore_cicd:latest"
                    }
                }
            }
        }

        stage('Trivy') {
            steps {
                sh "trivy image uneshkushwaha/jpetstore_cicd:latest"
            }
        }
    }
}

