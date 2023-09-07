# docker build -tag nvim .
# docker run --rm -it -u hoge:hoge nvim
From centos:7
ARG username=hoge

RUN yum -y install python3
RUN pip3 install --upgrade pip
RUN pip3 install meson ninja cmake ziglang

RUN <<__EOF__
cat <<__CAT__ >> /etc/inputrc
"\C-n":history-search-forward
"\C-p":history-search-backward
set bell-style none
__CAT__
__EOF__

#
# USER
#
RUN yum -y install sudo
RUN useradd -m ${username}
RUN echo "${username}:${username}" | chpasswd
RUN echo "${username} ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN <<__EOF__
cat <<\__CAT__ > /home/${username}/.bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin:/usr/local/lib64/python3.6/site-packages/ziglang

export PATH
__CAT__
__EOF__
