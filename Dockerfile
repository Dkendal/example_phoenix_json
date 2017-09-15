FROM bitwalker/alpine-erlang:19.3

ENV HOME=/opt/app/ TERM=xterm

# Install Elixir and basic build dependencies
RUN \
    echo "@edge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk --update upgrade musl && \
    apk --no-cache add \
      git make g++ \
      elixir@edge=1.5.1-r0 && \
    rm -rf /var/cache/apk/*

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /opt/app

ENV MIX_ENV=prod

# Cache elixir deps
RUN mkdir config
COPY config/* config/
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY . .

RUN mix release --env=prod --verbose

EXPOSE 4000
ENV PORT=4000 MIX_ENV=prod REPLACE_OS_VARS=true SHELL=/bin/sh

ADD elixir_hello_json.tar.gz ./
RUN chown -R default ./releases

USER default

ENTRYPOINT ["/opt/app/bin/elixir_hello_json"]
