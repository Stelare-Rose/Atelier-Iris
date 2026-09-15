function gc --wraps='sudo nix-collect-garbage -d' --description 'alias gc=sudo nix-collect-garbage -d'
  sudo nix-collect-garbage -d $argv
        
end
