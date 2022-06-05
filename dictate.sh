#!/bin/bash

ARG1=$1

# Make sure working dir is same as this dir, so that script can be excuted from another working directory
PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

set -u ## exit the script if you try to use an uninitialised variable
set -e ## exit the script if any statement returns a non-true return value

function install {
    echo "Installing xdottool"
    sudo apt install -y xdotool

    echo "Installing python3"
    sudo apt install -y python3 python3-pip
    
    echo "Install DeepSpeech"
    pip3 install deepspeech

    echo "Download pre-trained English model files"
    set +e
    mkdir data
    set -e
    curl -L -o data/deepspeech-0.9.3-models.pbmm https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-models.pbmm
    curl -L -o data/deepspeech-0.9.3-models.scorer https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-models.scorer

    echo "Installing mic_vad_straming python dependancy: portaudio19"
    sudo apt install portaudio19-dev -y

    echo "Installing mic_vad_straming python dependancies"
    cd ${PARENT_PATH}/mic_vad_streaming
    pip3 install -r requirements.txt
}

function start {
    echo "Starting dictate"
    python3 ${PARENT_PATH}/mic_vad_streaming/mic_vad_streaming.py \
        --model ${PARENT_PATH}/data/deepspeech-0.9.3-models.pbmm \
        --scorer ${PARENT_PATH}/data/deepspeech-0.9.3-models.scorer &>> ${PARENT_PATH}/data/dictate.log &
    echo $! > ${PARENT_PATH}/data/pid.txt
}

function stop {
    echo "Stopping dictate"
    PID=`cat ${PARENT_PATH}/data/pid.txt`
    echo "Killing process with pid=${PID}"
    pkill ${PID}
}

function help {
    echo ""
    echo "Usage:"
    echo "    dictate.sh [command]"
    echo ""
    echo "Commands:"
    echo "    install - installs all prerequisits for an Ubuntu 20.0.4 machine"
    echo "    start   - starts dictation with hotkey"
    echo "    stop    - stops dictation with hotkey"
}

if [ -z "${ARG1}" ]; then
    help
elif [ "${ARG1}" == "install" ]; then
    install
elif [ "${ARG1}" == "start" ]; then
    start
elif [ "${ARG1}" == "stop" ]; then
    stop
else
    help
fi