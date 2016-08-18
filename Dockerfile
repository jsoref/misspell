FROM golang:1.7.0-alpine
MAINTAINER https://github.com/client9/misspell

# cache buster
RUN echo 1457336153

# git is only used for coveralls reporting
RUN apk add --no-cache git make

# these are my standard testing / linting tools
RUN /bin/true \
    && go get -u github.com/golang/lint/golint \
    && go get -u golang.org/x/tools/cmd/goimports \
    && go get -u golang.org/x/tools/cmd/vet \
    && go get -u github.com/alecthomas/gometalinter \
    && go get -u github.com/mattn/goveralls \
    && rm -rf /go/src /go/pkg
`
# This creates a testing image for `misspell`
#
# * Alpine Linux
# * Golang
# * SCOWL word list
#
# Downloads
#  http://wordlist.aspell.net/dicts/
#  --> http://app.aspell.net/create
#
# cache buster
RUN echo 1457339114

# use en_US large size
# use regular size for others
ENV SOURCE_US_BIG http://app.aspell.net/create?max_size=70&spelling=US&max_variant=2&diacritic=both&special=hacker&special=roman-numerals&download=wordlist&encoding=utf-8&format=inline

# should be able tell difference between English variations using this
ENV SOURCE_US http://app.aspell.net/create?max_size=60&spelling=US&max_variant=1&diacritic=both&download=wordlist&encoding=utf-8&format=inline
ENV SOURCE_GB_ISE http://app.aspell.net/create?max_size=60&spelling=GBs&max_variant=2&diacritic=both&download=wordlist&encoding=utf-8&format=inline
ENV SOURCE_GB_IZE http://app.aspell.net/create?max_size=60&spelling=GBz&max_variant=2&diacritic=both&download=wordlist&encoding=utf-8&format=inline
ENV SOURCE_CA http://app.aspell.net/create?max_size=60&spelling=CA&max_variant=2&diacritic=both&download=wordlist&encoding=utf-8&format=inline

RUN true \
  && mkdir /scowl-wl \
  && wget -O /scowl-wl/words-US-60.txt ${SOURCE_US} \
  && wget -O /scowl-wl/words-US-70.txt ${SOURCE_US_BIG} \
  && wget -O /scowl-wl/words-GB-ise-60.txt ${SOURCE_GB_ISE} \
  && wget -O /scowl-wl/words-GB-ize-60.txt ${SOURCE_GB_IZE} \
  && wget -O /scowl-wl/words-CA-60.txt ${SOURCE_CA}

