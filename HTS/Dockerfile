FROM ubuntu:20.04

# for non-interactive tcl install
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

RUN apt update
RUN apt install wget curl  git autoconf tcl python python-lxml -y
RUN apt-get install make gcc zlib1g-dev zip unzip openssl libssl-dev libpq-dev postgresql-client locales -y

WORKDIR /usr/local/src
RUN git clone https://github.com/gustafn/install-ns
WORKDIR /usr/local/src/install-ns
RUN bash install-ns.sh build

# RUN sed -i 's/\s\s\s\s#ns_param\s\s\saddress\s\s0.0.0.0/    ns_param   address  0.0.0.0/g' /usr/local/ns/conf/nsd-config.tcl

COPY ./hugtakasafn-naviserver-container.tcl /usr/local/ns/conf/hugtakasafn-naviserver-container.tcl

ADD . /home/nsadmin/web/hugtakasafn
RUN mkdir --parents /home/nsadmin/web/hugtakasafn/stjrWebUITemplate/product
RUN bash /home/nsadmin/web/hugtakasafn/stjrWebUITemplate/prepareLayoutADPIncludes.sh

CMD /usr/local/ns/bin/nsd -f -u nsadmin -g nsadmin -t /usr/local/ns/conf/hugtakasafn-naviserver-container.tcl
