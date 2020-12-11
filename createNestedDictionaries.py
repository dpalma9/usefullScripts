test = {}
test[key1] = {}
test[key1]['status'] = 'OK'
test[key2] = {}
test[key2]['status'] = 'NO OK'
test[key2]['details'] = 'Lo que sea'
print(test)
{'PRE-AA-internet': {'status': 'OK'}, 'PRE-AA-intranet': {'status': 'NO OK', 'details': 'Lo que sea'}}
