import concurrent.futures
import time

def func1():
    time.sleep(2)
    print("Estoy en func 1")
    return "valor1"

def func2():
    print("Estoy en func 2")
    return "valor2"


# Creamos concurrencia
with concurrent.futures.ThreadPoolExecutor() as executor:
    hilo1 =  executor.submit(func1)
    hilo2 =  executor.submit(func2)
    return_value1 = hilo1.result()
    return_value2 = hilo2.result()
    # Printamos valores
    print(return_value1)
    print(return_value2)


# Cuando los hilos han terminado, finalizamos el programa
print("Salimos del programa")