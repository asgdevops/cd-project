FROM jenkins/agent AS jenkins-agent-python
USER root
RUN apt-get update && apt-get install -y python
USER jenkins
CMD ["/bin/sh"]
