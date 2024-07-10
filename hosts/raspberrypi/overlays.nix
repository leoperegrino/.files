{ config, pkgs, lib, ... }:
{
	# https://github.com/NixOS/nixpkgs/issues/126755#issuecomment-869149243
	nixpkgs.overlays = [
		(final: super: {
		 makeModulesClosure = x:
		 super.makeModulesClosure (x // { allowMissing = true; });
		 })
	];
}
