FROM manjarolinux/base:latest

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
RUN useradd -m ptzzx && echo "ptzzx:ptzzx" | chpasswd
RUN pacman -Sy --noconfirm && \
    pacman -S --noconfirm extra/libpulse git sudo ttf-dejavu noto-fonts ttf-liberation ttf-droid ttf-roboto mc doas yay && \
    pacman -Scc --noconfirm &&  echo "ptzzx ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY entrypoint.sh /home/ptzzx/entrypoint.sh
RUN chmod +x /home/ptzzx/entrypoint.sh

USER ptzzx
WORKDIR /home/ptzzx


RUN yay -S --noconfirm --mflags "--skipinteg" --builddir /tmp --needed $(yay -Si nomachine | awk '/Depends On/ {for(i=4;i<=NF;i++) print $i}' | sed 's/[<>=].*//g') && \
    yay -Scc --noconfirm

ENTRYPOINT ["/home/ptzzx/entrypoint.sh"]
CMD ["/bin/bash"]
