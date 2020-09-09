

# Git 全局忽略 .DS_Store 配置
先在 dotfiles-mac 目录执行 `stow git`，让 .gitignore_global 在家目录成功建立软链接。
接下来就需要让 git 全局配置能够读取到 .gitignore_global 了。

有两种操作方式，
1）git config --global core.excludesfile ~/.gitignore_global
2）在家目录找到 .gitconfig 文件，在文件末尾手动添加如下内容，
```
[core]
excludesfile = /Users/yj/.gitignore_global
```


同时 Mac 最好执行下 `defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE`，表示不再生成 DS 文件。（这种方式不一定生效）
