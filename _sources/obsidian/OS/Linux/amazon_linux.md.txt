Amazon Linux 2
[[OS/Linux/wsl]] [[Linux]] [[CentOS]]

- https://aws.amazon.com/jp/amazon-linux-2/faqs/

# VERSION
[ECR Public Gallery - amazonlinux](https://gallery.ecr.aws/amazonlinux/amazonlinux)
Image tags で探せる
[Docker](https://hub.docker.com/_/amazonlinux/)

## 2.0.20230320.0
## 2.0.20200406.0
```
$ docker pull amazonlinux:2.0.20200406.0
```

# WSL
- @2018 [WSL で Amazon Linux 2 を使用する - Qiita](https://qiita.com/noumia/items/9fecd2a7c3ea4acb696e)

# Docker
- [Docker](https://hub.docker.com/_/amazonlinux/)
- @2019 [Docker for Windowsで快適な環境を得るまでの そこそこ長い闘い - Qiita](https://qiita.com/YukiMiyatake/items/73c7d6c4f2c9739ebe60)
# packages
## adduser, passwd
su
	$ yum install util-linux
adduser
	$ yum install shadow-utils
passwd
	$ yum install passwd

## dotnet
```
$ rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
$ yum install dotnet-sdk-2.2
```

## cmake
- https://www.matbra.com/2017/12/07/install-cmake-on-aws-linux.html

