FROM debian:10

ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yy --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        libbz2-dev \
        libffi-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        liblzma-dev \
        libssl-dev \
        llvm \
        make \
        netbase \
        pkg-config \
        tk-dev \
        wget \
        xz-utils \
        zlib1g-dev \
        redis-server \
        libcurl4-openssl-dev \
        libsnappy-dev \
        default-mysql-server \
        default-libmysqlclient-dev \
        libpq-dev \
        swig \
        libsasl2-dev \
        unixodbc-dev \
        sasl2-bin \
        libgnutls28-dev \
        libsasl2-2 \
        libsasl2-modules \
        libblas3 \
        libsasl2-modules-gssapi-mit \
        python-numpy \
        python-numexpr \
        default-libmysqlclient-dev \
        sudo \
        libxml2-dev \
        libxmlsec1-dev \
        r-base-core \
        r-recommended \
        r-base \
        r-base-dev \
        libblas-dev \
        liblapack3 \
        liblapack-dev \
        cl-cffi \
        python-cffi \
        freetds-dev \
        freetds-bin \
        tdsodbc \
        libgeos-dev \
        krb5-user \
        libev4 \
        libev-dev \
        python-dbg \
        libldap2-dev \
        cmake \
        libkrb5-dev \
        python-tk \
        whois \
        python-dev \
        octave \
        tesseract-ocr \
        libjq-dev \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Grab pyenv
RUN git clone https://github.com/yyuu/pyenv.git /.pyenv

# Setup the PYENV_ROOT and update the path
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Install all the pythons!
RUN pyenv install 3.6.4

# Give the shell access to all the pythons
RUN pyenv global  3.6.4

WORKDIR /tmp/project

#Put pip conf into place
ADD pip.conf /etc/pip.conf
#ADD $HOME/.pip/pip.conf /etc/pip.conf

RUN pip install -U pip
RUN pip install -U setuptools
RUN pip install Fabric3
RUN pip install tox
ADD . .

CMD tox -e test