echo "Updating system using flake $(hostname) on $(hostname)"

cd ~/Atelier-Iris

echo "Current Git Status"
git status

echo "System Update"
sudo nixos-rebuild switch --flake ~/Atelier-Iris/#$(hostname)
