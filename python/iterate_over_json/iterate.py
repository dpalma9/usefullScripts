import json

def check():
  f = open('file.json')
  data = json.load(f)
  review = False

  for metric in data['data']['result']:
    print(metric['value'][1])
    print ("---------------------------------")
    print(str(type(metric['value'][1])))
    if metric['value'][1] == "11":
      review = True
      print("ENTROOOOOOOOOOOOOOOOOOOOOOOOOO")
      break

  if review != False:
    return "OJO"
  else:
    return "Todo OK"

print(check())
