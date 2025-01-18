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
-- TODO conditionally add items if mods are enabled
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
-- TODO conditionally add items if mods are enabled
local spicy_fish_items = {
   "mcl_fishing:pufferfish_raw",
}

-- TODO document
-- TODO add lots of knockback
local function try_explode(target, attacker, weapon_name)
   local is_spicy = -1 ~= table.indexof(spicy_fish_items, weapon_name)
   local is_fish = is_spicy or -1 ~= table.indexof(fish_items, weapon_name)

   if not is_fish then return end

   mcl_explosions.explode(target:get_pos(), 3, { fire = is_spicy }, attacker)
end

-- TODO document
local function on_punchplayer(player, hitter, _, _, _, _)
   if nil == hitter then return end

   local weapon = _slapperfishy.resolve_alias(
      hitter:get_wielded_item():get_name())

   try_explode(player, hitter, weapon)
end
core.register_on_punchplayer(on_punchplayer)

-- In VoxeLibre https://content.luanti.org/packages/Wuzzy/mineclone2/,
-- register_on_damage only runs the call back for players, whereas Mineclonia
-- https://content.luanti.org/packages/ryvnf/mineclonia/ runs the callback for
-- any entity that isn't a player, so we need to not register this on VoxeLibre
-- to prevent double-explosions on players.
if "mineclone2" ~= core.get_game_info().id then
   -- TODO document
   local function on_damage(object, _, reason)
      if "player" ~= reason.type then return end

      local puncher = reason.source
      local weapon = _slapperfishy.resolve_alias(
         puncher:get_wielded_item():get_name())

      try_explode(object, puncher, weapon)
   end
   mcl_damage.register_on_damage(on_damage)
end
