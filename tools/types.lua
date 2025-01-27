-- This file is part of gigatools.
--
-- Copyright (c) 2024-2025 ona-li-toki-e-jan-Epiphany-tawa-mi
--
-- gigatools is free software: you can redistribute it and/or modify it under
-- the terms of the GNU Lesser General Public License as published by the Free
-- Software Foundation, either version 3 of the License, or (at your option) any
-- later version.
--
-- gigatools is distributed in the hope that it will be useful, but WITHOUT ANY
-- WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
-- A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
-- details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with gigatools. If not, see <https://www.gnu.org/licenses/>.

--- Common type aliases for lua-language-server static type checking.

--------------------------------------------------------------------------------
-- Core                                                                       --
--------------------------------------------------------------------------------

--- @alias ObjectRef {
---     get_wielded_item: (fun(self: ObjectRef): ItemStack),
---     get_pos: (fun(self: ObjectRef): Vector),
---     add_velocity: fun(self: ObjectRef, vel: Vector),
--- }
--- @alias Player ObjectRef

--- @alias ToolCapabilities {}
--- @alias ItemStack {
---     get_name: (fun(self: ItemStack): string),
--- }

--- @alias GameInfo {
---     id: string,
--- }

--- @type {
---     registered_aliases: table<string, string>,
---     get_modpath: (fun(modname: string): string|nil),
---     get_game_info: (fun(): GameInfo),
---     register_on_punchplayer: fun(callback: fun(player: Player, hitter: Player|nil, time_from_last_punch: number|nil, tool_capabilities: ToolCapabilities|nil, dir: Vector, damage: number)),
--- }
core = {}

--- @param table table
--- @param other_table table
--- @return table
function table.insert_all(table, other_table) return {} end

--- @param list any[]
--- @param val any
--- @return integer
function table.indexof(list, val) return 0 end

--- @alias Vector { x: integer, y: integer, z: integer }

--- @type {
---     direction: (fun(p1: Vector, p2: Vector): Vector),
---     multiply: (fun(v: Vector, s: number): Vector),
--- }
vector = {}

--------------------------------------------------------------------------------
-- Mineclonia, VoxeLibre, etc.                                                --
--------------------------------------------------------------------------------

--- @alias PlayerDamageReason {
---     type: "player",
---     source: Player,
--- }
--- @alias DamageReason { type: string } | PlayerDamageReason

--- @type {
---     register_on_damage: fun(callback: fun(obj: ObjectRef, damage: number, reason: DamageReason)),
--- }
mcl_damage = {}

--- @alias ExplosionInfo {
---     fire?: boolean,
--- }

--- @type {
---     explode: fun(pos: Vector, strength: number, info: ExplosionInfo, puncher?: ObjectRef),
--- }
mcl_explosions = {}
