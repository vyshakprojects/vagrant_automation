import sys


def main():
    prop_file_path =  sys.argv[1]
    replace_file_path = sys.argv[2]
    propMap = convertPropTODict(prop_file_path)
    replaceProp(replace_file_path,propMap)

def convertPropTODict(prop_file_path):
    property_dict = {}
    with open(prop_file_path,"r") as f:
        lines = f.readlines()
        for line in lines:
            result = line.strip().split("=")
            property_dict.update({"$"+result[0]:result[1]})
    return property_dict


def replaceProp(replace_file_path,propMap):
    with open(replace_file_path,"r") as f:
        text = f.read()

    for key,value in propMap.items():
        text = text.replace(key,value)

    with open(replace_file_path,"w") as f:
        f.write(text)

main()
