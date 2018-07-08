 OpenDXL Web API on Docker
===========================

This project uses the [OpenDXL Web API](https://github.com/scottbrumley/opendxl_web_api) GitHub project to create a Docker container.

Configuration
=============
__VARS File:__ 
 1.   NAME= Running Container Name
 2.   LOCATION= Stored Container Name and Location

__container.sh:__ Parameters Follow:
 1.   **dxlclient** - Install the DXLClient Locally (For Ubuntu 16.04 Systems)
 2.   **configclient** - Build Client Certficates to speak with DXL brokers
 3.   **build** - Build the OpenDXL Web API Docker container
 4.   **remove** - Stop and remove the running docker container for this project
 5.   **run** - Run the OpenDXL Web API container
 ..5. Add an argument to change the authentication token (i.e. run mysecrettoken).  This is used in the url as token=mysecrettoken.
 6.   **purge-all** - This will remove all containers running and stored on the local system
 7.   **purge** - Remove all containers and images that are not running
 
 