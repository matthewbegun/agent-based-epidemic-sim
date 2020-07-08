# This file defines a docker container that can be used to build and test the simulator.
# If your current directory is the one containing this Dockerfile you can run:
# docker build -t "abesim" .
# docker run -t --rm \
#   -v $PWD:/root/agent_based_epidemic_sim  \
#   -v /tmp/bazel_output:/tmp/bazel_output \
#   abesim bazel test agent_based_epidemic_sim/...

FROM ubuntu:20.04

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install clang curl gnupg
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN apt-get -y update
RUN apt-get -y install bazel
RUN printf "startup --output_user_root=/tmp/bazel_output\n" > /root/.bazelrc

WORKDIR /root/agent_based_epidemic_sim
