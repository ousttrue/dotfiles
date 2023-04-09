Amazon Linux 2
[[wsl]] [[Linux]] [[CentOS]]

`amazonlinux:2.0.20200406.0`

- @2019 [Docker for Windowsで快適な環境を得るまでの そこそこ長い闘い - Qiita](https://qiita.com/YukiMiyatake/items/73c7d6c4f2c9739ebe60)
- @2018 [WSL で Amazon Linux 2 を使用する - Qiita](https://qiita.com/noumia/items/9fecd2a7c3ea4acb696e)

https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/WSL.html
https://aws.amazon.com/jp/amazon-linux-2/faqs/

[* adduser, passwd]
su
	$ yum install util-linux
adduser
	$ yum install shadow-utils
passwd
	$ yum install passwd

	$ rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
 $ yum install dotnet-sdk-2.2

cmake
https://www.matbra.com/2017/12/07/install-cmake-on-aws-linux.html

