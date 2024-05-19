{
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./modules
	];

	home.username = "ltp";
	home.homeDirectory = "/home/ltp";
	ltp.enable = true;

	programs.home-manager.enable = true;


	home.packages = with pkgs; [
		brave
		jellyfin-media-player
		mupdf
		zathura
		keepassxc
		yt-dlp
		nodejs
		unzip
		cargo
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		(nerdfonts.override { fonts = [ "Noto" ]; })
	];

	systemd.user.startServices = "sd-switch";

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "23.11";
}
