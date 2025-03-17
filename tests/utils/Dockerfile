FROM debian:sid-slim

RUN apt-get update \
    && apt-get install -y -qq fish make curl git \
    && groupadd --gid 1000 tide \
    && useradd --create-home --gid 1000 --shell /usr/bin/fish --uid 1000 tide \
    && mkdir --parents "/home/tide/{src/tide,.config/fish/conf.d}" \
    && chown --recursive tide:tide "/home/tide"

COPY --link --chown=1000:1000 . /home/tide/src/tide

WORKDIR /home/tide/src/tide
USER tide
ENTRYPOINT ["/usr/bin/fish", "--login"]
RUN make testsetup
