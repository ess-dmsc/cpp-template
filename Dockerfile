FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# For the reverse proxy so stuff like pip and conan can work
ARG http_proxy
ARG https_proxy

# Install packages
ENV BUILD_PACKAGES "build-essential git python python-pip cmake python-setuptools"

RUN apt-get update -y && \
    apt-get --no-install-recommends -y install $BUILD_PACKAGES && \
    apt-get -y autoremove && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

RUN pip install conan==1.8.2
# Force conan to create .conan directory and profile
RUN conan profile new default

# Replace the default profile and remotes with the ones from our Ubuntu build node
ADD "https://raw.githubusercontent.com/ess-dmsc/docker-ubuntu18.04-build-node/master/files/registry.txt" "/root/.conan/registry.txt"
ADD "https://raw.githubusercontent.com/ess-dmsc/docker-ubuntu18.04-build-node/master/files/default_profile" "/root/.conan/profiles/default"

# Replace BUILD_DIR with your project name directory
RUN mkdir BUILD_DIR

# PROJECT_SRC is the project's relative source directory on the host machine
COPY ./conan ../PROJECT_SRC/conan
RUN cd BUILD_DIR && conan install --build=outdated ../PROJECT_SRC/conan/conanfile.txt
COPY ./src ../PROJECT_SRC/src
COPY ./CMakeLists.txt ../PROJECT_SRC/CMakeLists.txt
COPY ./cmake ../PROJECT_SRC/cmake

RUN cd BUILD_DIR && cmake -DCONAN="MANUAL" ../PROJECT_SRC && make -j8

COPY docker_launch.sh 

CMD ["./docker_launch.sh"]
