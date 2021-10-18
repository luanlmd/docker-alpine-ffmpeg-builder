FROM alpine:3.14 as build
RUN apk update && apk --no-cache add alpine-sdk coreutils cmake sudo
RUN adduser builder --disabled-password -G abuild
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder
WORKDIR /home/builder
RUN wget https://git.alpinelinux.org/aports/plain/community/ffmpeg/0001-libavutil-clean-up-unused-FF_SYMVER-macro.patch?h=3.9-stable -O 0001-libavutil-clean-up-unused-FF_SYMVER-macro.patch
RUN wget https://git.alpinelinux.org/aports/plain/community/ffmpeg/APKBUILD?h=3.9-stable -O APKBUILD
RUN sed -ie '/--enable-libopus \\/a --enable-filter=drawtext \\' APKBUILD
RUN sed -ie '/--enable-libopus \\/a --enable-libfreetype \\' APKBUILD
RUN abuild-keygen -n -a -i
RUN abuild -r