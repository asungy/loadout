# xrandr

When using X server, it might be useful to turn off the laptop monitor. This
can be accomplished by getting the display ID via:
```shell
xrandr
```

And then:
```shell
xrandr --output <display-id> --off
```

To turn it back on again:
```shell
xrandr --output <display-id> --auto
```
