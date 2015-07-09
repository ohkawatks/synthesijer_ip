# synthesijer_ip
Copyright 2015 Takeshi Ohkawa

Hardwired IPs written in Java for synthesijer 

## Setup 
Setup Synthesijer environment following the instruction below:

- https://github.com/synthesijer

## How to build
To build IP, cd into the ip project dir and make. For example, in the case of building "gray" (Gray filter),

    % cd gray
    % make
 
To make tarball,

    % make tar

## How to use the IP
After the build, you will find IP dir looks like below:

- AXIHP_GRAY_v1_0

Copy the entire IP dir into your IP repository for Xilinx Vivado, and add reference in the repository setting.
