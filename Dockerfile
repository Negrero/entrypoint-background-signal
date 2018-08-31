FROM ubuntu
COPY entrypoint.sh /entrypoint.sh
COPY background-signal.sh /background-signal.sh
RUN  apt-get update && apt-get install -y --force-yes apache2 && chmod +x /entrypoint.sh && \
        chmod +x background-signal.sh    
EXPOSE 80 443
VOLUME [ "/var/www", "/var/log/apache2", "/etc/apache2" ]
ENTRYPOINT ["/background-signal.sh"]
