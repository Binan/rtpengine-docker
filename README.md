
# rtpengine-docker
Running SipWise RTPEngine In a Docker Container. For scalability and reusability, run the rtpengine alone in separate container.

*** This work is under construction. Do Not Use it. - Exporting the ports is remained + update the Readme about how to run it.


	- Clone the repository: "git clone https://github.com/Binan/rtpengine-docker.git"
	- Enter the folder "rtpengine-docker": "cd rtpengine-docker"
	- Update the configuration file "rtpengine-conf" to reflect your wanted configuration for RTPEngine.
	- Update the "EXPOSE" statement in the Dockerfile to expose the ports that are configured in the "rtpengine-conf".
