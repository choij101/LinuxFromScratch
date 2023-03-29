# Chapter 3. Packages and Patches
### 3.1 Introduction
이 장에선 LFS설치에 필요한 파일들을 $LFS/sources에 저장하고 제대로 받았는지 확인한다. Root 유저로 진행하자. 
```bash
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
```
> $LFS/sources 디렉토리를 writable / sticky 하게 만들어 준다. Sticky는 다른 유저들도 write permission을 가지고 있지만, owner만 삭제 권한을 가지고 있음을 뜻한다.

wget을 이용해 필요한 파일들을 받아주자. 파일 목록은 [wget-list-sysv](https://www.linuxfromscratch.org/lfs/view/11.2/wget-list-sysv) 에서 가져오자. 받은 파일들은 [md5sums](https://www.linuxfromscratch.org/lfs/view/11.2/md5sums) 를 이용해 체크한다.
```bash
wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources

pushd $LFS/sources
  md5sum -c md5sums
popd
```

2022.12.27 기준 expat-2.4.8과 zlib-1.2.12를 가져올 수 없다. 다음 링크에서 받아서 $LFS/sources에 넣어주자. zlib-1.2.12 버전은 홈페이지에서도 다운로드가 막혀있으니, 대신 zlib-1.2.13을 사용한다.
```bash
cd $LFS/sources
# expat 2.4.8
wget https://github.com/libexpat/libexpat/releases/download/R_2_4_8/expat-2.4.8.tar.xz

# zlib 1.2.13
wget https://zlib.net/zlib-1.2.13.tar.xz
```

---
### 3.2 All Packages
LFS 설치에 필요한 패키지 목록이다.

---
### 3.3 Need Patches
LFS 설치에 필요한 패치 목록이다.
