# :book: 6. Provision an AWS EC2 Instance 

## Goal 
- Provision an AWS EC2 instance from a Jenkins pipeline.
- The pipeline has to pull the script from a GitHub SCM repository.
- It also launches the Terraform scripts in charge of provisioning the AWS EC2 instance.

## Requiremens
- Signup with a Free Tier accoutn in AWS.
- Set up the Terraform scripts to create the objects below:
  - Virtual Private Network (VCP).
  - Public Subnet.
  - Public Route table.
  - Internet Gateway.
  - Create the security groups fro HTTP and SSH ports.
  - Associate the Network objects accordingly.
  - Use a current key-pair
  - Create and Launch an EC2 instance.


# Architecture


The architecture followed in this document consists of a single instance living in its subnet and VPC accoringly.

The EC2 has the HTTP port 8080 and the SSH port 22 open by the security group. 

The route table is associated with the public subnet and the Internet Gateway, so that the EC2 instance could be accessed from any part.

The login access is achieved by the ssh key-pair.

  ||
  |:--:|
  |![diagram](images/aws_infra_architecture.png)|
  |Fig 1. AWS EC2 instance architecture|

# Installation 

Jenkins installation has been automated by combining BASH shell scripting, with Docker files and docker-compose.yaml files.

The aim is to implement the Continuous Integration process from the beginning until the end of the project.

## Scripts usage

|No.|Script name|Purpose or function|Links to|
|--:|--|--|--|
|1|[install_jenkins.sh](jenkins/install_jenkins.sh)|Jenkins installer for Ubuntu 22.04 systems. <br/> 1. Creates the `.env` environments variable file. <br/> 2. Installs Docker Engine. <br/> 3. Configures the persistent volumes directories. <br/> 4. Creates the SSH key pair (ed25519) to keep the jenkins controller and nodes working together. <br/> 5. Launches the `docker-compose.yml` file to build and run the Jenkins containers.|--> docker-compose.yml file|
|2|[docker-compose.yml](jenkins/docker-compose.yml)|1. Builds the images of the Jenkins controller and agent nodes. <br/> 2. Creates the containers from the docker images. <br/> 3. Creates the Docker network. <br/> 4. Binds the docker volumes for persitent data.|--> jenkins.Dockerfile <br/> --> centos.Dockerfile <br/> --> debian.Dockerfile <br/> --> ubuntu.Dockerfile|
|3|[alpine.Dockerfile](jenkins/alpine.Dockerfile)|Builds the alpine:3.17 controller node. <br/> 1. Sets up the jenkins user with root privileges. <br/> 2. Installs and configures SSHD. <br/> 3. Installs git, openJDK 11, Ansible and Terraform. ||
|4|[centos.Dockerfile](jenkins/centos.Dockerfile)|Builds the centos:7 agent node. <br/> 1. Sets up the jenkins user with root privileges. <br/> 2. Installs and configures SSHD. <br/> 3. Installs git and openJDK 11.||
|5|[debian.Dockerfile](jenkins/debian.Dockerfile)|Builds the debian:11 agent node. <br/> 1. Sets up the jenkins user with root privileges. <br/> 2. Installs and configures SSHD. <br/> 3. Installs git and openJDK 11.||
|6|[ubuntu.Dockerfile](jenkins/ubuntu.Dockerfile)|Builds the ubuntu:22.04 agent node. <br/> 1. Sets up the jenkins user with root privileges. <br/> 2. Installs and configures SSHD. <br/> 3. Installs git and openJDK 11.||

The process below will be replicated on the AWS EC2 instance.
As a result, follow the steps below to complete the Jenkins installation.

# Steps

1. Ensure the Ubuntu VM is running and start a new SSH session.

    ```bash
    ssh ansalaza@localhost -p 2210
    ```

    |![jenkins](images/jenkins_setup_01.png)|
    |:--:|
    |Figure 1 - SSH log into VM |

