dnf module disable redis -y
dnf module enable redis:7 -y
dnf install redis -y
# Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf
# Update protected-mode from yes to no in /etc/redis/redis.conf
sed -i '/^bind/ s/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
sed -i '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
systemctl enable redis
systemctl start redis

