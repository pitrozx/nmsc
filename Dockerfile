FROM manjarolinux/base:latest

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git sudo ttf-dejavu noto-fonts ttf-liberation ttf-droid ttf-roboto && \
    pacman -Scc --noconfirm

RUN useradd -m ptzzx && echo "ptzzx:ptzzx" | chpasswd && \
    echo "ptzzx ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ptzzx
WORKDIR /home/ptzzx

RUN git clone https://aur.archlinux.org/yay.git && \
    cd yay && makepkg -si --noconfirm && \
    cd .. && rm -rf yay && yay -Scc --noconfirm

RUN yay -S --noconfirm --mflags "--skipinteg" --builddir /tmp --needed $(yay -Si nomachine | awk '/Depends On/ {for(i=4;i<=NF;i++) print $i}' | sed 's/[<>=].*//g') && \
    yay -Scc --noconfirm

COPY entrypoint.sh /home/ptzzx/entrypoint.sh
RUN chmod +x /home/ptzzx/entrypoint.sh

ENTRYPOINT ["/home/ptzzx/entrypoint.sh"]
CMD ["/bin/bash"]
