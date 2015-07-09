# synthesijer_ip
##Takeshi Ohkawa

Hardwired IPs written in Java for synthesijer.
These IPs are mainly intended to be used in Xilinx Zynq platform as AXI-IPs.

## Setup Synthesijer environment
Prerequisites
 - Linux environment
 - Oracle JDK8

Use the setup script:

    wget http://synthesijer.github.io/web/dl/setup_20150608.sh
    sh setup_20150608.sh
    source /home/YOURNAME/synthesijer/synthesijer_env.sh
    
For more information about setting up Synthesijer environment, follow the instruction below:

- https://github.com/synthesijer

## How to build
First, clone this project into your system:

    git clone https://github.com/ohkawatks/synthesijer_ip.git

To build IP, cd into the ip project dir and make. For example, in the case of building "gray" (Gray filter),

    cd gray
    make
 
Then, you can find AXIHP_GRAY_v1_0 dir in the current dir, and AXIHP_GRAY_v1_0.tgz in the ../ip dir.

To make tarball,

    make tar

Then, you can find gray.tgz in the ../tgz dir.

## How to use the IP
After the build, you will find IP dir looks like below:

- AXIHP_GRAY_v1_0

Copy the entire IP dir into your IP repository for Xilinx Vivado, and add reference in the repository setting.

## License
The IP is distributed under the modified BSD license.
