# ELK-Stack_project_1
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://github.com/dbaimakov/main/ELK-Stack_project_1/Images/AzureCloudSetup.drawio.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML file may be used to install only certain pieces of it, such as Filebeat.

  elk_playbook.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA.

Load balancing ensures that the application will be highly effective, in addition to restricting traffic access to the network.
	What aspect of security do load balancers protect? 
	They prevent undesirable or unauthorized traffic from reaching the application.
	What is the advantage of a jump box? 
	It adds a security layer to the web servers preventing them from being exposed to the public.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the configuration files and system files.
What does Filebeat watch for? It watches for Log files or log events
What does Metricbeat record? It records Metrics from services on the server including CPU usage and system files.

The configuration details of each machine may be found below.

| Name    | Function | IP Address | Operating System |
|---------|----------|------------|------------------|
| Jump Box| Gateway  | 10.0.0.4   | Linux            |
| Web-1   | Webserver| 10.0.0.5   | Linux            |
| Web-2   | Webserver| 10.0.0.6   | Linux            |
| Web-3   | Webserver| 10.0.0.8   | Linux            |
| ELK-VM  | Webserve | 10.1.0.4   | Linux            |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 174.95.182.223 (my personal's machine public IP)

Machines within the network can only be accessed by Jumpbox.
Which machine did you allow to access your ELK VM? What was its IP address?_From the Jump-Box-VM's ansible container. 13.68.142.130

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------|----------------------|
| Jump Box | Yes     | 10.0.0.4   | 174.95.182.223|10.0.0.5,6,8,4
| Web-1   | No.      | 10.0.0.5   | 13.68.142.130 | 10.0.0.4       
| Web-2   | No.      | 10.0.0.6   | 13.68.142.130 | 10.0.0.4       
| Web-3   | No.      | 10.0.0.8   | 13.68.142.130 | 10.0.0.4       
| ELK-VM  | Yes/HTTP | 10.1.0.4   | 13.68.142.130 | 10.0.0.4   
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
What is the main advantage of automating configuration with Ansible? It is flexible since it allows changes to be made within any of the VMs that are associated with it.

The playbook implements the following tasks:
In 3-5 bullets, explain the steps of the ELK installation play. 
- Install docker.io
- Install python3-pip
- Install docker Python Module
- Download and launch a Docker web container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
10.0.0.6 | 10.0.0.8 | 10.0.0.5

We have installed the following Beats on these machines:
Filebeat and Metricbeat

These Beats allow us to collect the following information from each machine:
Filebeat monitors log files and log events like input harvesters (HTTP, SSH); while Metricbeat looks out for any information in the file system data (CPU usage, RAM)

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the ansible configuration file to run playbooks.
- Update the ansible host file to include private IP's of Web1,2,3
- Run the playbook, and navigate to Jumpbox to check that installation worked as expected.

 Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it? install-elk.yml in to the /etc/ansible directory
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on? install-elk.yml file. By using the IP's of the servers in a configuration.yml file
- _Which URL do you navigate to in order to check that the ELK server is running? http://23.102.97.57:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
ssh sysadmin@13.68.142.130 | sudo su | docker container list -a | docker start charming_panini | docker attach charming_panini | ansible all -m ping | touch /etc/ansible/install-elk2.yml | nano /etc/ansible/install-elk2.yml

