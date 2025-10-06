import json

from nudenet import NudeClassifier  # or wherever your NudeClassifier is

# Load the JSON
with open("/home/shin/.config/illogical-impulse/config.json") as f:
    data = json.load(f)

# Get the path
img_path = data["background"]["wallpaperPath"]

# Classify
result = NudeClassifier().classify(img_path)
print(result)
