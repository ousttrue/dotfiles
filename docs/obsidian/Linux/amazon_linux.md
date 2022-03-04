Amazon Linux 2
#WSL #linux

CentOS ベース
	https://qiita.com/YukiMiyatake/items/73c7d6c4f2c9739ebe60

[WSL で Amazon Linux 2 を使用する https://qiita.com/noumia/items/9fecd2a7c3ea4acb696e]

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

