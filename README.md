# PC's Infinite Ammo

A Factorio mod that adds versions of all weapon ammunition (including ammo added in mods!) that can never run out/get consumed. This mod is clearly very, very cheaty, if you can't already tell.

## How it works

This mod works by iterating through all prototypes in `data.raw["ammo"]` and making a version (prefixed with `pc-unlimited-` internally) that has a magazine size of `math.huge`, which is registered as infinity in-game. It then sets the ingredients to 1x original item + 1x Stone.

## Notes

This mod has not been tested to be compatible with multiplayer, and has had no thought put into the design to make it such. Also, currently locale entries are only present for items forked from the base-game ammunition, meaning that the names of any items forked from mod ammunition will display the internal name (this does NOT affect functionality of the item, just appearance).

## Contributing

Feel free to contribute here. 

## License

This project is licensed under the MIT License.