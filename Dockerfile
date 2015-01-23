FROM dockerfile/java:oracle-java8
MAINTAINER web@ponkotuy.com

# install sbt
RUN apt-get update && apt-get install -y curl && apt-get clean
RUN mkdir /root/bin && \
  curl -s https://raw.githubusercontent.com/paulp/sbt-extras/master/sbt > ~/bin/sbt \
  && chmod 0755 ~/bin/sbt
VOLUME ["/root/.ivy2", "/root/.sbt"]

# copy file
RUN mkdir /root/play
ADD app /root/play/app/
ADD conf /root/play/conf/
ADD project /root/play/project/
ADD build.sbt /root/play/build.sbt

# run
EXPOSE 9000
WORKDIR /root/play
CMD \
  /root/bin/sbt stage && \
  target/universal/stage/bin/root
