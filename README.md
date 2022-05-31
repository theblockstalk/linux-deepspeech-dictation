# linux-deepspeech

## Dependancies

Step 1: Install Deepspeech
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

Step 2: Download the DeepSpeech examples
```
git clone https://github.com/mozilla/DeepSpeech-examples
```

Step 3: Modify to allow for text to windown input
```
cd DeepSpeech-examples/mic_vad_streaming
nano mic_vad_streaming.py
```

### Run
```
python mic_vad_straming.py --model ~/deepspeech-0.9.3-models.pbmm --scorer ~/deepspeech-0.9.3-models.scorer
```


