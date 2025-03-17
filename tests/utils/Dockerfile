FROM debian:sid-slim

RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends fish make curl git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd --gid 1000 tide \
    && useradd --create-home --gid 1000 --shell /usr/bin/fish --uid 1000 tide \
    && mkdir --parents "/home/tide/{src/tide,.config/fish/conf.d}" \
    && chown --recursive tide:tide "/home/tide" # hadolint ignore=DL3008

COPY --link --chown=1000:1000 . /home/tide/src/tide

HEALTHCHECK NONE
WORKDIR /home/tide/src/tide
USER tide
ENTRYPOINT ["/usr/bin/fish", "--login"]
RUN make testsetup
