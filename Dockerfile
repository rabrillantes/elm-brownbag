FROM node
RUN npm install -g elm@0.17 && npm cache clear

RUN mkdir /src
WORKDIR /src
EXPOSE 8000

ENTRYPOINT ["elm"]

