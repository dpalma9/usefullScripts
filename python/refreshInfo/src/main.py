import time

class MiClase:
    def __init__(self, nombre):
        self.nombre = nombre
        self.tiempo = 0
        self.token = ""

    def _esta_el_token_caducado(self):
        print("Entro en _esta_el_token_caducado")
        print("Tiempo vale: " + str(self.tiempo))
        if self.tiempo <= 0:
            return True
        else:
            return False
    
    def _pedir_nuevo_token(self):
        print("Entro en _pedir_nuevo_token")
        print("Tiempo vale: " + str(self.tiempo))
        self.tiempo = 10
        self.token = "TOKEN"

    def _necesito_mas_tiempo(self):
        print("Entro en _necesito_mas_tiempo")
        print("Tiempo vale: " + str(self.tiempo))
        if self.tiempo <= 0:
            return True
        else:
            return False

    def generar_token(self):
        print("Entro en generar_token")
        print("Tiempo vale: " + str(self.tiempo))
        self.token = "TOKEN RENOVADO"
        self.tiempo = 10

    def dame_mi_token(self):

        if self._esta_el_token_caducado():
            self._pedir_nuevo_token()

        if self._necesito_mas_tiempo():
            self.generar_token()
        
        print("Hola, " + self.nombre + ". Tu token es: " + self.token)
        self.tiempo = self.tiempo - 5
        

# Main:
prueba = MiClase("Dani")
prueba.dame_mi_token()
time.sleep(5)
prueba.dame_mi_token()
time.sleep(5)
prueba.dame_mi_token()
time.sleep(5)