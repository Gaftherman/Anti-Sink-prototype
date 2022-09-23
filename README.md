# Anti-Sink-prototype
> Based on Cubemath's SinkingShip0~3.

## Installation Guide

[Download this repository](https://github.com/Gaftherman/Anti-Sink-prototype/archive/refs/heads/main.zip) and extract it's contents inside `Steam\steamapps\common\Sven Co-op\svencoop\`

That should look like this:

```
└── 📁svencoop
    └── 📁scripts
        └── 📁plugins
            └── 📁Gaftherman
                └── 📄Anti-Sink.as      
```

Now, in the default_plugins.txt. 

> In the case you don't know where is the default_plugins.txt x[
```
└── 📁svencoop
     └── 📄default_plugins.txt
```

Add this
```
"plugin"
{
	"name" "Anti-Sink"
	"script" "Gaftherman/Anti-Sink"
} 
```

And there is, you installed this prototype. 🎉🎉🎉🎉🎉🎉

This is a prototype that tries to solve that, every time a player dies, they get trapped in the ground, sinking, making it impossible to revive them.

And seeing that Cubemath's Anti-Sink works "good" I tried to do some improvments.

## What is new/changed in this script?

- 🛠Instead of doing a "for" for all entities and make "microlags", we now only search for entities named "deadplayer".

- 💡In the old anti-sink, every time a player died and remained underground, It went up 128 units to avoid sinking but with this the body went solid blocking the way. So, I tried to fix it making the deadplayer's body no-solid. I didn't tested this script to much, so still in prototype.

## Credits

* Base of this code [Cubemath SinkingShip3 plugin](https://github.com/CubeMath/UCHFastDL2/blob/master/svencoop/scripts/plugins/cubemath/SinkingShip3.as)

Any features/feedback to add please contact me `Gaftherman#0231` or join to this discord channel [Discord server](https://discord.gg/VsNnE3A7j8).
Thx for read this :D
