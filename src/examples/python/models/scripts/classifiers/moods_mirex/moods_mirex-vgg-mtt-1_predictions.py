from essentia.standard import MonoLoader, TensorflowPredictMusiCNN

audio = MonoLoader(filename="audio.wav", sampleRate=16000)()
model = TensorflowPredictMusiCNN(graphFilename="moods_mirex-vgg-mtt-1.pb", output="model/Softmax")
predictions = model(audio)
