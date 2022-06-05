# Linux Deepspeech Dictation

This program will allow you to dictate into your linux computer and have text inputed into the window of focus!

## Dependancies

Step 1: Install xdotool (alternatively need to use [waylan](https://wayland.app/protocols/text-input-unstable-v3#zwp_text_input_v3:event:commit_string) if your system uses this)
```
sudo apt install -y xdotool
```

Step 2: Install python (use optional virtual environment)
```
sudo apt install -y python3-virtualenv
```

Step 3: Install Deepspeech
https://deepspeech.readthedocs.io/en/r0.9/?badge=latest
```
# Create and activate a virtualenv
virtualenv -p python3 $HOME/tmp/deepspeech-venv/
source $HOME/tmp/deepspeech-venv/bin/activate

# Install DeepSpeech
pip3 install deepspeech

# Download pre-trained English model files
curl -LO https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-models.pbmm
curl -LO https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-models.scorer
```

Step 4: Download the DeepSpeech examples
```
git clone https://github.com/mozilla/DeepSpeech-examples
```

Step 5: Modify the realtime speach recognition example `mic_vad_streaming` to output the text into the currently focued windown using `xdotool`
```
cd DeepSpeech-examples/mic_vad_streaming
nano mic_vad_streaming.py
```

Add import at top
```
import subprocess
```

Add new line after L195
```
text = stream_context.finishStream()
print("Recognized: %s" % text) # You can delete this line if you want
subprocess.call(["xdotool", "type", text]) # add this line
stream_context = model.createStream()
```

Step 6: Install dependancies for `mid_val_streaming` (see README.rst)
```
sudo apt install portaudio19-dev -y
pip install -r requirements.txt
```

### Run
```
python mic_vad_streaming.py --model ~/deepspeech-0.9.3-models.pbmm --scorer ~/deepspeech-0.9.3-models.scorer
```