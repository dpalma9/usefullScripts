def a_func():
  print("I'm a func")

def b_func():
  print("I'm b func")

func_map = {"a": a_func, "b":b_func }

print("TEST 1")
func_map["a"]()

if "c" not in func_map.keys():
  print("Esa opcion no es valida")
