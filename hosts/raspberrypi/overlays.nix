{ config, pkgs, lib, ... }:
{
	nixpkgs.overlays = [
		(final: super: {
		 makeModulesClosure = x:
		 super.makeModulesClosure (x // { allowMissing = true; });
		 })
	];
}
