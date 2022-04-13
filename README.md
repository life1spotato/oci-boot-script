# oci-boot-script
## 요구사항
- E2 Micro 인스턴스 (항상 무료)
- Ubuntu 20.04 LTS

## 빠른 시작
- 인스턴스 생성 후, 터미널에 다음을 입력하세요.
```sh
curl -fsSL https://raw.githubusercontent.com/life1spotato/oci-boot-script/main/oci-boot-script.sh -o oci-boot-script.sh
sudo sh oci-boot-script.sh
```

## 자동화 항목
- apt update / upgrade
- Timezone: Asia/Seoul
- Virtual Memory: 4GB
- Port Open: 21, 22, 80, 81, 443, 8000, 9443
- Docker
  - Network: npm-net
  - Container
    - Nginx Proxy Manager
    - Portainer

## 네트워크
- `npm-net` 네트워크로 **Nginx Proxy Manager**와 **Portainer**가 연결됩니다. **Nginx Proxy Manager**에서 새로운 컨테이너에 프록시 연결을 하려면 컨테이너 네트워크에 `npm-net`을 추가해주세요. 같은 네트워크에 있는 컨테이너는 **Nginx Proxy Manager**의 hostname/ip에 컨테이너 이름을 입력하여 편하게 프록시 연결할 수 있습니다.
- `sudo docker network connect npm-net 컨테이너명`
