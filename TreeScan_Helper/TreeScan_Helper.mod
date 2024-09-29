return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`TreeScan_Helper` encountered an error loading the Darktide Mod Framework.")

		new_mod("TreeScan_Helper", {
			mod_script       = "TreeScan_Helper/scripts/mods/TreeScan_Helper/TreeScan_Helper",
			mod_data         = "TreeScan_Helper/scripts/mods/TreeScan_Helper/TreeScan_Helper_data",
			mod_localization = "TreeScan_Helper/scripts/mods/TreeScan_Helper/TreeScan_Helper_localization",
		})
	end,
	packages = {},
}
