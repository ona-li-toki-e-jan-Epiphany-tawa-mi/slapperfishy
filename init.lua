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

--------------------------------------------------------------------------------
-- Fish Items                                                                 --
--------------------------------------------------------------------------------

--- Returns whether the mod with the given name is enabled.
--- @param name string
--- @return boolean
local function is_mod_enabled(name)
   return nil ~= core.get_modpath(name)
end

--- Fish items that can be used for explosive slapping.
--- @type table<string>
local fish_items = {}
--- Fish items that can be used for explosive slapping with added heat.
--- @type table<string>
local spicy_fish_items = {}

if is_mod_enabled("mcl_fishing") then
   table.insert_all(fish_items, {
      "mcl_fishing:clownfish_raw",
      "mcl_fishing:fish_cooked",
      "mcl_fishing:fish_raw",
      "mcl_fishing:salmon_cooked",
      "mcl_fishing:salmon_raw",
   })

   table.insert(spicy_fish_items, "mcl_fishing:pufferfish_raw")
end

if is_mod_enabled("mcl_buckets") then
   table.insert_all(fish_items, {
      "mcl_buckets:bucket_axolotl",
      "mcl_buckets:bucket_cod",
      "mcl_buckets:bucket_salmon",
      "mcl_buckets:bucket_tropical_fish",
   })
end

--------------------------------------------------------------------------------
-- Explosions                                                                 --
--------------------------------------------------------------------------------

-- Multiplier to apply to the knockback of a fish slap.
local knockback_multiplier = 100

--- Resolves item name aliases.
--- @param name string
--- @return string
local function resolve_alias(name)
   return core.registered_aliases[name] or name
end

--- Attempts to perform a fish slap explosion if the attacker wields a fish
--- item.
--- @param target Player
--- @param attacker Player
--- @param weapon_name string The resolved itemstring of the weapon.
local function try_explode(target, attacker, weapon_name)
   local is_spicy = -1 ~= table.indexof(spicy_fish_items, weapon_name)
   local is_fish = is_spicy or -1 ~= table.indexof(fish_items, weapon_name)

   if not is_fish then return end

   local target_positon = target:get_pos()
   mcl_explosions.explode(target_positon, 3, { fire = is_spicy }, attacker)
   -- Extra knockback.
   target:add_velocity(vector.multiply(
      vector.direction(attacker:get_pos(), target_positon),
      knockback_multiplier
   ))
end

--- Attempts to perform an explosion when a player fish slaps another player.
--- @param player Player
--- @param hitter Player|nil
local function explode_on_punchplayer(player, hitter, _, _, _, _)
   if nil == hitter then return end

   local weapon = resolve_alias(hitter:get_wielded_item():get_name())

   try_explode(player, hitter, weapon)
end
core.register_on_punchplayer(explode_on_punchplayer)

-- In VoxeLibre https://content.luanti.org/packages/Wuzzy/mineclone2/,
-- register_on_damage only runs the call back for players, whereas Mineclonia
-- https://content.luanti.org/packages/ryvnf/mineclonia/ runs the callback for
-- any entity that isn't a player, so we need to not register this on VoxeLibre
-- to prevent double-explosions on players.
if "mineclone2" ~= core.get_game_info().id then
   --- Attempts to perform an explosion when a player fish slaps an entity.
   --- @param object ObjectRef
   --- @param reason DamageReason
   local function explode_on_damage(object, _, reason)
      if "player" ~= reason.type then return end

      local puncher = reason.source
      local weapon = resolve_alias(puncher:get_wielded_item():get_name())

      try_explode(object, puncher, weapon)
   end
   mcl_damage.register_on_damage(explode_on_damage)
end
