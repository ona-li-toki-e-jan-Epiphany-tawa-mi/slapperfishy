![screenshot](screenshot.png)

# Slapperfishy

A mod for Luanti [https://www.luanti.org](https://www.luanti.org/) that makes
fish explosive when used as a melee weapon.

Known to work with the following games:

- Mineclonia - [https://content.luanti.org/packages/ryvnf/mineclonia/](https://content.luanti.org/packages/ryvnf/mineclonia/)
- VoxeLibre - [https://content.luanti.org/packages/Wuzzy/mineclone2](https://content.luanti.org/packages/Wuzzy/mineclone2)

Note for VoxeLibre: fish slapping only works against other players.

## How to install

You can install it from ContentDB
[https://content.luanti.org/packages/ona-li-toki-e-jan-Epiphany-tawa-mi/slapperfishy](https://content.luanti.org/packages/ona-li-toki-e-jan-Epiphany-tawa-mi/slapperfishy/).

Or, you can place this directory, or symlink it, into the mods folder in your Luanti
directory.

## How to test

Dependencies:

- Lua - [https://www.lua.org](https://www.lua.org/)
- lua-language-server - [https://github.com/LuaLS/lua-language-server](https://github.com/LuaLS/lua-language-server)

There is a `flake.nix` you can use with `nix develop` to generate a development
enviroment.

Then, run the following command(s):

```sh
tools/static-analysis.lua
```

---

ante ni tawa musi Luanti [https://www.luanti.org](https://www.luanti.org/) li
pali e ni: kala li kepeken sama ilo utala la ona li pakala wawa.

ona li pali kin lon musi ni:

- musi Mineclonia - [https://content.luanti.org/packages/ryvnf/mineclonia/](https://content.luanti.org/packages/ryvnf/mineclonia/)
- musi VoxeLibre - [https://content.luanti.org/packages/Wuzzy/mineclone2](https://content.luanti.org/packages/Wuzzy/mineclone2)

musi VoxeLibre la kala li pakala wawa kepeken jan taso.

## nasin kepeken

sina ken kama jo e ona tan poki ContentDB
[https://content.luanti.org/packages/ona-li-toki-e-jan-Epiphany-tawa-mi/slapperfishy](https://content.luanti.org/packages/ona-li-toki-e-jan-Epiphany-tawa-mi/slapperfishy/).

anu, sina ken pana e poki ni lon poki lipu sina pi ante pi musi Luanti.

## nasin pi kama sona e ni: ante ni li pali pona.

ijo wile:

- ilo Lua - [https://www.lua.org](https://www.lua.org/)
- ilo lua-language-server - [https://github.com/LuaLS/lua-language-server](https://github.com/LuaLS/lua-language-server)

tawa kama jo e ona la sina ken kepeken e nimi lawa `nix develop` kepeken lipu
`flake.nix`.

ni la o kepeken e nimi lawa ni:

```sh
tools/static-analysis.lua
```
