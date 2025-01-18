-- This file is part of slapperfishy.
--
-- Copyright (c) 2025 ona-li-toki-e-jan-Epiphany-tawa-mi
--
-- slapperfishy is free software: you can redistribute it and/or modify it
-- under the terms of the GNU Lesser General Public License as published by the
-- Free Software Foundation, either version 3 of the License, or (at your
-- option) any later version.
--
-- slapperfishy is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
-- details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with slapperfishy. If not, see <https://www.gnu.org/licenses/>.

-- Private namespace for internal functions.
local _slapperfishy = {}

--- Loads and executes an Elephant Veins Lua module.
--- @param path string The file path of the module relative to the Elephant Veins
--- mod directory.
--- @return any The return value of the Lua module.
function _slapperfishy.load_module(path)
   return loadfile(
      core.get_modpath("slapperfishy") .. "/" .. path)(_slapperfishy)
end

--- Resolves item name aliases.
--- @param name string
--- @return string
function _slapperfishy.resolve_alias(name)
   return core.registered_aliases[name] or name
end

--- Returns whether the mod with the given name is enabled.
--- @param name string
--- @return boolean
function _slapperfishy.is_mod_enabled(name)
   return nil ~= core.get_modpath(name)
end

-- TODO document
local fish_items = {
   "mcl_buckets:bucket_axolotl",
   "mcl_buckets:bucket_cod",
   "mcl_buckets:bucket_salmon",
   "mcl_buckets:bucket_tropical_fish",
   "mcl_fishing:clownfish_raw",
   "mcl_fishing:fish_cooked",
   "mcl_fishing:fish_raw",
   "mcl_fishing:salmon_cooked",
   "mcl_fishing:salmon_raw",
}

-- TODO document
local spicy_fish_items = {
   "mcl_fishing:pufferfish_raw",
}

-- TODO document
local function on_damage(object, damage, reason)
   if "player" ~= reason.type then return end

   local puncher = reason.source
   local weapon = _slapperfishy.resolve_alias(
      puncher:get_wielded_item():get_name())

   if -1 ~= table.indexof(fish_items, weapon) then
      mcl_explosions.explode(object:get_pos(), 3, {}, puncher)
   elseif -1 ~= table.indexof(spicy_fish_items, weapon) then
      mcl_explosions.explode(object:get_pos(), 3, { fire = true }, puncher)
   end
end

mcl_damage.register_on_damage(on_damage)
