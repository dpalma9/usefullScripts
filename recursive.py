import json

def extract_values(obj, key):
    arr = []

    def extract(obj, arr, key):
        ## return the value from a searched key
        if isinstance(obj, dict):
            for k, v in obj.items():
                if str(k) == str(key):
                    arr.append(v)
                elif isinstance(v, (dict, list)):
                    extract(v, arr, key)
        elif isinstance(obj, list):
            for item in obj:
                extract(item, arr, key)
        #return arr
        return obj

    def get_tree(obj, arr, key):
        ## Return all the parents keys of a subkey
        if isinstance(obj, dict):
            for k, v in obj.items():
                if key in str(v) and key != str(k):
                    #print(str(k))
                    arr.append(k)
                if isinstance(v, (dict, list)) and key != str(k):
                    get_tree(v, arr, key)
        #elif isinstance(obj, list):
        return arr

    results = extract(obj, arr, key)
    #results = get_tree(obj, arr, key)
    return results

def read_data(_data):
     with open(_data) as f:
         body = f.read()
     return body

schema=json.loads(read_data("someFile.json"))
final = extract_values(schema,"value")
