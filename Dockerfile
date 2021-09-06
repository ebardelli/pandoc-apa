FROM pandoc/latex

RUN tlmgr update --self && tlmgr install apa7 scalerel threeparttable endfloat biblatex-apa
