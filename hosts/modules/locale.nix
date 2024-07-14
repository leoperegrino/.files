{lib, config, pkgs, ... }:
{

	time.timeZone = "America/Recife";

	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LC_ALL = "en_US.UTF-8";
			LC_ADDRESS = "pt_BR.UTF-8";
			LC_MEASUREMENT = "pt_BR.UTF-8";
			LC_MONETARY = "pt_BR.UTF-8";
			LC_NUMERIC = "pt_BR.UTF-8";
			LC_TIME = "pt_BR.UTF-8";
		};
	};

}
