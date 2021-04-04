FROM julia:1.5

RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
    build-essential \
    tmux \
    unzip \
    cmake \
    && apt-get clean

RUN mkdir -p /app
WORKDIR /app
COPY ./app/ /app
RUN julia --color=yes --depwarn=no -q -i -- deps.jl
RUN bin/compile_pkg

EXPOSE 80

CMD ["/app/bin/server"]
