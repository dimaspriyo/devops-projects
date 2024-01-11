#FROM ubuntu
FROM alpine

RUN apk add curl 

COPY . /
RUN ls -l
RUN cat configure-grafana.sh
RUN chmod +x configure-grafana.sh
CMD configure-grafana.sh

CMD ["tail", "-f", "/dev/null"]
