# Chapter 4. Final Preparations
### 4.1 Introduction
이 장에서는 LFS 빌드에 필요한 디렉토리를 만들고, superuser 권한을 가지고 있지 않은 새로운 user를 만든다. 처음엔 Host machine에서 설치를 진행해야 하기 때문에, root user로 진행할 시 예기치 못한 문제가 발생할 수 있다.

---
### 4.2 Creating a lilmited directory layout in LFS filesystem
```bash
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64;;
esac

mkdir -pv $LFS/tools
```

---
### 4.3 Adding the LFS User
Root 유저로 설치를 진행할 시, 조그마한 실수도 host machine을 다운시킬 수 있다. 따라서 LFS system을 부팅하기 전인 chapter5, 6에서 패키지를 설치할 때는 LFS user를 새로 만들어서 진행한다.
```bash
# create lfs user
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

# setting password for lfs
passwd lfs

# grant lfs full access to all directories under $LFS
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64;;
esac

# now login to lfs
su - lfs
```

---
### 4.4 Setting up the Envrionment
lfs user로 로그인할 때 필요한 환경변수들을 매번 세팅해주기 보단, startup file을 만들어서 자동으로 세팅해 주자. 두 파일을 세팅할 것이다.
1. ~/.bash_profile
```bash
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF
```
2. ~/.bashrc
```bash
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF
```
환경설정은
```bash
source ~/.bash_profile
```
로 새로 해주자. 이제 lfs user로 로그인 할 때마다 자동으로 적용될 것이다.

---
### 4.5 About SBUs
[link](https://www.linuxfromscratch.org/lfs/view/11.2/chapter04/aboutsbus.html) 참고

---
### 4.6 About the Test Suites
[link](https://www.linuxfromscratch.org/lfs/view/11.2/chapter04/abouttestsuites.html) 참고
