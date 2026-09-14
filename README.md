# Step Melakukan Instalasi

> *Step instalasi ini berekspektasi bahwa kamu sudah mempunyai public domain dan memiliki sedikit pengetahuan tentang setting cloudflare tunnel di lingkungan linux.*

## A. Install docker
1. Jika menggunakan linux server berbasis RHEL install docker dulu
```bash
    sudo dnf remove -y podman-docker podman
    sudo dnf install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
2. Jalankan dan aktifkan service docker
```bash
    sudo systemctl start docker
    sudo systemctl enable docker
```

## B. Clone repository ini
1. clone repository ini
```bash
    git clone https://github.com/vorxsaken/oracle-apex-docker-installer.git
```
2. unzip repo
``` bash
    unzip oracle-apex-docker-installer.zip
```
3. masuk ke directory repo 
```bash
    cd oracle-apex-docker-installer
```
4. edit file `unattended_apex_install.sh`
``` bash
    nano unattended_apex_install.sh
```
5. pergi ke line `137` dan edit domain ords config `security.externalSessionTrustedOrigins` menjadi domainmu sendiri, contoh : `https://your-own-domain.care` → `https://my-domain.care`.
4. Jalankan script `create_oracle_docker.sh`
```bash
    sudo ./create_oracle_docker.sh
```

## C. Setting Cloudflare Tunnel
1. pergi ke web page [cloudflare](https://dash.cloudflare.com/) dan pada sidebar pilih **Zero Trust**
2. pada sidebar expand **Networks** → **Tunnels & Mesh**.
3. pada kanan atas klik button **Create Tunnel**
4. klik button **Select Cloudflared**
5. pada page *Create Tunnel* field **Name Your Tunnel** masukkan nama tunnel, contoh `tunnel-1`.
6. pada page *Configure* region *Select your device operating system* ubah **Windows** → **Red Hat**.
7. ikuti step yang muncul setelah mengubah select option itu, klik *next*.
8. selesai.

> ## Opsional (jika install di virtualbox)
> ### Step untuk mengaktifkan shared folder virtualbox
> 1. install package yang dibutuhkan
> ```bash
>     sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
> ```
> 2. mount Guest Additions CD dari menu VirtualBox: Devices → Insert Guest Additions CD Image
> 3. kemudian jalankan command ini secara berurutan dan reboot :
> ```bash
>     sudo mkdir -p /mnt/cdrom
>     sudo mount /dev/cdrom /mnt/cdrom
>     cd /mnt/cdrom
>     sudo ./VBoxLinuxAdditions.run
> ```
> 4. tambahkan user sekarang ke group `vboxsf` dan reboot :
> ```bash
>     sudo usermod -aG vboxsf $USER
> ```