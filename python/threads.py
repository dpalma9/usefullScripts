from threading import Thread
import time

def func1():
    time.sleep(2)
    print("Estoy en func 1")

def func2():
    print("Estoy en func 2")


# Creamos dos hilos y los iniciamos
#Thread(target = func1).start()
#Thread(target = func2).start()
hilo1 = Thread(target = func1)
hilo2 = Thread(target = func2)
hilo1.start()
hilo2.start()

# Esperamos a que los hilos terminen
hilo1.join()
hilo2.join()

# Cuando los hilos han terminado, finalizamos el programa
print("Salimos del programa")