from threading import Thread
import time

class ThreadWithReturnValue(Thread):
    
    def __init__(self, group=None, target=None, name=None,
                 args=(), kwargs={}, Verbose=None):
        Thread.__init__(self, group, target, name, args, kwargs)
        self._return = None

    def run(self):
        if self._target is not None:
            self._return = self._target(*self._args,
                                                **self._kwargs)
    def join(self, *args):
        Thread.join(self, *args)
        return self._return

def func1():
    time.sleep(2)
    print("Estoy en func 1")
    return "valor1"

def func2():
    print("Estoy en func 2")
    return "valor2"


# Creamos dos hilos y los iniciamos
hilo1 = ThreadWithReturnValue(target=func1)
hilo2 = ThreadWithReturnValue(target=func2)
hilo1.start()
hilo2.start()

# Esperamos a que los hilos terminen
var1 = hilo1.join()
var2 = hilo2.join()

# Printamos lo recogido
print(var1)
print(var2)

# Cuando los hilos han terminado, finalizamos el programa
print("Salimos del programa")