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
 1.   **cacert** - Create CA certificate
 2.   **clientcert** - Create Client Cert
 2.   **configclient** - Build Client Certficates to speak with DXL brokers
      2. Add an argument to set the PEM password for the client certificate (i.e. configclient mypempassword).
 3.   **build** - Build the OpenDXL Web API Docker container
 4.   **remove** - Stop and remove the running docker container for this project
 5.   **run** - Run the OpenDXL Web API container
      5. Add an argument to change the authentication token (i.e. run mysecrettoken).  This is used in the url as token=mysecrettoken.
 6.   **purge-all** - This will remove all containers running and stored on the local system
 7.   **purge** - Remove all containers and images that are not running
 
config Directory
================ 
* After **./container.sh configclient** runs the following files will be created in the config directory:
   * ca.crt  
   * ca.key  
   * ca.pem  
   * ca.srl  
   * client.crt  
   * client.csr  
   * client.key  

How to Run
==========
1. Run ./container.sh configclient <PEM password of choice>
2. Import client.crt & ca.crt into ePO (Forcing a Wake Up of Agents on the brokers to transfer the certs)
3. Export the brokerlist
4. Export the brokercerts
5. Add the contents of the brokerlist.properties to the end of the dxlclient.config
6. Add path of the certs inside the container to the top of the dxlclient.config
7. Write the dxlclient.config to the config/ directory
8. Run ./container.sh build
9. Run ./container.sh run
