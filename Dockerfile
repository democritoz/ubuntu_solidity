FROM ubuntu:latest
ENV LANG C.UTF-8


# apt-get Install package
RUN apt update -y && apt upgrade -y
RUN apt-get install -y \
      sudo \
      vim \
      curl \
      wget \
      git \
      net-tools


# 작업 디렉토리 생성
RUN mkdir /workspace


# 이후 도커 컨테이너에서 명령들이 실행될 위치(디렉토리)를 /workspace 로 지정한다.
WORKDIR /workspace


# Install NodeJS Current 버전 설치
RUN sudo curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
RUN sudo apt-get install -y nodejs


# Install truffle
RUN npm install -g truffle
RUN mkdir /workspace/truffle
WORKDIR /workspace/truffle
RUN truffle init


# Install ganache
WORKDIR /workspace
RUN npm install -g ganache



# run ganache
RUN mkdir /workspace/ganache
RUN mkdir /workspace/ganache/log
WORKDIR /workspace/ganache
COPY run_ganache.sh run_ganache.sh
ENTRYPOINT ["/workspace/ganache/run_ganache.sh"]


