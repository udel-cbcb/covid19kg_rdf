import os
import json
for file in os.listdir("./litcovid2BioC"):
    if file.endswith(".json"):
        # Opening JSON file
        f = open(os.path.join("./litcovid2BioC", file))
  
        # returns JSON object as 
        # a dictionary
        data = json.load(f)
  
        print(data['_id'])
  
        # Closing file
        f.close()
