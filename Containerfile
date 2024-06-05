FROM fedora:40

COPY --from=ghcr.io/ublue-os/ucore-kmods:stable /rpms/ /tmp/rpms

RUN mkdir /kernel \
  && cd /kernel \
  && koji download-build --arch=x86_64 --arch=noarch \
       kernel-$(find /tmp/rpms/kmods/zfs/ -name "kmod-zfs*.rpm" ! -name "*devel*" | sed 's/.*\/kmod-zfs-//; s/\.fc.*$//g' | head -1).fc40 \
  && rm *debug*.rpm *uki*.rpm
