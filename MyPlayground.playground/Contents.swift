//: Playground - noun: a place where people can play

import UIKit

var str = "Pregunta 1: Ejemplo de dependecias strong y weak"

//El problema principal con las referencias fuertes es cuando son recursivas (p1 apunta a p2 y p2 apunta a p1), estas no son borradas por el ARC si las variables que apuntan a estas posiciones de memoria son convertidas a nil.
//Esto se da ya que el ARC toma en cuenta estas referencias, por lo tanto p1 y p2 se mantendran en sistema. Las referencias de tipo "weak" no son contadas por el ARC, lo cual si permite limpiar las posiciones de memoria aun cuando
//esta se encuentra apuntada por una referencia debil

struct Perro {
    var nombre: String!
    var amo: Persona!
}

struct Gato {
    var nombre: String!
    weak var humanoEncargado: Persona?
}

class Persona {
    var nombre: String!
    var perro: Perro?
    var gato: Gato?
    
    init(nombre: String) {
        self.nombre = nombre
    }
}

var anton: Persona? = Persona(nombre: "Anton")
var bielka: Perro? = Perro(nombre: "Bielka", amo: anton)
anton!.perro = bielka

anton = nil
bielka = nil

//Las variables son eliminadas, pero las posiciones de memoria no se eliminan por el ARC ya que siguen siendo apuntadas por las referencias perro y amo

anton = Persona(nombre: "Anton")

var strielka: Gato? = Gato(nombre: "Kitty", humanoEncargado: anton)
anton!.gato = strielka

anton = nil
strielka = nil

//Las variables son eliminadas junto con las posiciones de memoria, ya que Gato tiene una referencia "weak" que hace que el ARC la ignore en su conteo. De tal manera, ambas posiciones de memoria son eliminadas

