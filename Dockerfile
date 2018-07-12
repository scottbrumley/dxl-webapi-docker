FROM alpine


RUN apk update

#RUN apk add --no-cache python3 \
#    && apk add curl \
#    && apk add git \
#    && apk add gcc \
#    && apk add py-setuptools \
#    && apk add py-pip3 \
#    && rm -rf /var/cache/apk/*

#    apk add python2-dev && \

RUN apk add --no-cache python3 && \
    apk add bash && \
    apk add curl && \
    apk add git && \
    apk add gcc && \
    apk add python3-dev && \
    apk add musl-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

#RUN apk add --no-cache curl python pkgconfig python-dev openssl-dev libffi-dev musl-dev make gcc
#RUN pip install setuptools

# Set the lang, you can also specify it as as environment variable through docker-compose.yml
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8


# Install PyMISP 
#RUN git clone https://github.com/MISP/PyMISP.git
#RUN cd PyMISP/; python setup.py install

# Install Requests
RUN pip3 install requests

### Python Common
RUN echo "Installing Python Common"
RUN pip3 install common
RUN pip3 install Flask
RUN pip3 install flask-socketio
RUN pip3 install eventlet

RUN python --version

# Install OpenDXL Python client
#RUN pip install cffi
#RUN mkdir -p /config
RUN git clone https://github.com/opendxl/opendxl-client-python.git
RUN cd opendxl-client-python/; python setup.py install

# Install OpenDXL bootstrap
RUN git clone https://github.com/opendxl/opendxl-bootstrap-python.git
RUN cd opendxl-bootstrap-python/;python setup.py install

## Install OpenDXL TIE Client
RUN echo "Installing Open DXL TIE Client"
RUN git clone https://github.com/opendxl/opendxl-tie-client-python.git 
RUN cd opendxl-tie-client-python && python setup.py install

# Install OpenDXL MAR SDK
#RUN git clone https://github.com/opendxl/opendxl-mar-client-python.git
#RUN cd opendxl-mar-client-python/; python setup.py install

ADD config/brokercerts.crt /config/brokercerts.crt
ADD config/client.crt /config/client.crt
ADD config/client.key /config/client.key

# Install MISP MAR script
RUN git clone https://github.com/scottbrumley/opendxl_web_api.git


## Clean UP
#RUN apk del --no-cache git gcc linux-headers musl-dev

## Setup Flask Environment
ENV FLASK_APP=/opendxl_web_api/opendxl_web_api.py

WORKDIR /opendxl_web_api
ADD config/dxlclient.config dxlclient.config
CMD ["scripts/service.sh","debug"]

