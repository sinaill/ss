CONFIG_FILE=/etc/shadowsocks.json
SERVICE_FILE=/etc/systemd/system/shadowsocks.service

# install shadowsocks
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py
pip install --upgrade pip
pip install shadowsocks

# create shadowsocls config
cat <<EOF | sudo tee ${CONFIG_FILE}
{
  "server": "0.0.0.0",
  "local_address": "127.0.0.1",
  "local_port": 1080,
  "port_password": {
    "8388": "cairuijie",
    "8389": "zhongwenjiao",
    "8390": "liwenhui",
    "8391": "chenyujuan",
    "8392": "chanchanchan",
    "8393": "wengmeibao"
  },
  "timeout": 600,
  "method": "aes-256-cfb"
}
EOF

# create service
cat <<EOF | sudo tee ${SERVICE_FILE}
[Unit]
Description=Shadowsocks

[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/ssserver -c ${CONFIG_FILE}

[Install]
WantedBy=multi-user.target
EOF

# add iptables
systemctl stop firewalld.service
iptables -I OUTPUT -p tcp --sport 8388
iptables -I OUTPUT -p tcp --sport 8389
iptables -I OUTPUT -p tcp --sport 8390
iptables -I OUTPUT -p tcp --sport 8391
iptables -I OUTPUT -p tcp --sport 8392
iptables -I OUTPUT -p tcp --sport 8393


# start service
systemctl enable shadowsocks
systemctl start shadowsocks

# view service status
sleep 5
systemctl status shadowsocks -l

cat /etc/shadowsocks.json
