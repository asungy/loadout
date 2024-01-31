# Change Default Audio Source

List the available audio sinks.

```shell
> wpctl status
...
 ├─ Sinks:
 │  *   38. Built-in Audio Analog Stereo        [vol: 1.15]
 │      75. USB Audio Headphones                [vol: 0.29]
 │      77. USB Audio Line Out                  [vol: 0.40]
...
```

Set the default audio sink.

```shell
> wpctl set-default 75
```
