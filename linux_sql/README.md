# Introduction

This tool allows users to review hardware specifications of the system. It is the users especially the owner of the system / computer who would find this tool useful. It can display hardware and usage information for multiple systems/nodes. It entails lot's of useful information. The project was built using Bash script, PSQL and technologies like Docker and git Version control.

Database & Tables
```

Host_info Table

id :    Unique id for the node , auto incremented 
hostname : Domain name VARCHAR in the databse 
cpu_number : Nunber of CPU , INT in the database
cpu_architecture: The architecture type of the CPU 
cpu_model: model name or description of the CPU.
cpu_mhz: clock speed of the CPU in megahertz (MHz)
L2_cache:  size of the Level 2 (L2) cache memory of the CPU in (kb)
total_meme: total amount of memory (RAM) installed on the node (MB)
timestamp : the timestamp indicating when the data was collected or recorded

Host_usage Table

timestamp: the timestamp indicating when the data was collected or recorded
host_id : Indictoing which computer it is talking about from host_info
memory_free : amount of available memory (RAM) on the node(MB)
cpu_idle :  percentage of time the CPU spends idle, 
cpu_kernel : percentage of CPU time spent executing kernel-space processes 
disk_io : number of disk input/output (I/O) operations currently in progress
disk_available : amount of available disk space on the node's storage device(MB)

```
# Script Descriptions

psql_docker.sh - Set up a psql instance using docker
ddl.sql - The DDL script defines the schema for two tables: host_info and host_usage.

host_info.sh - Insert real time hardware specs values to table host_info
host__usage.sh - Insert real time usage hardware specs values to table host_info 


# Usage

for psl_docker.sh

**Create Psql with docker**
./scripts/psql_docker.sh create db_username db_password


**Initialize the tables**
psql -h localhost -U postgres -d host_agent -f sql/ddl.sql

for host_info.sh


# Improvements

