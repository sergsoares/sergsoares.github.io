FROM golang:1.20.2

ARG HUGO_VERSION=v0.111.2
RUN go install github.com/gohugoio/hugo@${HUGO_VERSION}

WORKDIR /app
RUN git clone https://github.com/sergsoares/sergsoares.github.io.git 

WORKDIR /app/sergsoares.github.io

CMD ["hugo", "server"]