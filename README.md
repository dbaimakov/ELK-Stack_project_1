# ELK-Stack_project_1
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![TODO: Update the path with the name of your diagram](Images/diagram_filename.png)

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
ssh sysadmin@23.102.97.57
sudo su
docker container list -a
docker start charming_panini
docker attach charming_panini
ansible all -m ping
touch /etc/ansible/install-elk.yml
nano /etc/ansible/install-elk.yml

The following three playbooks: and the specific edits I had to do in all three: ELK, filebeat and metricbeat playbooks.

The first playbook is an ELK playbook used to configure the ELK VM with an ansible docker container that can open ports TCP 5601 used by Kibana to access ELK VM, HTTP 9200 used by elasticsearch to output log files and port 5044 used by Logstash to write in the log files. 

THE ELK VM PLAYBOOK
---
- name: Config ELK VM with Docker
  hosts: elk
  remote_user: sysadmin
  become: true
  tasks:
  - name: docker.io
    apt:
      force_apt_get: yes
      update_cache: yes
      name: docker.io
      state: present

  - name: Install pip3
    apt:
      force_apt_get: yes
      name: python3-pip
      state: present

  - name: Install Docker python module
    pip:
      name: docker
      state: present

  - name: download and launch a docker web container
    docker_container:
      name: elk
      image: sebp/elk:761
      state: started
      restart_policy: always
      published_ports:
        - 5601:5601
        - 9200:9200
        - 5044:5044

  - name: Configure elk VM to use more memory
    sysctl:
        name: vm.max_map_count
        value: "262144"
        state: present
        reload: yes

  - name: Enable docker service
    systemd:
      name: docker
      enabled: yes

For the successful installation of this playbook I had to edit the server host configuration file 
 of hosts belonging to the 'webservers' and 'elk' group since you can specify in playbooks which hosts you want the setting to apply to; and a slight change to Elasticsearch output to include logs using http monitoring port 9200

[webservers]
#alpha.example.org
#beta.example.org
#192.168.1.100
#192.168.1.110
                      10.0.0.5 ansible_python_interpreter=/usr/bin/python3
                      10.0.0.6 ansible_python_interpreter=/usr/bin/python3
                      10.0.0.8 ansible_python_interpreter=/usr/bin/python3
[elk]
                      10.1.0.4 ansible_python_interpreter=/usr/bin/python3
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:9200
  hosts: ["10.1.0.4:9200"]
  username: "elastic"
  password: "changeme"


Here you can find the filebeat playbook I wrote, in hosts I added webservers to specify my 3 Web VM's I want the filebeat to be installed at and configured to report web and login data to the log files

FILEBEAT PLAYBOOK

---
- name: Installing and Launching Filebeat
  hosts: webservers
  become: true
  tasks:
  - name: Download filebeat .deb file
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb

  - name: Install filebeat.deb
    command: sudo dpkg -i filebeat-7.4.0-amd64.deb

  - name: Drop in filebeat.yml
    copy:
      src: /etc/ansible/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

  - name: Enable and configure system module
    command: filebeat modules enable system

  - name: Setup filebeat
    command: filebeat setup

  - name: Start filebeat service
    command: service filebeat start

  - name: Enable service filebeat on boot
    systemd:
       name: filebeat
       enabled: yes

In the filebeat-config file  I had to make changes in Elasticsearch Output to specify the http port 9200 for the log creation and port 5601 to be used with kibana
 
  hosts: ["10.1.0.4:9200"]
  username: "elastic"
  password: "changeme"
And In the KIBANA Section
#
setup.kibana:
  host: "10.1.0.4:5601"
 
The following is the metricbeat playbook, similar to the filebeat. I have used a mac command here simply to showcase that various systems that require various commands for downloading and installing programs. For example in linux: dpkg -i; to unzip and install a mac file command is: tar -xvf 

The METRICBEAT PLAYBOOK
---
- name: Installing and Launching metricbeat
  hosts: webservers
  become: true
  tasks:
  - name: Download metricbeat.tar.gz file
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.15.0-darwin-x86_64.tar.gz

  - name: Install metricbeat.tar.gz
    command: tar -xvf metricbeat-7.15.0-darwin-x86_64.tar.gz

  - name: Drop in metricbeat.yml
    copy:
      src: /etc/ansible/metricbeat-config.yml
      dest: /etc/metricbeat/metricbeat.yml

  - name: enable and configure system module
    command: metricbeat modules enable docker

  - name: setup metricbeat
    command: metricbeat setup

  - name: Start metricbeat service
    command: service metricbeat start

  - systemd:
     name: metricbeat
     enabled: yes
     masked: no

I have made the following changes to the metricbeat-config.yml file very similar to the filebeat configuration files, however in the metricbeat I had to edit both the metricbeat.yml and metricbeat.referene.yml files 

setup.kibana:
host: "10.1.0.4:5601"
  # Kibana Host
  
output.elasticsearch:
  # Array of hosts to connect to.
  hosts: ["10.1.0.4:9200"]
  username: "elastic"
  password: "changeme"
  
#output.logstash:
  # The Logstash hosts
 hosts: ["10.1.0.4:5044"]
 
  hosts: ["10.1.0.4:9200"]
  username: "elastic"
  password: "changeme"


