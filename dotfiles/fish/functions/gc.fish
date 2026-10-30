function gc --wraps='sudo nix-collect-garbage -d' --description 'alias gc=sudo nix-collect-garbage -d'
  echo "root: $(sudo nix-collect-garbage -d  2>&1 $argv | tail -n1)"
  echo "user: $(nix-collect-garbage -d  2>&1 $argv | tail -n1)"
        
end
