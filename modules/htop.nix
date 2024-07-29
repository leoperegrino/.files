{pkgs, lib, config, ...}:
let
	cfg = config.modules.htop;
in {

	options = {
		modules.htop.enable = lib.mkEnableOption "htop";
	};

	config = lib.mkIf cfg.enable {
		programs.htop = {
			enable = true;
			package = pkgs.htop-vim;
			settings = {
				hide_kernel_threads = true;
				hide_userland_threads = true;
				tree_view = true;
				all_branches_collapsed = true;
				highlight_base_name = true;
				highlight_megabytes = 1;
				show_program_path = false;
				fields = with config.lib.htop.fields; [
					PID
					USER
					# PRIORITY
					# NICE
					M_SIZE
					M_RESIDENT
					M_SHARE
					STATE
					PERCENT_CPU
					PERCENT_MEM
					TIME
					COMM
				];
			} // (with config.lib.htop; leftMeters [
				(bar "AllCPUs")
				(bar "Memory")
			]) // (with config.lib.htop; rightMeters [
				(text "DateTime")
				(text "System")
				(text "Battery")
				(text "Uptime")
				(text "Blank")
				(text "DiskIO")
				(text "NetworkIO")
			]);
		};
	};

}
