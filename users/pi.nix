{
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		../modules
	];

	modules.enable = true;

	home.username = "pi";
	home.homeDirectory = "/home/pi";

	programs.home-manager.enable = true;


	home.packages = with pkgs; [
	];

	systemd.user.startServices = "sd-switch";

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "23.11";
}
