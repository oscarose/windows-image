# More on the blog @ http://blog.alexellis.io

# Here you'll find - 1) Jenkins 2.0 Dockerfile for Windows Containers + 2) Java base image.


# 1) Jenkins 2.0 Dockerfile:
# docker build windows-jenkins:latest

# docker run -ti -p 8080:8080 windows-jenkins

FROM windows-java:latest

ENV HOME /jenkins
ENV JENKINS_VERSION 2.0
RUN mkdir \jenkins
RUN powershell -Command "wget -Uri https://updates.jenkins-ci.org/download/war/2.0/jenkins.war -UseBasicParsing -OutFile /jenkins/jenkins.war"

EXPOSE 8080

CMD [ "java","-jar", "c:\jenkins\jenkins.war" ]

# 2) Java Dockerfile
# docker build windows-java:latest
# From: https://github.com/StefanScherer/dockerfiles-windows/blob/master/java/Dockerfile

# escape=`
FROM microsoft/windowsservercore

RUN powershell -Command `
    wget 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185' -Outfile 'C:\jreinstaller.exe' ; `
    Start-Process -filepath C:\jreinstaller.exe -passthru -wait -argumentlist "/s,INSTALLDIR=c:\Java\jre1.8.0_91" ; `
    del C:\jreinstaller.exe

ENV JAVA_HOME c:\\Java\\jre1.8.0_91
RUN setx PATH %PATH%;%JAVA_HOME%\bin

CMD [ "java.exe" ]
