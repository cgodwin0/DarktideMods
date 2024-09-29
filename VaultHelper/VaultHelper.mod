return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`VaultHelper` encountered an error loading the Darktide Mod Framework.")

		new_mod("VaultHelper", {
			mod_script       = "VaultHelper/scripts/mods/VaultHelper/VaultHelper",
			mod_data         = "VaultHelper/scripts/mods/VaultHelper/VaultHelper_data",
			mod_localization = "VaultHelper/scripts/mods/VaultHelper/VaultHelper_localization",
		})
	end,
	packages = {},
}
