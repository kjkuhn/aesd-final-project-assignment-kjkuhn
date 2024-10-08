FROM ubuntu:22.04  
  
ENV DEBIAN_FRONTEND=noninteractive  
ENV LANG=C.UTF-8  
ENV LC_ALL=C.UTF-8  
  
RUN apt update && \  
    apt install -y --no-install-recommends \  
    locales && \  
    locale-gen en_US.UTF-8 && \  
    update-locale LANG=en_US.UTF-8 && \  
    apt install -y --no-install-recommends \  
    gawk wget curl git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file libacl1  


RUN git config --global user.name "Github Runner"
RUN git config --global user.email "gh.runner@local.domain"
RUN chmod a+rw $HOME/.gitconfig

# # Reset DEBIAN_FRONTEND to avoid affecting subsequent builds  
# ENV DEBIAN_FRONTEND=newt  

# COPY . /workspace

# WORKDIR /workspace

# RUN sed -i 's/INHERIT += "sanity"/#INHERIT += "sanity"/g' poky/meta/conf/sanity.conf

# RUN git config --global --add safe.directory /workspace/build/downloads/git2/gitlab.freedesktop.org.pkg-config.pkg-config.git

# RUN ./build.sh