2. Clone the [asgdevops/cd-project-jenkins](https://github.com/asgdevops/cd-project-jenkins.git) GitHub repository

    ```bash
    git clone https://github.com/asgdevops/cd-project-jenkins.git

    cd cd-project-jenkins
    ```

    |![jenkins](images/jenkins_setup_02.png)|
    |:--:|
    |Figure 2 - clone cd-project-jenkins repository |

3. Ensure the user account you are using has sudo privileges.

    ```bash
    sudo cat /etc/os-release
    ```

    |![jenkins](images/jenkins_setup_03.png)|
    |:--:|
    |Figure 3 - SSH log into VM |

4. Execute the `install_jenkins.sh` shell script.

    ```bash
    ./install_jenkins.sh
    ```

    _Depending on the VM spped, it shall take between 5 to 20 minutes to complete._

      |![jenkins](images/jenkins_setup_04a.png)|
    |:--:|
    |Figure 4a - install_jenkins.sh part I |

    When the installation process gets complete, you should see five containers running:

    |No.|Container|Descriptions|
    |--:|--|--|
    |1|jenkins|Jenkins master controller|
    |2|alpine-controller|Alpine agent working as the Ansible master controller|
    |3|centos-agent|CentOS 7 agent node|
    |4|debian-agent|Debian 11 ("bullseye") agent node|
    |5|ubuntu-agent|Ubuntu 22.04 ("jammy") agent node|

    There should be also:

    |No.|Resource name|Description|Cmd|
    |--:|--|--|--|
    |1|jenkins_net|Docker bridge network resource|`sudo docker network ls`|
    |2|jenkins_data|Docker persistent volume bind to `/app/data/jenkins/jenkins_home` directory|`sudo docker network ls`|

    |![jenkins](images/jenkins_setup_04b.png)|
    |:--:|
    |Figure 4b - install_jenkins.sh part II |


<br/>

# Configuring Jenkins Part I: Admin Credentials and First plugins

5. Get the **initial Admin Password**from the logs.

- Option 1: Opening the `/var/jenkins_home/secrets/initialAdminPassword` file.

  ```bash
  sudo docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
  ```

  |![jenkins](images/jenkins_setup_05.png)|
  |:--:|
  |Figure 5 - Jenkins initial Admin Password from file |

- Option 2: Gather it from the container log.

  ```bash
  docker logs jenkins
  ```

  |![jenkins](images/jenkins_setup_06.png)|
  |:--:|
  |Figure 6 - Jenkins initial Admin Password from log|

6. On **Oracle VM virtualBox Manager**, use the virtual network port forwarding rules to map the host port 8010 to the VM port 8080.

   - Open **Oracle VM VirtualBox Manager** and click on **Tools** > **Preferences**
   - On the **VirtualBox - Preferences** screen, select **Network** from the left pane.

    |![jenkins](images/jenkins_setup_06a.png)|
    |:--:|
    |Figure 6a - VirtualBox - Preferences|

   - Select your virtual network and click on the **Edits Selected NAT Network** icon on the right side of the screen.

   - On the **NAT Network Details** screen click on **Port Forwading**

    |![jenkins](images/jenkins_setup_06b.png)|
    |:--:|
    |Figure 6b - NAT Network Details|

   - Add a new port forwarding rule with as shown in the table below:

     |Name|Protocol|Host IP|Host Port|Guest IP|Guest Port|
     |--|--|--|--|--|--|
     |http_vm1|TCP|127.0.0.1|8010|10.7.2.10|8080|

    |![jenkins](images/jenkins_setup_06c.png)|
    |:--:|
    |Figure 6c - Port Forwarding Rules|


7. Login to Jenkins application in the web browser.
   - Open a new Web Browser and go to `http://localhost:8080`
   - Type the admin password taken from the jenkins Docker container

       |![jenkins](images/jenkins_setup_07.png)|
       |:--:|
       |Figure 7 - Unlock Jenkins|

   - Click on the **Install suggested plugins** button

       |![jenkins](images/jenkins_setup_08.png)|
       |:--:|
       |Figure 7a - Customize Jenkins|

   - Monitor the progress of the plug ins installation

       |![jenkins](images/jenkins_setup_09.png)|
       |:--:|
       |Figure 7b - Getting Started|

   - Input the **Admin User** credentials

       |![jenkins](images/jenkins_setup_10.png)|
       |:--:|
       |Figure 7c - Create First Admin User|

   - Set up the Jenkins Application URL and port number

       |![jenkins](images/jenkins_setup_11.png)|
       |:--:|
       |Figure 7d - Instance Configuration|

   - After getting the confirmation page, click on **Start using Jenkins**

       |![jenkins](images/jenkins_setup_12.png)|
       |:--:|
       |Figure 7e - Jenkins is ready!|

   - Now the Jenkins Dashboard screen is open

       |![jenkins](images/jenkins_setup_13.png)|
       |:--:|
       |Figure 7f - Jenkins Dashboard|


# Configuring Jenkins Part II: Set up the Agent Nodes
8. Add the SSH and the CloudBees plugins.



9.  Add the Alpine, CentOS, Debian and Ubuntu nodes accordingly.


10. Run the [ansible_hello.pipeline]() to the a simple test.


# :books: References
- [Installing Jenkins - Docker](https://www.jenkins.io/doc/book/installing/docker/)