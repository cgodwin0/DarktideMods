local mod = get_mod("TreeScan_Helper")
-- Darktide features several minigames for side-mission objectives. Currently there exists
-- a mod 'Decode_Helper' to show users which targets to select in one RNG minigame type for
-- faster completion of the side-mission. TreeScan_Helper adds new, but similar functionality 
-- to the tree 'Drill' event at the end of the Hab Dreyko level.

-- Hook into _update_target to render correct scan target on minigame scanner UI refresh
mod:hook_safe(CLASS.MinigameDrillView, "_update_target", function(self, widgets_by_name, minigame, t)
	local stage = minigame:current_stage()

	-- Target widgets are a table of 3 total correct scannable targets
	if self._target_widgets == nil then
		return
	end

	-- Stage equals the step in the scan process from 0-2, return if we're done scanning
	if not stage or stage > #self._target_widgets then
		return
	end

	-- Ensure we have target widgets left to render, game sometimes only requires 2 total
	local target_widgets = self._target_widgets[stage]
	if target_widgets == nil then
		return
	end

	-- Set the correct widget to have a white outline, differentiating it from the incorrect ones
	local correct_target = minigame:correct_targets()[stage]
	local widget = target_widgets[correct_target]
	widget.style.highlight.color = {
		255,
		255,
		255,
		255,
	}
end)
