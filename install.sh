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
    },
    {
      "listen": null,
      "port": "443",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "email": "avless2",
            "flow": "",
            "id": "$uuid"
          }
        ],
        "decryption": "none",
        "fallbacks": []
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificate": [
              -----BEGIN CERTIFICATE-----
MIIEFTCCAv2gAwIBAgIUXI0BOnf5KwHkWow+JJcsojZGQGIwDQYJKoZIhvcNAQEL
BQAwgagxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQH
Ew1TYW4gRnJhbmNpc2NvMRkwFwYDVQQKExBDbG91ZGZsYXJlLCBJbmMuMRswGQYD
VQQLExJ3d3cuY2xvdWRmbGFyZS5jb20xNDAyBgNVBAMTK01hbmFnZWQgQ0EgOGRi
NGQxZDdmZWEzY2RjY2FlZDlmMjBhYWE5MGUzODcwHhcNMjQwODE1MTEzNjAwWhcN
MzQwODEzMTEzNjAwWjAiMQswCQYDVQQGEwJVUzETMBEGA1UEAxMKQ2xvdWRmbGFy
ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOI8WPCvkN727HVDEKx2
a+BUyE6de71zSb1vnHTao3gaehylYnfU4alVfr+4AUTFj2VJHi6xKXIwi3nAN4gr
EBCFc2tENUwfrc/12Z7+cRcCl4VNg8belMtF5T5fydyFl1w4o79/827IHJe7AoOV
7pV/UzedVREEt1kE3+XubpoC3oEBPhle1pSwJcRk/E5sXKA2FbuemyzWddPv0vr8
8lmP7jOXZgOvDeGfpSWxTqB4pufYe4ByEJTd+NCto1hYJEpRor4+5ZiJFyTnjTee
pDMfLyUor1qMuLjrhARmdTXXqPc3ERZnvmQShW4bN1nfFc69pT84wUNihBMd+/Ny
jzMCAwEAAaOBuzCBuDATBgNVHSUEDDAKBggrBgEFBQcDAjAMBgNVHRMBAf8EAjAA
MB0GA1UdDgQWBBSvEpwRHbp/d8v4TmzJ6B0ZVLPm5DAfBgNVHSMEGDAWgBRuUNh8
5nj1V1CQhRK89qCfPG8MmTBTBgNVHR8ETDBKMEigRqBEhkJodHRwOi8vY3JsLmNs
b3VkZmxhcmUuY29tL2VkNDY0NDU4LTk5ZTQtNGVmZS05YzBkLWRmYTBkM2Q4YWI1
YS5jcmwwDQYJKoZIhvcNAQELBQADggEBAATELt/i1F+Clra0LEkcaU31hHWnfufp
2WUH+bmBMJnjJpqZlZbRjodeVFhfkQoTvpz1CoU65otZG6QKpk7ElRNXzz4FCGeR
2llq9/8AU7DgyO6cxJhlHqvxsq8MXXHiTn83DQvOLBGe9cdJyTm5i9+1gu9AAyqK
7ejGnJg9bziYJIE4Msp6aGtEn5N+g9bz+VpVORfvRKiQrFYiB5oC+MzzjxuCYgSK
mfuhAL3hbetGjYmN+ZNhZqI2mia/1qHzROrxSCCDdwtPqTCVVXjfpNYSkOTnUOUy
6AzIQ8HHWTtoORdCzp8uXJPELG2Q/i2pTTKvazb+4otPjPyWYSnLdec=
-----END CERTIFICATE-----
              ],
              "key": [
              -----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDiPFjwr5De9ux1
QxCsdmvgVMhOnXu9c0m9b5x02qN4GnocpWJ31OGpVX6/uAFExY9lSR4usSlyMIt5
wDeIKxAQhXNrRDVMH63P9dme/nEXApeFTYPG3pTLReU+X8nchZdcOKO/f/NuyByX
uwKDle6Vf1M3nVURBLdZBN/l7m6aAt6BAT4ZXtaUsCXEZPxObFygNhW7npss1nXT
79L6/PJZj+4zl2YDrw3hn6UlsU6geKbn2HuAchCU3fjQraNYWCRKUaK+PuWYiRck
5403nqQzHy8lKK9ajLi464QEZnU116j3NxEWZ75kEoVuGzdZ3xXOvaU/OMFDYoQT
Hfvzco8zAgMBAAECggEAb3dQUvYNqO18P6JVesO2Dwd20dUh/IvrDx0It0JqPGi/
NZH+3A/VR3tKQefFKD82ka7e4h6DzzE/5zLfqYWeGqXF4lnu8JzDJK17Fa1DxxSN
1y4D+V39bdH4Sy0i5jYkB1oYw+ek5zZNcCzB5lde/+WF+ObZ3NK4C3ItZrp9X/+Q
oKz9iC1ybKNbUzacQ9YsZe7axzujloVd8i8qD/tTPIC56UsubvoIyAWaKg8ZESOt
H+VP0M6oJ0584hyYaDhvcGlKF/yyNBpRdrgxyFnrQFwTG3HOtbecX4YWCRjXFVfh
ULGSyhSdfT4zHi/mV7hv965seeL7dGq7Fb6HdfVEoQKBgQD4edq3DEgeks8uWHzr
1vzE7akYSxW4OhH19iJbDrdtaN12Yldp9/39K34gvfz/UBxeVGFYRfS15oaHly4C
sPAjj3M89ktKp3TBu2peYu7++LaNL3Vc0nzpP/+ZaazWjKsJ7kjEwsI71RyXNkrK
vtN7TFRK/vB9vBvGU8t8szlNSQKBgQDpFhcU9K2aQp8t0ekdbvcVMwIxs4Y3VZOU
Ps17e0S/oDHq7xlEABTFiUlIiM1itEv/Omm1qRVolliM+/bg8dxb7b7vRtvyNV5O
ha8oc8ZWxNr+FrS/jB5ReBv26lUnHmRuISb5AS6/7GeBoYkxiz8LOx5VywNrwrhb
BbIRvk6kmwKBgQCW+wQJIe9YlIBLev09GL8yse6Dkmw6Kx7qw4qQpdqTIpse6haP
j17HzPuwzYDDalwyfTdBOhC9zruD/Dq66+Se1vWA329Uh3gMl+LEQ31RdLMICwRX
SJcZ7AdVor6hB4yOVjnlRSpczNu4jgbYNyetze2SPGLJI9oEoroMpaJ18QKBgCnV
+DCftiUw/gcoXRIWX6zjaepn0ZhO+N0r5I/cUTuf0jXb0oodBZ1rBcdKHqsvt1BJ
OL4NajVKfvxXITnAz4+EfbfO3R19LL8lSYoWNaxPSws+IhUbXjm7ODG6X6xUzSvj
MW6SIsT59p4S02AcISWv58L4XFXULmjP/eUnZlAvAoGAGCi7EQM2KGhCzZXFUD7r
HOhjVxhjGVk2DUXcLmXeljyA1c9kBwYSh175LbmAqf90f1JqQecZUVCJohRsHcgl
tliG5LCozHXPIUMch5sty8JyEWh7bkMGECSLM+4kcP3u2ica7/ug4Bdnua7lvTCS
wMvOxgpAPXCIYaiFCfc+X7Y=
-----END PRIVATE KEY-----
              ]
            }
          ]
        },  
        "wsSettings": {
          "acceptProxyProtocol": false,
          "headers": {
            "Host": "$domain"
          },
          "path": "/$path"
        }
      },
      "tag": "avless2",
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
