FROM ubuntu
RUN apt-get update -y && apt-get install -y \
    sudo \
    wget \
    curl \
    software-properties-common \
    fuse

ARG USER=docker
ARG PASS

RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd -rm -d /home/$USER -s /bin/bash -g root -G sudo -u 1000 $USER && \
    echo "$USER:$PASS" | chpasswd
USER $USER
ENV USER $USER
ENV PASS $PASS
ENV HOME /home/$USER
ENV PATH $HOME/.local/bin:$PATH

WORKDIR $HOME
RUN mkdir -p .local/bin
RUN mkdir dotfiles

WORKDIR $HOME/.local/bin
RUN wget https://foosoft.net/projects/homemaker/dl/homemaker_linux_amd64.tar.gz  && \
    tar -zxvf homemaker_linux_amd64.tar.gz && \
    mv homemaker_linux_amd64/homemaker homemaker && \
    rm homemaker_linux_amd64.tar.gz && \
    rm -rd homemaker_linux_amd64 && \
    chmod +x homemaker

WORKDIR $HOME/dotfiles
COPY . .
# RUN homemaker -verbose -task fish homemaker.yaml ./
# homemaker -verbose -task nvim homemaker.yaml ./



