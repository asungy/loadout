# Pinyin Keyboard

The system configurations are already set to make Pinyin available using ibus.
Note: Hyprland and ibus have their own separate keyboard configurations.

To enable, Pinyin (and disable US), an instance of the ibus engine needs to be
running:
```shell
ibus start
```

Once the ibus engine is running, the Pinyin engine needs to be set:
```shell
ibus engine libpinyin
```

Pinyin won't work in certain applications like the terminal but they should
work in the browser and Obsidian.
