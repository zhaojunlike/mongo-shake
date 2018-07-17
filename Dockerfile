FROM golang:1.9.7-alpine3.7

# run to install git
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add git bash gcc --no-cache && go get -u -v github.com/kardianos/govendor


#workdir can change to ```git clone ...```
WORKDIR /go/src/app
COPY . .

#install vendro
RUN cd src/vendor/ && govendor sync && cd ../../
RUN /bin/sh ./build.sh

##
#RUN go install -v ./...
# ./bin/collector -conf=conf/collector.conf
CMD ['/go/src/app/bin/collector']