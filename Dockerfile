# windows dockerfile to run jenkins ci server---pull base image from ms 2019 server

FROM mcr.microsoft.com/windows/servercore:ltsc2019

#===Know you maintener====

LABEL maintainer="Abraham Ogba"

ENV CATALINA_HOME C:\\jenkins\\apache-tomcat-8.5.57

#==create jenkins install directory(folder)===

RUN powershell -command mkdir C:\jenkins

#==copy tomcat windows zip file to jenkins install directory from currect folder(pwd)

COPY apache-tomcat-8.5.57-windows-x64.zip C:/jenkins/

#==Run powershell command to setup chocolatey(windows package manager) and unzip tomcat zip file====

RUN powershell.exe -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); \
    Expand-Archive -LiteralPath C:\jenkins\apache-tomcat-8.5.57-windows-x64.zip -Destination C:\jenkins

#===copy jenkins war file from current folder(pwd) to tomcat webapps folder)

COPY jenkins.war C:/jenkins/apache-tomcat-8.5.57/webapps/

#===installl java with chocolatey===

RUN choco install jdk8 -y 

#==expose tomcat listener port===

EXPOSE 8080

#==tomcat startup script and keep the container running===

CMD powershell -Command C:\\jenkins\\apache-tomcat-8.5.57\\bin\\startup.bat && cmd /c ping -t localhost > NUL
