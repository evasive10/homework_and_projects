### Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

images/homework_NET_DIAG.PNG

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above, or select portions of the full_setup_playbook.yml file may be used to install only certain pieces of it such as filebeat.

This document contains the following details:
-Description of the topology
-Access Policies
-ELK Configuration
 -Beats in Use
 -Machines Being Monitored
-How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D$mn Vulnerable Web Application.

Load balancing ensure that the application will be highly redundant, in addition to restricting access to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file system and system metrics.

The configuration details of each machine may be found below.
|Name      |Function          |IP Address   |Operating System   |
|----------|------------------|-------------|-------------------|
|Jumpbox   |Gateway           |10.0.0.4     |Linux              |
|Web1      |Web Server        |10.0.0.7     |Linux              |
|Web2      |Web Server        |10.0.0.6     |Linux              |
|ELK       |Log Aggregation   |10.1.0.4     |Linux              |

### ACCESS POLICIES

The machines on the internal network are not exposed to the public Internet.

Only the ELK can accept connections from the Internet.  Access to this machine is only allowed from the following IP addresses:
192.168.0.5

Machines within the network can only be accessed by Jumpbox (10.0.0.4)

A summary of the access policies in place can be found in the table below.

|Name      |Publicly Accessible   |Allowed IP Addresses   |
|----------|----------------------|-----------------------|
|Jumpbox   |No                    |192.168.0.5            |
|Web1      |No                    |10.0.0.4               |
|Web2      |No                    |10.0.0.4               |
|ELK       |No                    |10.0.0.4               |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it allows the process to be performed much faster and error free.

The playbook implements the following tasks:
-Sets up the VM to be able to handle ELK
-Installs Docker
-Installs Pip for python3
-Installs docker python module
-Downloads and installs ELK image

The following screenshot displays the result of running 'docker ps' after successfully configuring the ELK instance.

images/elk_started.png

### Target Machines & Beats

This ELK server is configured to monitor the following machines:
-10.0.0.6
-10.0.0.7

We have installed the following Beats on these machines:
-Filebeat
-Metricbeat

These Beats allow us to collect the following information from each machine:
-Filebeat is used to collect log files from specific files, and specifically tracks which files have been changed and when.
-Metricbeat collects metics from the operating system and services on the server, such as uptime, CPU usage, or memory.

### Using the Playbook

In order to use the playbook, you will need to have an Ansible control node already configured.  Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
-Copy the elk.yml file to the /etc/ansible directory.
-Update the hosts file to include the creation of new server groups (bracketed '[]' name that defines the group) with the IPs of the desired servers underneath it.  
-Run the playbook and navigate to the public IP of the server ('public_IP':5601/app/kibana) to check that the installation worked as expected.
