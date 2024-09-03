1. Install NixOS.
2. Install `git` temporarily: `nix-shell -p git`
3. Clone the repo into `~/.config/nixos`: 
```
git clone https://github.com/k-dx/nixos-config.git ~/.config/nixos
```
4. Compare and choose apropriate `hardware-configuration.nix` (one created by installer vs one from repo). Move it into `~/.config/nixos`.
5. ??? Remove old configuration: 
```
sudo rm -rf /etc/nixos
```
6. Symlink `/etc/nixos` to `~/.config/nixos`: 
```
ln -s ~/.config/nixos /etc/nixos 
```
7. Rebuild the configuration: `./rebuild.sh`
8. You should be good to go!