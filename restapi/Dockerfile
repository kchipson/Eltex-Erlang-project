FROM erlang:25

#Redefining the working directory
WORKDIR /project


COPY . .

RUN apt-get update
RUN apt-get install -y vim


RUN rebar3 compile

CMD ["rebar3", "shell"]