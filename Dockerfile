FROM tomcat:jre8
ENV TERM=xterm

COPY server.xml /usr/local/tomcat/conf/
COPY web.xml /usr/local/tomcat/conf/

RUN mkdir -p /usr/local/tomcat/lib/org/apache/catalina/util
COPY ServerInfo.properties /usr/local/tomcat/lib/org/apache/catalina/util/ServerInfo.properties

RUN rm -rf /usr/local/tomcat/webapps/* ; \
    rm -rf /usr/local/tomcat/work/Catalina/localhost/* ; \
    rm -rf /usr/local/tomcat/conf/Catalina/localhost/*

HEALTHCHECK --interval=1m --timeout=3s CMD curl -f http://localhost/LoginWebApp || exit 1

RUN chmod -R 400 /usr/local/tomcat/conf

COPY target/LoginWebApp.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]
