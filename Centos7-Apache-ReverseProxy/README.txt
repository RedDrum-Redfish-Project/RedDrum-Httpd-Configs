--Apache-ReverseProxy
    -- This is the httpd config used by the Dell DSS9000 Rackmanager in production, and has been
       tested for OpenBMC
    -- This is the httpd server distributed with Centos 7 and RHEL based on Apache
    -- The Apache httpd implements a virtualHost for both http and https
    -- Apache handles all ssl and http processing and REVERSE PROXIES all /redfish/v1[/] traffic 
       to the builtin httpd inside the RedDrum-Frontend FlaskApp.
    -- Two conf files:  httpd.conf and ssl.conf must be setup to implement this.
    -- See the ./sslCerts/README_howto_create_certs file for description re how to generate the ssl certs
    -- A bash script is here to show example requirement for disabling SElinux bouls and generating certs
    -- Note that the reverse proxy also generates a custom header to tell the RedDrum-Frontend whether the 
       request originated on http or https. This is used by some of the Frontend Auth config processing.
    -- Performance measured with this configuration on Dss9000 Rackmanager running Centos7.1 on an Atom CPU 
       is awesome---Apache handles all of the SSL processing with very high performnace
       --In this config, Apache is running the ssl processing and socket handling multi-threaded and managing 
         four worker threads to talk to the RedDrum-Frontend FlaskApp.
       --Even though the Flask app is single threaded, a lot of the SSL processing is thus done multi-threaded,
         and performance for multithreaded clients is faster
