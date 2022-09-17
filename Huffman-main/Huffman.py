def frecuenciaCaracter(texto):
    # Creamos un diccinario donde se resguarde el caracter y
    # la frecuencia del caracter.
    resultado = dict()
    # Leemos archivo.
    with open(texto, 'r') as f:
        for line in f.readlines():
            # Hacemos minusculas las letras.
            line = line.lower()
            for i in line:
                # Checamos que cada letra sea alfanumerica.
                if i.isalpha():
                    # Si el caracter se encuentra en resultado se 
                    # actualiza el valor.
                    # Por lo contrario se crea un nuevo valor en el diccioanrio.
                    if i in resultado:
                        resultado[i] += 1
                    else:
                        resultado.update({i:1})
    return resultado

# Clase nodo, almacena los valores y la conexion con los hijos.
class Nodo(object):

    def __init__(self, nombre = None, valor = None):
        self.nombre = nombre
        self.valor = valor
        self.izqhi = None
        self.derhi = None


class Huffman_arbol(object):

    def __init__(self, peso_caracteres):
        # List Comprenhension donde pasamos los valores de la lista al nodo.
        self.Hoja = [Nodo(k, v) for k, v  in peso_caracteres.items()]
        while len(self.Hoja) != 1:
            # Ordenamos de mayor a menor el arreglo de nodos o hojas.
            self.Hoja.sort(key = lambda node:node.valor, reverse = True)
            # Nuevo nodo suma de los nodos más pequeños
            n = Nodo(valor = (self.Hoja[-1].valor + self.Hoja[-2].valor))
            # Generamos nodo hijo izquierdo borrando el valor mas bajo.
            n.izqhi = self.Hoja.pop(-1)
            # Generamos nodo hijo derecho borrando el nuevo valor mas bajo.
            n.derhi = self.Hoja.pop(-1)
            # Agregamos nuevo nodo.
            self.Hoja.append(n)
        self.root = self.Hoja[0]
        self.Buffer = list(range(10))


    def Hu_generador(self, arbol, longitud):
        nodo = arbol 
        if(not nodo):
            return
        elif nodo.nombre:
            # Recorremos Arbol de forma recursiva.
            print(nodo.nombre + ', la codificación de Huffman de es:', end='')
            for i in range(longitud):
                print(self.Buffer[i], end='')
            print('\n')
            return
        self.Buffer[longitud] = 0
        self.Hu_generador(nodo.izqhi, longitud + 1)
        self.Buffer[longitud] = 1
        self.Hu_generador(nodo.derhi, longitud + 1)


    def obtener_codigo(self):
        self.Hu_generador(self.root, 0)


def main():
    # Importamos archivo de texto.
    texto = r'texto.txt'
    # Encontramos la frecuencia de cada caracter.
    resultado = frecuenciaCaracter(texto)
    print(resultado)
    # Invocamos a la clase Huffman y
    # Pasamos como argumento el resultado
    nuevo_Huffman = Huffman_arbol(resultado)
    nuevo_Huffman.obtener_codigo()


if __name__ == '__main__':
    main()