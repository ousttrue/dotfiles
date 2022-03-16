windows setup
`201904`

Chrome入れる
	DownloadフォルダをDesktopに

7zip入れる

caps to ctrl
	https://docs.microsoft.com/en-us/sysinternals/downloads/ctrl2cap

scoop
	powershellの実行許可
	https://scoop.sh/ インストール
		失敗した場合は、`%USERPROFILE%/scoop` を消してやりなおし

cica font
	https://github.com/miiton/Cica/releases

git
	scoop install git vim

vim
code:vimrc.vim
 set encoding=utf8
 let s:nvim_init = expand('~/AppData/Local/nvim/init.vim')
 if filereadable(s:nvim_init)
     execute 'source ' . s:nvim_init
 endif

python適当に
	https://qiita.com/ousttrue/items/527a9c3045f710806aa9

powershell設定
	`mkdir %USERPROFILE%\Documents\WindowsPowerShell`
	`%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
	`vim $profile`
code:profile.ps1
 Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
 Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
 Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
 Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
 Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
 Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
 Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
 Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
 Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
 Set-PSReadlineKeyHandler -Key 'Ctrl+m' -Function AcceptLine
 Set-PSReadlineKeyHandler -Key 'Ctrl+k' -Function ForwardDeleteLine

scoop
	ctags
	dub
	llvm
