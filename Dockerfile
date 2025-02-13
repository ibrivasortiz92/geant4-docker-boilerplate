FROM gcc:latest

RUN apt update
RUN apt install build-essential checkinstall zlib1g-dev \
    libssl-dev -y

ARG MY_CMAKE=cmake-3.30.5

COPY ./src/${MY_CMAKE}.tar.gz /

RUN tar -zxvf ${MY_CMAKE}.tar.gz
RUN cd ${MY_CMAKE} && ./bootstrap && make install
RUN rm -rf ${MY_CMAKE}.tar.gz && rm -rf ${MY_CMAKE}

ARG MY_GEANT4=geant4-v11.2.2

COPY ./src/${MY_GEANT4}.tar.gz /home/${MY_GEANT4}.tar.gz
COPY ./src/datasets /home/datasets

RUN cd /home/datasets && \
for file in *.tar.gz; do \
    tar -zxvf "$file" && rm "$file"; \
done
RUN cd /home && tar -zxvf ${MY_GEANT4}.tar.gz
RUN rm /home/${MY_GEANT4}.tar.gz
RUN mkdir /home/geant4-build

RUN cd /home/geant4-build && cmake \
-DGEANT4_INSTALL_DATADIR=/home/datasets \
-DCMAKE_INSTALL_PREFIX=/home/geant4-install \ 
/home/${MY_GEANT4}
RUN cd /home/geant4-build && make && make install

ENV PATH="/home/geant4-install/bin:${PATH}"

WORKDIR /home/apps
