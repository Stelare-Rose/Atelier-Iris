echo "Updating system using flake $(hostname) on $(hostname)"

cd ~/Lunelle

stow -t ~ home

echo "Current Git Status"
git status

echo "System Update"
sudo nixos-rebuild switch --flake ~/Lunelle/#$(hostname)
