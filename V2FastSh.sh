#Hello , this script made by PavelShell

#Colors
RED='\033[91m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[94m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\x1b[1m'
NORM='\x1b[0m'
#-------------------------------------------------
echo -e "${BOLD}${RED}      ● Clearing Terminal ...${NORM}"
sleep 2
clear
sleep 2

echo -e "${BLUE}      ● Getting IP & Domains ...${NORM}"
#Get Server IP
ip=""
#Get Cloudflare Domain
domain=""
#Generate UUID
uuid=$(uuidgen)
#port
portt="80"
#Pathes
path=""
#Cloudflare clean IP&Domain
cf1="188.114.96.3"
cf2="mAx.NS.cLoUdflaRe.coM"
#-------------------------------------------------
echo -e "${WHITE}${BOLD}      ● Installing V2FastShell ...${NORM}"
install_xray() {
  echo -e "${BLUE}      ● Installing Xray From Github ...${NC}"
  bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
}
install_dependencies() {
  echo -e "${BLUE}      ● Update & Configuring Server ..."
  apt update
  apt install screen unzip -y
}

configure_xray() {
  sleep 2
  
  #Links
  Alink1="vless://"$uuid"@"$cf1":443?encryption=none&security=tls&type=ws&host="$domain"&path="/$path"&sni=$domain&fp="chrome"&alpn="h2,http/1.1"#VLess-V2FastShell-cf1-Port-443"
  Alink2="vless://"$uuid"@"$cf1":80?encryption=none&security=none&type=ws&host="$domain"&path="/$path"#VLess-V2FastShell-cf1-Port-80"
  Alink3="vless://"$uuid"@"$cf2":443?encryption=none&security=tls&type=ws&host="$domain"&path="/$path"&sni=$domain&fp="chrome"&alpn="h2,http/1.1"#VLess-V2FastShell-cf2-Port-443"
  Alink4="vless://"$uuid"@"$cf2":80?encryption=none&security=none&type=ws&host="$domain"&path="/$path"#VLess-V2FastShell-cf2-Port-80"
  
  Blink1=$(echo -e '\x76\x6d\x65\x73\x73')://$(echo -n "{\"v\":\"2\",\"ps\":\"VMess-V2FastShell-cf1-Port-443\",\"add\":\"$cf1\",\"port\":\"443\",\"id\":\"$uuid\",\"aid\":\"0\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$domain\",\"path\":\"/$path\",\"tls\":\"tls\",\"fp\":\"chrome\",\"alpn\":\"h2,http/1.1\",\"sni\":\"$domain\",\"security\":\"auto\"}" | base64 -w 0)
  Blink2=$(echo -e '\x76\x6d\x65\x73\x73')://$(echo -n "{\"v\":\"2\",\"ps\":\"VMess-V2FastShell-cf1-Port-80\",\"add\":\"$cf1\",\"port\":\"80\",\"id\":\"$uuid\",\"aid\":\"0\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$domain\",\"path\":\"/$path\",\"security\":\"auto\"}" | base64 -w 0)
  Blink3=$(echo -e '\x76\x6d\x65\x73\x73')://$(echo -n "{\"v\":\"2\",\"ps\":\"VMess-V2FastShell-cf2-Port-443\",\"add\":\"$cf2\",\"port\":\"443\",\"id\":\"$uuid\",\"aid\":\"0\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$domain\",\"path\":\"/$path\",\"tls\":\"tls\",\"fp\":\"chrome\",\"alpn\":\"h2,http/1.1\",\"sni\":\"$domain\",\"security\":\"auto\"}" | base64 -w 0)
  Blink4=$(echo -e '\x76\x6d\x65\x73\x73')://$(echo -n "{\"v\":\"2\",\"ps\":\"VMess-V2FastShell-cf2-Port-80\",\"add\":\"$cf2\",\"port\":\"80\",\"id\":\"$uuid\",\"aid\":\"0\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$domain\",\"path\":\"/$path\",\"security\":\"auto\"}" | base64 -w 0)
#-------------------------------------------------
echo -e "${BLUE}      ● Generating Inbound ..."

  systemctl stop xray.service
  rm -rf /usr/local/etc/xray/config.json
  cat >/usr/local/etc/xray/config.json <<-EOF
{
  "log": {
    "error": null,
    "loglevel": "warning"
  },
  "routing": {
    "domainStrategy": "IPOnDemand",
    "rules": [
      {
        "ip": [
          "geoip:private"
        ],
        "outboundTag": "blocked",
        "type": "field"
      },
      {
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ],
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "IPv4",
        "domain": [
          "geosite:google"
        ]
      }
    ]
  },
  "dns": null,
  "inbounds": [
    {
      "listen": null,
      "port": "$portt",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "email": "avmess",
            "flow": "",
            "id": "$uuid"
          }
        ],
        "decryption": "none",
        "fallbacks": []
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": false,
          "headers": {
            "Host": "$domain"
          },
          "path": "/$path"
        }
      },
      "tag": "avmess",
      "sniffing": {
        "enabled": false,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "listen": null,
      "port": "$portt",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "email": "avless",
            "flow": "",
            "id": "$uuid"
          }
        ],
        "decryption": "none",
        "fallbacks": []
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": false,
          "headers": {
            "Host": "$domain"
          },
          "path": "/$path"
        }
      },
      "tag": "avless",
      "sniffing": {
        "enabled": false,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    },
    {
      "tag": "IPv4",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv4"
      }
    }
  ],
  "api": {
    "services": [
      "HandlerService",
      "LoggerService",
      "StatsService"
    ],
    "tag": "api"
  },
  "stats": {},
  "reverse": null,
  "fakeDns": null
}
EOF

sleep 2

#Folder
echo -e "${BLUE}      ● Generating JSON Folder ..."
mkdir -p V2FastShell

systemctl start xray.service
sleep 2
systemctl restart xray.service
}

ip="$1"
domain="$2"
path="$3"
install_dependencies
install_xray
systemctl start xray.service
configure_xray

echo -e "${WHITE}${BOLD}      ☆ V2FastShell Installed Successfully ${NORM}"
echo -e "${YELLOW}      V2FastShell Running •"
echo -e "${RED}${BOLD}      Wait For Generating Links${NORM}"
sleep 3
echo -e "${WHITE}--------------------------------"
echo -e "${WHITE}Server IP :${RED} $ip\n${WHITE}UUID : ${RED}$uuid\n${WHITE}Domain : ${RED}$domain\n${WHITE}Path : ${RED}/$path"
echo -e "${WHITE}--------------------------------"

echo -e "${BLUE}      VLESS Links :"
echo -e "${WHITE}$Alink1\n$Alink2\n$Alink3\n$Alink4"
echo -e "${BLUE}      VMESS Links :"
echo -e "${WHITE}$Blink1\n$Blink2\n$Blink3\n$Blink4"
