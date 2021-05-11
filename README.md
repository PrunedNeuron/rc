`64 6F 74 66 69 6C 65 73`

```
     _       _    __ _ _           
  __| | ___ | |_ / _(_) | ___  ___ 
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
                                   
```

The dotfiles I use on a daily basis, managed with GNU Stow.

## Prerequisites
- [GNU Stow](https://www.gnu.org/software/stow/)

  If you're using Arch Linux like me, just run `sudo pacman -S stow` or if you prefer, `yay -S stow`.

## Installation
Since this is a template repository, feel free to create your own dotfiles repository using this as a starter.

### Install a specific directory/package
1. Clone this repository (or your own if you used this as a template) in your home directory
  ```sh
    git clone https://github.com/PrunedNeuron/.dotfiles.git
  ```
  or if you want to use a different name for the dotfiles directory,
  ```sh
    git clone https://github.com/PrunedNeuron/.dotfiles.git <directory-name>
  ```
2. cd into the dotfiles directory
  ```sh
    cd ~/.dotfiles
  ```
  or
  ```sh
    cd ~/<directory-name>
  ```
3. Install the package/directory that you want (replace `home` with `root` if your desired package is in the root directory)
  ```sh
    stow -d home -t $HOME -S <package-name>
  ```
  For example, if you wanted to install the dotfiles for `zsh`, run
  ```sh
    stow -d home -t $HOME -S zsh
  ```
  
## Contribute
- Feel free to share your thoughts about this repository (on the [discussions tab](https://github.com/PrunedNeuron/.dotfiles/discussions)).
- I'm open to ideas, suggestions and critique
- If you see something wrong with my dotfiles, feel free to open an issue or participate in the discussion
