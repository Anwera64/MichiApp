//
//  ViewController.swift
//  MichiApp
//
//  Created by E4401 on 4/3/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var butCasillas: [UIButton]!
    @IBOutlet weak var butCasilla: UIButton!
    @IBOutlet weak var labMensaje: UILabel!
    
    var michiManager: MichiManager = MichiManager()
    
    var contador: Int = 0{
        didSet{
            labMensaje.text = "Número de intentos: \(contador)"
        }
    }
    
    @IBAction func seleccionarCasiilla(_ sender: UIButton) {
        
        contador += 1
        
        if let indiceSeleccionado = butCasillas.index(of: sender){
            michiManager.realizarJugada(posicion: indiceSeleccionado)
            refrescarTablero()
            if michiManager.verificarGanador(posicion: indiceSeleccionado) != -1{
                labMensaje.text = "Ganó el jugador \(michiManager.jugadorTurno) y se jugaron \(contador) intentos"
            }
        }
    }
    
    func voltearCasilla(casilla boton: UIButton, jugador: Int){
        if jugador == 0 {
            boton.setTitle("X", for: UIControlState.normal)
        } else {
            boton.setTitle("Y", for: UIControlState.normal)
        }
        
    }
    
    func refrescarTablero(){
        for i in 0..<butCasillas.count{
            let (x, y) = michiManager.transaltePos(posicion: i)
            if michiManager.tablero[x][y] != -1 {
                voltearCasilla(casilla: butCasillas[i],jugador: michiManager.tablero[x][y])
            }
        }
    }
    
    
}

