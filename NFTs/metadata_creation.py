import json 

# Variables
collection_size = 8 # Collection size
description = "Baker Boys Collection!" # Description
image = "https://gateway.pinata.cloud/ipfs/QmeXGG8jd5tzaexMkicsomhEN3HifF4MhLLAQTHHCfTy1x/" # Image Link (IPFS Link)
name = "Baker Boy" # Name

# Metadata Template
metadata_template = {
    "name": "",
    "description": "",
    "image": ""
}

# Metadata Creation
for i in range(1,collection_size + 1):
    nft_metadata = metadata_template
    metadata_filename = str(i) + ".json"
    nft_metadata["name"] = name + " #" + str(i)
    nft_metadata["description"] = description
    nft_metadata["image"] = image + str(i) + ".jpg"
    with open(metadata_filename, "w") as file:
        json.dump(nft_metadata,file)