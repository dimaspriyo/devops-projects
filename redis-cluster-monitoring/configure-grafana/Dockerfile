#FROM ubuntu
FROM alpine

RUN apk add curl 


# RUN apt update --yes
# RUN apt install curl --yes

# RUN curl -X POST -H 'Content-Type: application/json' -d ' { "name":"api-key", "role":"Admin", "secondsToLive":86400 }' http://admin:admin@grafana:3000/api/auth/keys
# RUN curl -X POST -H 'Content-Type: application/json' -d ' { "id":null, "orgId":1, "folderId":null, "overwrite":false, "dashboard":{ "id":null, "uid":null, "title":"Sample Dashboard", "timezone":"browser", "schemaVersion":27, "version":0, "time":{"from":"now-6h","to":"now"}, "refresh":"10s", "panels":[], "annotations":{ "list":[] }, "hideControls":false }, "folderId":0, "overwrite":false }' http://admin:admin@grafana:3000/api/dashboards/db

# CMD ["tail", "-f", "/dev/null"]

COPY . /
RUN ls -l
RUN cat configure-grafana.sh
# RUN readlink -f /configure-grafana/configure-grafana.sh
RUN chmod +x configure-grafana.sh
CMD configure-grafana.sh

# ENTRYPOINT ["sh"," configure-grafana.sh"]
CMD ["tail", "-f", "/dev/null"]
# CMD ["sh", "-x", "/entrypoint.sh"]