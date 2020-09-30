# 使用 stow 管理 dotfiles



管理配置文件的困难之处在于，版本管理工具如 Git 管理的话会非常方便，但是这些配置文件大部分都位于家目录的顶级目录下， **在这个位置不太适合初始化一个版本管理仓库**。



有很多工具被设计出来解决这个问题，基本思路都是把这些配置文件安置在某个下级目录中，然后安装或者链接这些文件到它们应该在的位置。 但是这些工具有两个最主要缺点：

- 有很多依赖。比如 Ruby 和一大坨库。
- 有不低的学习成本，因此需要记住如何用它。但是同步和修改配置算是低频场景了，因此要记住各自工具的用法真的挺难。



stow 就提供了一种外部依赖少、学习成本低的方式。



将配置文件处理成如下的格式，

```
home目录/
  dotfiles/
    bash/
      .bashrc
      .bash_profile
      .bash_logout
    vim/
      .vim/
      .vimrc
    emacs/
      .emacs.d/
    zshell/
      .zshrc
```



然后在 `home目录/dotfiles` 下，执行例如 `stow emacs` 即可自动将 `.emacs.d` 链接到家目录下，执行例如 `stow vim ` `stow zshell` 等同理。



具体详见 http://farseerfc.me/zhs/using-gnu-stow-to-manage-your-dotfiles.html





# 编辑器们的快捷键怎么设置更容易记忆且不冲突？


该问题本质上是一个如何组织和分类的问题，一个好的组织和分类的前提下，每一个分类公用一个前缀，会让快捷键更加方便记忆、归纳和管理。个人觉得编辑器的功能可以分为如下几类，其中 1-9 是 general 部分，即各个编辑器都会有。

一、basic editing

二、cursor and selection 
- basic cursor movement
- multi cursor
- expand region

三、search/grep and replace 
- grep in project
- grep in single file

四、programming language editing 
- suggestions
- document
- definitions
- references
- LSP about


五、navigation
- go to symbol
- previous/next cursor position


六、file management
- new/open/save/close file
- recent open files
- find file in project/directory


七、display
- zoom in/out
- show search
- fonts
- themes
- powerline


八、debug
九、execution
十、buffer
十一、window
十二、TODO



