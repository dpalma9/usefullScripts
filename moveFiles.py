import os
import shutil

def change_name(dataPath):
  for dirname, dirnames, filenames in os.walk(dataPath):
    for filename in filenames:
       #print("pathName: " + os.path.basename(os.path.normpath(dirname)))
       pathName=os.path.basename(os.path.normpath(dirname))
       #print("fileName: " + os.path.basename(os.path.normpath(filename)))
       fileName=os.path.basename(os.path.normpath(filename))

       fichero=os.path.join(dirname,fileName)
       nuevo_name="sm_session_"+pathName+"_123_annotate"
       destino=os.path.join(dirname,nuevo_name)
       print("El fichero que vamos a mover: " + fichero)
       ## Comenzamos el cambio de path
       nuevo=""
       tempo=destino.split("/")

       for i in tempo:
         if i == "POST":
           nuevo=nuevo+"POST"
           break
         else:
           nuevo=nuevo+i+"/"

       destino_final=nuevo+"/"+nuevo_name
       print("El desstino final: " + destino_final)
       shutil.move(fichero,destino_final)


change_name("/home/znpalad/ericsson/session-management-policy-control/ct/src/test-data")
