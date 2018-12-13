#!/usr/bin/env bash
###########################
# k8s yum repo
###########################

#rm older
cd /usr/share/nginx/yum/kubernetes/
rm -rf *

#download newer
yum install -y --downloadonly --downloaddir=/usr/share/nginx/yum/kubernetes/ kubelet kubectl kubernetes-cni kubeadm

#rename them
for o in $(ls socat*);do
    mv $o "123-"$o
done

for f in $(ls);do
    mv $f ${f#*-}
done
