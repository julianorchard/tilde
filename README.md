<!---------------------------------------------------------------------------->

<div dir="rtl">
  <sub>
    <sup>
      <i>this character isn't actually a tilde</i>
    </sup>
  </sub>
</div>

<h1 align="center">
  <b>〜</b>
</h1>

<!---------------------------------------------------------------------------->

> There's no place like ~

I use a bare repo to sync the dotfiles.

<!---------------------------------------------------------------------------->

## Applications

| Application | Name |
| ----------- | ---- |
| Browser | Firefox |
| Compositor | Picom |
| Editor | Neovim |
| Image Viewer | SXIV |
| PDF Viwer | Zathura |
| Terminal | Kitty |
| Window Manager | Awesome |

<!---------------------------------------------------------------------------->

## Installation

```
git clone --bare git@github.com:julianorchard/tilde.git ${HOME}/.config/.rice/

git --git-dir=$HOME/.config/.rice/ --work-tree=$HOME' checkout

.local/bin/ricer
```

(I change machines *very* infrequently, so this is quite untested...)

