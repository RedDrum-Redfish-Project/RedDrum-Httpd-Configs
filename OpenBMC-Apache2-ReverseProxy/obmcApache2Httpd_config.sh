
# Copyright Notice:
#    Copyright 2018 Dell, Inc. All rights reserved.
#    License: BSD License.  For full license text see link: https://github.com/RedDrum-Redfish-Project/RedDrum-Httpd-Configs/LICENSE.txt

#
# Apache httpd config  script:
# This script creates self-signed certificates, and sets up working httpd.conf and ssl.conf files used by httpd for centos 7.1
#

# copy the httpd config files
   cp /usr/lib/python3.5/site-packages/OpenBMC-Apache2-ReverseProxy/httpd.conf /etc/apache2/httpd.conf
   cp /usr/lib/python3.5/site-packages/OpenBMC-Apache2-ReverseProxy/ssl.conf /etc/apache2/conf.d/httpd-ssl.conf

# create the HTTPS SSL keys and certs
   # Step-0: set RMSSLCERTS to path to certs we are creating
   mkdir -p /tmp/sslCerts
   SSLCERTS=/tmp/sslCerts

   # Step-1: Generagte private ssl key
   #   this creates the ca.key file
   openssl genrsa -out ${SSLCERTS}/ca.key 2048

   # Step-2: Generate CSR
   #   this creates the ca.csr file from the ca.key
   openssl req -new -key ${SSLCERTS}/ca.key -out ${SSLCERTS}/ca.csr \
      -subj "/C=US/ST=TX/L=Round Rock/O=Dell Inc./OU=ESI/CN=OpenBMCx"

   # Step-3: Generate Self Signed Key
   #   this creates the ca.crt file from the ca.csr and ca.key
   openssl x509 -req -days 365 -in ${SSLCERTS}/ca.csr -signkey ${SSLCERTS}/ca.key -out ${SSLCERTS}/ca.crt

# copy ssl certs/keys to native location Apache uses
   #   Note: the /etc/pki/tls/certs/localhost.crt and .../private/localhost.key files
   #     are created by the post install of mod_ssl and should already be there.
   #     Otherwise, then can be created similarly
   cp ${SSLCERTS}/ca.crt   /etc/apache2/ca.crt
   cp ${SSLCERTS}/ca.key   /etc/apache2/ca.key
   cp ${SSLCERTS}/ca.csr   /etc/apache2/ca.csr

# start apache server
   httpd -k start

# complete
   echo "httpd config complete "
