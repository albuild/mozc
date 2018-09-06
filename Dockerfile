FROM amazonlinux:2.0.20180827

RUN yum update
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y git tar gzip xz which pkgconfig ibus-devel qt5-qtbase-devel gtk2-devel ninja-build gcc-c++
RUN ln -s /usr/bin/ninja-build /usr/bin/ninja

RUN mkdir /app
WORKDIR /app

RUN curl -O https://cmake.org/files/v3.12/cmake-3.12.1-Linux-x86_64.tar.gz
RUN tar zxvf cmake-3.12.1-Linux-x86_64.tar.gz
RUN curl -O http://releases.llvm.org/6.0.1/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
RUN tar Jxvf clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz

ENV PATH /app/cmake-3.12.1-Linux-x86_64/bin:$PATH
ENV PATH /app/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/bin:$PATH
ENV CPATH "/usr/include/c++/7:/usr/include/c++/7/x86_64-redhat-linux"

RUN git clone https://github.com/google/mozc.git -b master --single-branch
WORKDIR /app/mozc
RUN git checkout -b build afb03ddfe72dde4cf2409863a3bfea160f7a66d8
RUN git submodule update --init --recursive

WORKDIR /app/mozc/src
RUN python build_mozc.py gyp --target_platform=Linux --server_dir=/opt/albuild-mozc/0.1.0
RUN python build_mozc.py build -c Release \
  unix/ibus/ibus.gyp:ibus_mozc \
  unix/emacs/emacs.gyp:mozc_emacs_helper \
  server/server.gyp:mozc_server \
  gui/gui.gyp:mozc_tool \
  renderer/renderer.gyp:mozc_renderer
ADD mozc.xml /app/mozc/src/out_linux/Release

RUN yum install -y rpm-build

RUN mkdir -p /root/rpmbuild/{SOURCES,SPECS}
WORKDIR /root/rpmbuild
ADD rpm.spec SPECS
RUN rpmbuild -bb SPECS/rpm.spec
