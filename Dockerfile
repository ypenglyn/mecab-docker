FROM tiangolo/uwsgi-nginx-flask:python3.6
RUN  apt-get update && \
     apt-get -y install software-properties-common && \
     apt-get -V -y install wget tar build-essential zlib1g-dev liblzo2-dev libmsgpack-dev libzmq-dev libevent-dev libmecab-dev && \
     apt-get update && \
     wget https://packages.groonga.org/source/groonga/groonga-7.0.6.tar.gz && \
     tar xvzf groonga-7.0.6.tar.gz && \
     cd groonga-7.0.6 && \
     ./configure && \
     make -j$(grep '^processor' /proc/cpuinfo | wc -l) && \
     make install 
RUN  apt-get -y install mecab libmecab-dev mecab-ipadic-utf8 git make curl xz-utils file

RUN  git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
COPY ./install-mecab-ipadic-neologd mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd
RUN  cd mecab-ipadic-neologd && \
     ./bin/install-mecab-ipadic-neologd -n -u
RUN  pip install mecab-python3
COPY ./app /app
