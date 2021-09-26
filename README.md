# ELK-Stack_project_1
## ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://github.com/dbaimakov/ELK-Stack_project_1/blob/78e22782a57aa4ffe4dfc79c376061715484ccf7/diagrams/AzureCloudSetup.drawio.png

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
- What aspect of security do load balancers protect? 
- $ They prevent undesirable or unauthorized traffic from reaching the application.
- What is the advantage of a jump box? 
- $ It adds a security layer to the web servers preventing them from being exposed to the public.

- Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the configuration files and system files. What does Filebeat watch for? 
- $ Filebeat parses and forwards system logs from the Web VMs to the ELK VM in an easy to read format.
- What does Metricbeat record? 
- $ Metricbeat reports system and service statistics about the Web VMs to the ELK VM.

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

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: `174.95.182.223` (my personal's machine public IP)

Machines within the network can only be accessed by Jumpbox.
Which machine did you allow to access your ELK VM? What was its IP address?
- $ From the Jump-Box-VM's ansible container. `13.68.142.130` or `10.1.0.4`

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|--------|----------------------|
| Jump Box | Yes    | 174.95.182.223 |
| Web-1   | No.     | 10.0.0.4   |      
| Web-2   | No      | 10.0.0.4   |     
| Web-3   | No      | 10.0.0.4   |    
| ELK-VM  | Yes     | 174.95.182.223 |   

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
What is the main advantage of automating configuration with Ansible? It is flexible since it allows changes to be made within any of the VMs that are associated with it.

The playbook implements the following tasks:
In 3-5 bullets, explain the steps of the ELK installation play. 
- Configure maximum mapped memory with `sysctl` module
- Install `docker.io` and `python3-pip` packages with `apt` module
- Install `docker python` package with `pip`
- Enable `systemd` docker service
- Run ELK docker container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

https://github.com/dbaimakov/ELK-Stack_project_1/blob/5de8f51a6a3b130757e9f2fd9ebfc2c7de152700/Images/sudo%20docker%20ps.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
10.0.0.6 | 10.0.0.8 | 10.0.0.5

We have installed the following Beats on these machines:
Filebeat and Metricbeat

These Beats allow us to collect the following information from each machine:
Filebeat parses and forwards system logs from the Web VMs to the ELK VM in an easy to read format.
Metricbeat reports system and service statistics about the Web VMs to the ELK VM.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the ansible configuration file to run playbooks.
- `sudo docker cp install-elk.yml charming_panini:/etc/ansible/roles/install-elk.yml`
- Update the ansible host file to include private IP's of Web1,2,3
- `nano /etc/ansible/hosts`
- https://github.com/dbaimakov/ELK-Stack_project_1/blob/6638154212c51e59dd6dfd636022c8f66cac28a0/ansible.hosts.yml
- - Run the playbook, and navigate to Jumpbox to check that installation worked as expected.
- `ansible-playbook /etc/ansible/elk-stack-playbook.yml`
- `http://23.102.97.57:5601/app/kibana#/home`

 Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it? 
- $ `install-elk.yml` in to the `/etc/ansible` directory
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on? 
- $ `nano /etc/ansible/hostsfile. By editing the hosts file under Ansible hosts you can specify which group you need `webservers` or `elk` 
-  https://github.com/dbaimakov/ELK-Stack_project_1/blob/6638154212c51e59dd6dfd636022c8f66cac28a0/ansible.hosts.yml
-- https://github.com/dbaimakov/ELK-Stack_project_1/blob/6638154212c51e59dd6dfd636022c8f66cac28a0/Filebeat.config.yml
- - - _Which URL do you navigate to in order to check that the ELK server is running? 
- `http://23.102.97.57:5601/app/kibana`

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
- $ ssh sysadmin@13.68.142.130 | sudo su | docker container list -a | docker start charming_panini | docker attach charming_panini | ansible all -m ping | touch /etc/ansible/install-elk2.yml | nano /etc/ansible/install-elk2.yml

