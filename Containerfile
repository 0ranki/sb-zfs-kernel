FROM fedora:40

COPY --from=ghcr.io/ublue-os/ucore-kmods:stable /rpms/ /rpms

RUN dnf install -y koji createrepo
WORKDIR /rpms
RUN koji download-build --arch=x86_64 --arch=noarch \
       kernel-$(find /rpms/kmods/zfs/ -name "kmod-zfs*.rpm" ! -name "*devel*" | sed 's/.*\/kmod-zfs-//; s/\.fc.*$//g' | head -1).fc40
RUN createrepo /rpms
