# RedDrum Httpd Configs 

## About
RedDrum implements the Redfish API but generally relies on an httpd service to intercept external Redfish
API requests and forward the request to the Flask-based RedDrum-Frontend service.

This allows other services besides Redfish to share port 80/443 and allows a common HTTPS/SSL processing.

This repo has documentation and setup scripts for how to configure the common HTTPDs (eg Apache or NGNX) 
to integrate with the RedDrum-Frontend.

There is a sub-directores for each the common HTTPD Services that has bee used with RedDrum.
  - httpd  --- the in-use Apache-based httpd distriubuted with Centos
  - NGNX   --- coming soon
  - Gevent --- coming soon


## General Reverse Proxy Implementation
The easiest way to integrate a standard httpd with RedDrum is to implement a "Reverse Proxy".
* The RedDrum-Frontend listens on localhost port 5001 using http for Redfish request, and provides all of the authentication.
* The httpd then simply implements a reverse proxy for over to the Redfish Service for any incoming http requests that have a URI starting with `/redfish`.   
  * A reverse proxy is implemented for incoming traffic on both port 80 or port 443 that start with URI: `/redfish`
  * This causes the httpd to implement the SSL processing completely.
  * It then reverse proxies the request over to the RedDrum-Frontend Flask servicve at `/127.0.0.1:5001/redfish/<the uri>`


## Using WSGI interface
It is possible to interface the RedDrum-Frontend flask service to the httpd using WSGI although.
Support for this will be added.

## Using the builtin Flask httpd for Testing
Note that for testing the RedDrum-Frontend, or testing simulations w/o SSL, it is common to simply use
the http server that is built-in to Flask.
* The RedDrum-Frontend starts this builtin httpd on port 5001 by default and uses this as the target of the 
httpd reverse proxy as described above.
* However, the port and IP address can actually be specified and Flask can listen on port 80 of a external IP address.
* This can be specified using the `--Port=<port> --Host=<hostIp> ` options to the ***main*** script used to start
  the RedDrum Service   (RedDrumSimulator.py for the RedDrum-Simulator,   RedDrumMain.py for the RedDrum-OpenBMC service)
* However, for real implemenations or full-capability simulators that need HTTPS, one of the above revers proxy
  configurations is recommended to implement HTTPS/SSL and to allow other web services to run along side with Redfish.

