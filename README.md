# ELK-Stack_project_1
## ELK Stack Deployment

The files in this repository were used to configure below network topology.

- #### https://github.com/dbaimakov/ELK-Stack_project_1/blob/78e22782a57aa4ffe4dfc79c376061715484ccf7/diagrams/AzureCloudSetup.drawio.png

#### These files have been properly tested to create a live ELK deployment (ElasticSearch, Logstash and Kibana) on Azure. Files in this project can be used to recreate an entire deployment from the diagram above. Alternatively, specific parts of the YAML playbook file could be utilized to install only certain parts of it, such as Filebeat or Metricbeat.

- #### [DVWA Webserver Playbook]  https://github.com/dbaimakov/ELK-Stack_project_1/blob/main/ansible/dvwa-playbook.yml

- #### [ELK Stack Playbook] https://github.com/dbaimakov/ELK-Stack_project_1/blob/main/ansible/ELK-playbook.yml

- #### [Filebeat Playbook] https://github.com/dbaimakov/ELK-Stack_project_1/blob/main/ansible/filebeat-playbook.yml
 
- #### [Metricbeat Playbook] https://github.com/dbaimakov/ELK-Stack_project_1/blob/main/ansible/Metricbeat-playbook.yml 


This document contains the following details:
- Network Topology
- Access configuration files 
- ELK configuration settings and playbook
- Machine's that are being monitored
- How to fully configure and install an Azure environment using the ansible docker container


### Description of the Topology

The main purpose of this network is to create a clear distribution of an analytic engine, which transform various VM data into a clear log file. Sending it over to the Kibana open source tool - a load-balanced and monitored data of various occurrences that are happening on the DVWA Virtual Machines.

Load balancing ensures that the application will be highly effective, in addition to restricting traffic access to the network.
 
 What aspect of security do load balancers protect? 
- They prevent undesirable or unauthorized traffic from reaching the application.

 What is the advantage of a jump box? 
- It adds a security layer to the web servers, preventing them from being exposed to the public.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the configuration files and system files. What does Filebeat watch for? 
- Filebeat parses and forwards system logs from the Web VMs to the ELK VM in an easy to read format.

What does Metricbeat record? 
- Reports system and service statistics about the Web VMs to the ELK VM.

The configuration details of each machine may be found below.

| Name    | Function | IP Address | Operating System |
|---------|----------|------------|------------------|
| Jump Box| Gateway  | 13.68.142.130   | UBUNTU LTS 18.04             |
| Web-1   | App. Webserver | 10.0.0.5   | UBUNTU LTS 18.04            |
| Web-2   | App. Webserver| 10.0.0.6   | UBUNTU LTS 18.04             |
| Web-3   | App. Webserver| 10.0.0.8   | UBUNTU LTS 18.04             |
| ELK-VM  | ELK Stack | 23.102.97.57   | UBUNTU LTS 18.04             |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 

`My home public IP` (My iMac's IP address)
Machines within the network can only be accessed by Jumpbox.

Which machine is allowed to access your ELK VM? What is its IP address?
- From the Jump-Box-VM's ansible container `13.68.142.130` or `10.1.0.4`

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|--------|----------------------|
| Jump Box | Yes    | My home IP |
| Web-1   | No.     | 10.0.0.4   |      
| Web-2   | No      | 10.0.0.4   |     
| Web-3   | No      | 10.0.0.4   |    
| ELK-VM  | Yes     | My home IP |   

### Elk Configuration

- Ansible can be used to automate configuration of the ELK machine. No configuration is performed manually, which is advantageous because it allows a consistent and predictable configuration. In addition to consistency, with an automated setup, the ELK stack can be created and configured very quickly.

What is the main advantage of automating configuration with Ansible? 
- It is flexible since it allows changes to be made within any of the VMs that are associated with it.

 The playbook implements the following tasks:
- Configure maximum mapped memory with `sysctl` module
- Install `docker.io` and `python3-pip` packages with `apt` module
- Install docker `python` package with `pip`
- Enable `systemd` docker service
- Run ELK docker container

The following screenshot displays the results of running `docker ps` after successfully configuring the ELK instance.

https://github.com/dbaimakov/ELK-Stack_project_1/blob/5de8f51a6a3b130757e9f2fd9ebfc2c7de152700/Images/sudo%20docker%20ps.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 10.0.0.5 
- Web-2 10.0.0.6 
- Web-3 10.0.0.8

The following Beats were installed on these machines:
- Filebeat and Metricbeat 

These Beats allows to collect the following information from each machine:
- Filebeat parses and forwards system logs from the Web VMs to the ELK VM in an easy to read format.
- Metricbeat reports system and service statistics about the Web VMs to the ELK VM.

### Using the Playbook
In order to use these playbooks, you will need to be attached to your docker container and have an Ansible control node configured. 

SSH into the control node and follow the steps below:
- Copy the `elk-atack.yml` playbook file inside the ansible container 
- `sudo docker cp elk-stack.yml` 
- `sudo docker cp install-elk.yml charming_panini/etc/ansible/roles/install-elk.yml`

Start and attach to the ansible docker container 
-  `sudo docker start charming_panini` 
-  `sudo docker attach charming_panini`
- Update the `/etc/ansible/hosts` configuration file to include IP: ELK VM and 3 DVWA VM's; and edit them under `[elk]` and `[webserver]` groups respectively.
- #### [Ansible Hosts configuration file sample] https://github.com/dbaimakov/ELK-Stack_project_1/blob/89a2dbb457ea5a84c3cc57f1e8741bdb48c3c386/ansible.hosts.cfg
- Run the playbook`ansible-playbook /etc/ansible/elk-stack-playbook.yml`and navigate to `http://23.102.97.57:5601/app/kibana#/home` to check that installation worked as expected.



Which file is the playbook? Where do you copy it? 
-  `install-elk.yml` in to the `/etc/ansible` directory

Which file do you update to make Ansible run the playbook on a specific machine? How would you specify which machine to install the ELK server on versus which to install Filebeat on? 
-  In the Elk-playbook.yml you would indicate `[elk]` under `host`. In the filebeat-playbook.yml and metricbeat-playbook.yml you would indicate `[webserver]` as a `host` 

Which URL do you navigate to in order to check that the ELK server is running? 
- http://http://13.90.29.75/setup.php

### Provide the specific commands the user will need to run to download the playbook, update the files, etc.
- Edit `/etc/ansible/files/filebeat-config.yml` and `/etc/ansible/files/metricbeat-config.yml` in the ansible container on the control node to include the ELK Stack IP address. You should also change the default login credentials.
- After the first edit run `ansible-playbook /etc/ansible/roles/filebeat_playbook.yml`
- After the second edit run `ansible-playbook /etc/ansible/roles/metricbeat_playbook.yml`
 #### [Filebeat configuration file sample] https://github.com/dbaimakov/ELK-Stack_project_1/blob/main/Filebeat.config.cfg
 #### [Metricbeat configuration file sample] https://github.com/dbaimakov/ELK-Stack_project_1/blob/main/metricbeat.config.cfg
 
 This should successfully configure all of your VM's. Install configured filebeat and metricbeat; both of which will send logstash data to Kibana.
