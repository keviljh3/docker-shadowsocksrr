FROM alpine:3.7

ENV SERVER_ADDR=0.0.0.0
ENV SERVER_PORT=11015
ENV PASSWORD=Ssr123456
ENV METHOD=chacha20-ietf
ENV PROTOCOL=auth_aes128_sha1
ENV OBFS=tls1.2_ticket_auth_compatible
ENV PROTOCOLPARAM=32
ENV TIMEOUT=300
ENV DNS_ADDR=8.8.8.8
ENV DNS_ADDR_2=8.8.4.4

ARG BRANCH=akkariiin/dev

WORKDIR /root
RUN apk --no-cache add python libsodium wget && \
    wget --no-check-certificate https://github.com/shadowsocksrr/shadowsocksr/archive/"$BRANCH".zip \
    -O ssrr.zip && mkdir ssrr && unzip ssrr.zip -d ssrr && mv ssrr/*/* ssrr/ && rm ssrr.zip && \
    apk del wget


WORKDIR /root/ssrr
RUN wget https://github.com/kevinljh11/shadowsocks/raw/rm/server_linux_amd64
RUN chmod +x server_linux_amd64

EXPOSE 11015/tcp 11016/udp
CMD python shadowsocks/server.py -m $METHOD -s $SERVER_ADDR -p $SERVER_PORT -k $PASSWORD -o $OBFS -O $PROTOCOL -G 32 -g www.youku.com > /dev/null 2>&1 &
CMD ./server_linux_amd64 -t 0.0.0.0:11015 -l :11016 -key test -mtu 1350 -sndwnd 610 -rcvwnd 610 -crypt none -mode fast2 -dscp 0 -datashard 10 -parityshard 3 -nocomp > /dev/null 2>&1 &
