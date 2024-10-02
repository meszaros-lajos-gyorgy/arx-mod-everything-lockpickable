# Everything lockpickable mod for Arx Fatalis

This mod makes doors and other locked things which were previously impossible to open by the player
possible to open with lockpicking.

## Installation

Unpack the contents of this zip and add it into your Arx Fatalis/Arx Libertatis game's root folder.

Using [Fredlllll's Arx Libertatis mod manager](https://github.com/fredlllll/ArxLibertatisModManager) is recommended for easy install and uninstall.

## Features

The following places are now accessible with lockpicking:

- Alicia's house (city of Arx)
- Gary's home (city of Arx)
- Gary's treasury (city of Arx)
- home across Gary's bank (city of Arx)
- Maria's shop (city of Arx)
- 2 homes across Maria's shop (city of Arx)
- Miguel's smithy (city of Arx)
- Tafiok's shop (city of Arx)
- gate behind Gladivir's puzzle (crypts level 3)

... and many more!

_TODO: add a complete list of doors and locks that have been changed_

## How it works

Lockpicking success is determined by the following factors:

```
if
  player's mechanical skills > lockpickability of door/lock
then
  chance = mechanical - lockpickability + 20

100 chance = 100% success in picking a lock
```

To have a 100% success rate for picking a lock
have 80 points of mechanical skills above the
lock's own lockpickability.

For maximum lockpickability (99) you need to have
179 mechanical skills if you want 100% success rate.

Keep in mind, that the bless spell (mega + stregum + vitae)
also boosts the mechanical skills temporarily!

Fun fact: anything locked with the lockpickability of 100 is treated
as unpickable by the Arx engine. These doors/locks have been changed
to have 99 instead of 100.

Tips: you can give yourself lockpicks with the following command:

`inventory playeradd provisions/lockpicks/lockpicks`

## Links

Check out other mods, maps and tools here: https://arx-tools.github.io/
