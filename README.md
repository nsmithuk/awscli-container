# awscli-container

Dockerfile for creating a (small as possible) container with the AWS CLI v2 install.

Version 2 of the AWS CLI depends on `glibc`, thus no Alpine, and on `libdl.so.2`, thus no busybox:glibc.
Any other reputable suggestions most welcome to get this even smaller.
