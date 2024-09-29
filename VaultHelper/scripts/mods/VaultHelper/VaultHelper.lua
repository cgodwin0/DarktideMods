local mod = get_mod("VaultHelper")
-- Darktide features a randomly spawned event system. In certain events, objective luggables spawn
-- inside 'Vaults' that users must open to determine if one of the objectives is inside.
-- VaultHelper shows clients which 'Vaults' contain these objectives, enabling faster objective completion
-- for use cases like speedrunning or more relaxing casual gameplay

-- Table of luggable objective units that are spawned on 'init' call of LuggableExtension
local objective_units = {}

mod:hook_safe(CLASS.LuggableExtension, "init", function (self, extension_init_context, unit, ...)
	table.insert(objective_units, unit)
end)

-- When the game server calls 'add_marker' upon generating a new mission objective, 
-- additionally show all non-battery luggable objective units that can be interacted with
mod:hook_safe(CLASS.MissionObjectiveSystem, "add_marker", function (self, objective_name, ...)
	-- do nothing if no luggable objective units have been spawned
	if not objective_units then
		return
	end

	-- If there's no current active objective, return (often happens upon level load init)
	local objective = self._active_objectives[objective_name]
	if objective == nil then
		return
	end

	-- For each luggable objective unit spawned, check if the unit is despawned
	-- then, ensuring each is actually a mission objective and not a health battery,
	-- add a marker to the unit, revealing its location to the client
	for i = 1, #objective_units do
		local objective_unit = objective_units[i]
		if objective_unit ~= nil and not objective_unit.__deleted then
			if ScriptUnit.has_extension(objective_unit, 'mission_objective_target_system') then
				local unit_type = Unit.get_data(objective_unit, "pickup_type")
				if unit_type ~= "battery_01_luggable" then
					objective:add_marker(objective_unit)
				end
			end
		end
	end
end)

-- When the mission objective ends, we need to clear out objective_units to prevent increasing memory usage
mod:hook_safe(CLASS.MissionObjectiveSystem, "end_mission_objective", function (self, objective_name)
	if not objective_units then
		return
	end

	-- On the 'Excise Vault' map, the mission objective system spawns in luggable units before pressing
	-- the vault panel button, bypass the objective_units cleanup in this case to keep showing the
	-- mission objective luggables after the button press event.
	if objective_name ~= nil and objective_name == "objective_lm_scavenge_interact_vaults_panel" then
		return
	end

	objective_units = {}
end)
