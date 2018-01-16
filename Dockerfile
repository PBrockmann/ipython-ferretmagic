
#====================================================================================
FROM yuxiaorui/python-2.7-slim

#====================================================================================
RUN pip install --no-cache-dir notebook==5.*

#====================================================================================
ENV NB_USER agentk
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

#====================================================================================
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

#====================================================================================
# pyferret installation

ADD https://github.com/NOAA-PMEL/PyFerret/releases/download/v7.3/pyferret-7.3-RHEL7-64.tar.gz /opt
ADD ftp://ftp.pmel.noaa.gov/ferret/pub/data/fer_dsets.tar.gz /opt
WORKDIR /opt
RUN tar xvfz pyferret-7.3-RHEL7-64.tar.gz
RUN tar xvfz fer_dsets.tar.gz


#====================================================================================
# fast installation

WORKDIR /opt
RUN git clone https://github.com/PBrockmann/fast
