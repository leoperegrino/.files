{
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./modules
	];

	modules.bat.enable = true;
	modules.git.enable = true;
	modules.gpg.enable = true;
	modules.nvim.enable = true;
	modules.ranger.enable = true;
	modules.xdg.enable = true;
	modules.htop.enable = true;

	home.username = "pi";
	home.homeDirectory = "/home/pi";

	programs.home-manager.enable = true;


	home.packages = with pkgs; [
	];

	systemd.user.startServices = "sd-switch";

	# https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "23.11";
}
