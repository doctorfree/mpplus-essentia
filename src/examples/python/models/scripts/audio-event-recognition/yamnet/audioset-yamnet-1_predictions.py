from essentia.standard import MonoLoader, TensorflowPredictVGGish

audio = MonoLoader(filename="audio.wav", sampleRate=16000)()
model = TensorflowPredictVGGish(graphFilename="audioset-yamnet-1.pb", input="melspectrogram", output="activations")
predictions = model(audio)
