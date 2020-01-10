# Spring PetClinic Sample Application built with Jenikins

## Preparing the infrastructure
In order to build the application I have first created the Jenkins and the Artifactory servers.
I have chosen to use docker-compose in order to create the two servers and manage all the networking.
The docker-compose file is located under the infrastructure folder.

## Creating the pipeline
To initiate the build process I have created a pipeline which is based on Git repository.
The pipeline is based on Git SCM, to be built on each commit, in order to make this work I have added a post-commit file in the git folder.

## Jenkinsfile
I have defined four steps for the exercise: building the JAR file, then performing the unit tests, creating the Docker image with JAR file which was created in the first step. The last step is deploying to artifactory the relevant artifacts.

## Configuring the POM file
I have made the following changes to the POM file:

* Changed the repository so that the dependencies will be resolved by jcenter
* Added support for JFrog Artifactory (Also added Maven settings file for Artifactory credentials)

## Dockerfile
The Dockerfile is based on image which contains the minimum resources to run the application.
Then we just need to copy the JAR file and run it.

## Artifactory
Created a new local repository and added permissions to a new user.
I have configured the artifactory in the POM file of the petclinic project to point it to the JFrog Artifactory.

## Running the project
Change the post-commit according to the project location and add a git repository in jenkins in order to listen to the webhook.
Insert the following lines to the .git/hooks/post-commit file

```
#!/bin/sh
curl http://localhost:8080/git/notifyCommit?url=file://Users/ohadisraeli/jenkins/spring-petclinic
```

Then just simply modify a file in the project to get the build process started.

## Running the image
In order to run the image run the following commands 
```
docker load -i petclinic.tar
docker run  -d --rm -p 8080:8080 --name petclinic ohadisra/petclinic:latest
```
