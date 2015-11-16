FROM nginx:1.9.5

#WORKDIR /tmp
#RUN apt-get update && apt-get install -y wget unzip
#RUN wget https://releases.hashicorp.com/consul-template/0.11.1/consul-template_0.11.1_linux_amd64.zip
#RUN unzip consul-template_0.11.1_linux_amd64.zip

ADD service.ctmpl /etc/nginx/conf.d/default.conf
#ADD start.sh /bin/start.sh
#RUN chmod a+x /bin/start.sh

#CMD ["/bin/start.sh"]

EXPOSE 80
