
# Install layer
FROM node:21 AS install

WORKDIR /frontend

COPY package.json package-lock.json .
RUN npm install



# Build layer
FROM install AS build

WORKDIR /frontend

COPY ./ ./

RUN npm run build


# Release layer
FROM node:21 AS release

WORKDIR /frontend

RUN npm install -g http-server

COPY --from=build /frontend/dist /frontend

ARG FRONTEND_PORT
ENV FRONTEND_PORT=$FRONTEND_PORT

ENTRYPOINT [ "sh", "-c", "http-server ./ -p $FRONTEND_PORT" ]
