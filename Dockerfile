FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y wget perl-doc pandoc pandoc-citeproc && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/texlive/texdir/bin/aarch64-linux:/opt/texlive/texdir/bin/x86_64-linux:${PATH}"
COPY latex/texlive.profile /tmp/texlive.profile
copy latex/install-texlive.sh /tmp/install-texlive.sh
WORKDIR /tmp

RUN /tmp/install-texlive.sh

COPY latex/install-tex-packages.sh /tmp/install-tex-packages.sh
RUN /tmp/install-tex-packages.sh

RUN rm -f /tmp/texlive.profile \
          /tmp/install-texlive.sh \
          /tmp/install-tex-packages.sh

RUN tlmgr install apa7 scalerel threeparttable endfloat biblatex-apa

WORKDIR /data
