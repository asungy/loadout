# Change Default Audio Source

List the available audio sources.

```shell
> wpctl status
...
 ├─ Sources:
 │      66. Built-in Audio Analog Stereo        [vol: 0.31]
 │  *   76. USB Audio Headset Microphone        [vol: 1.00]
 │      79. C920 PRO HD Webcam Analog Stereo    [vol: 0.71]
...
```

Set the default audio source.

```shell
> wpctl set-default 66
```
