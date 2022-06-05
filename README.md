# Linux Deepspeech Dictation

This program will allow you to dictate into your linux computer and have text inputed into the window of focus!

When the program is running, start and stop dictation by pressing the right + hotkey.

# Dependancies

- Ubuntu 20.0.4

# Install

This will install all dependancies:
- xdotool
- python3
- python3 packages
- Deepspeech

`./dictate.sh install`

# Start

Now press the right + key to start and stop dictating. Anything you say will be input into the window of focus.

`./dictate.sh start`

## TODO

1. Allow for punctionation marks (.,:() etc)
2. When + key is pressed then turn on and off speach and input
3. Test in various windows: browsers (url bar, forms, text input, notion, google docs, gmail, taiga, discord, rocket chat), VS code, text editors, Libre office word and sheet
4. Add command to feed a "correction" of selected wrong text back into the model
