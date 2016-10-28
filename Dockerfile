FROM centos:7
FROM python:2.7
FROM java:openjdk-7-jdk
MAINTAINER Daniel Davison <sircapsalot@gmail.com>

#  Version
ENV   SOAPUI_VERSION  5.2.1

COPY entry_point.sh /opt/bin/entry_point.sh
COPY server.py /opt/bin/server.py
COPY server_index.html /opt/bin/server_index.html
COPY SoapUI-5.2.1-linux-bin.tar.gz /opt/SoapUI-5.2.1-linux-bin.tar.gz

RUN chmod +x /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/server.py

# Download and unarchive SoapUI
RUN mkdir -p /opt &&\
    curl  http://cdn01.downloads.smartbear.com/soapui/${SOAPUI_VERSION}/SoapUI-${SOAPUI_VERSION}-linux-bin.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
    ln -s /opt/SoapUI-${SOAPUI_VERSION} /opt/SoapUI

COPY soapui-settings.xml /opt/SoapUI-5.2.1/.

# Set environment
ENV PATH ${PATH}:/opt/SoapUI/bin

EXPOSE 3000
CMD ["/opt/bin/entry_point.sh"]
