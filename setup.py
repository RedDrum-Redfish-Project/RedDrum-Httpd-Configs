from setuptools import setup

setup(name='RedDrum-Httpd-Configs',
      version='0.9.5',
      description='RedDrum Redfish Service Apache Config',
      author='RedDrum-Redfish-Project / Paul Vancil, Dell ESI',
      author_email='redDrumRedfishProject@gmail.com',
      license='BSD License',
      classifiers=[
          'Development Status :: 4 - Beta',
          'License :: OSI Approved :: BSD License',
          'Programming Language :: Python :: 3.4',
          'Topic :: Software Development :: Libraries :: Python Modules',
          'Topic :: Software Development :: Libraries :: Embedded Systems',
          'Topic :: Communications'
      ],
      keywords='Redfish RedDrum SPMF OpenBMC ',
      url='https://github.com/RedDrum-Redfish-Project/RedDrum-Httpd-Configs',
      download_url='https://github.com/RedDrum-Redfish-Project/RedDrum-Httpd-Configs/archive/0.9.5.tar.gz',
      packages=['OpenBMC-Apache2-ReverseProxy'],
      scripts=['OpenBMC-Apache2-ReverseProxy/obmcApache2Httpd_config.sh'],
      install_requires=[],
      include_package_data = True,	
      package_data={'':['*.conf', '*.sh', 'sslCerts/*']}
)
