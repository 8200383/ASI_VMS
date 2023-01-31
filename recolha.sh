rm -rf EX1.tgz EX1/

mkdir -p ~/EX1/SSH
mkdir -p ~/EX1/CRONTAB
mkdir -p ~/EX1/DNS
mkdir -p ~/EX1/HTTP
mkdir -p ~/EX1/LVM
mkdir -p ~/EX1/EMAIL

cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 > ~/EX1/.rand
date >> ~/EX1/.rand

echo "A recolher execucao SSH"
cp -r /root /home/root
cp /etc/passwd /home
cp /etc/group /home
tar czvf ~/EX1/SSH/homes.tgz /home

echo "A recolher execucao CRONTAB"
tar czvf ~/EX1/CRONTAB/cron.tgz  /var/spool/cron/*

echo "A recolher execucao HTTP/DNS"
cp /etc/named.conf ~/EX1/DNS/named.conf
cp -r /etc/bind ~/EX1/DNS/
cp -r /var/named ~/EX1/DNS/
cp /etc/resolv.conf ~/EX1/DNS/resolv.conf

cp /etc/httpd/conf/httpd.conf ~/EX1/HTTP
cp -r /etc/httpd/ ~/EX1/HTTP/httpd
cp -r /etc/ssl/ ~/EX1/HTTP/certs
cp -r /opt/ ~/EX1/HTTP/opt

echo "A recolher execucao LVM"
fdisk -l > ~/EX1/LVM/fdisk.txt
pvs > ~/EX1/LVM/pvs.txt
vgs > ~/EX1/LVM/vgs.txt
lvs > ~/EX1/LVM/lvs.txt
df -k > ~/EX1/LVM/df.txt
cat /etc/fstab > ~/EX1/LVM/fstab.txt

echo "A recolher execucao EMAIL"
cp /etc/postfix/main.cf ~/EX1/EMAIL/
cp /etc/dovecot/dovecot.conf ~/EX1/EMAIL/
cp /etc/aliases ~/EX1/EMAIL/

echo "a juntar tudo...."
sleep 1
cd ~
tar czvf EX1.tgz ./EX1
