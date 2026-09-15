function develop --wraps='nix develop -command /run/current-system/sw/bin/fish' --wraps='nix develop --command /run/current-system/sw/bin/fish' --description 'alias develop nix develop'
	nix develop -c fish
end
