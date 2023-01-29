# :book: 7. Install Jenkins onAWS EC2 Instance 

## Goals
- Install and configure Jenkins on an EC2 AWS instance.

## Requisites
- Have the EC2 instance already provisioned by the previous [step](../06_terraform/README.md)
- Count with a SSH key associated to the EC2 instance to connect to it.
- Have access to the [asgdevops/cd-project-jenkins](https://github.com/asgdevops/cd-project-jenkins.git) GitHub repository.
- The EC2 instance must run on Ubuntu 22.04, which has git and Python3 packages already installed.

# Architecture

The architecture model is a replica of the Jenkins Instance Running on the localhost Virtual Machine. 

The only difference is that instead of running the VM in virtualBox, it is running on AWS Platform.

# Steps to Install Jenkins on AWS EC2

1. Go to the AWS console and click over the EC2 instance.
2. Click on the **Connect** button
3. Open the **SSH-client** tab
4. Copy the SSH command from the example section. Ensure your SSH key points to the right directory.

5. Follow the same steps found at:
   - [Configuring Jenkins Part I: Admin Credentials and First plugins](../05_jenkins/README.md#configuring-jenkins-part-i-admin-credentials-and-first-plugins) and,
   - [Configuring Jenkins Part II: Set up the Agent Nodes](../05_jenkins/README.md#configuring-jenkins-part-ii-set-up-the-agent-nodes),
  skipping the VirtualBox configurations sections.

_ The recordings below, show briefly how to complete the Jenkins installation and configuration steps_

# :movie_camera: Set up jenkins recordings
- [jenkins setup 01](https://youtu.be/Wmkua_rMEa0)
- [jenkins setup 02](https://youtu.be/COMh0HkeFoo)
- 
# :books: References
- [Installing and configuring Jenkins](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#installing-and-configuring-jenkins)

