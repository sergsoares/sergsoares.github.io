FROM golang:1.20.2-alpine3.17

RUN go install github.com/gohugoio/hugo@latest

WORKDIR /app
RUN git clone https://github.com/sergsoares/sergsoares.github.io.git 

WORKDIR /app/sergsoares.github.io

CMD ["hugo", "server"]