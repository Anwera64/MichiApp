//
//  ViewController.swift
//  MichiApp
//
//  Created by E4401 on 4/3/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit
import Darwin

struct Theme {
    let xEmoji: String
    let oEmoji: String
    let emptyEmoji: String
    let color: UIColor
}

extension Theme {
    static func loadThemes() -> [Theme] {
        let t1 = Theme(xEmoji: "🙉", oEmoji: "🙈", emptyEmoji: "🐵", color: .blue)
        let t2 = Theme(xEmoji: "🐮", oEmoji: "🐷", emptyEmoji: "🐸", color: .green)
        let t3 = Theme(xEmoji: "🌚", oEmoji: "🌝", emptyEmoji: "🌈", color: .cyan)
        let t4 = Theme(xEmoji: "🍆", oEmoji: "🌮", emptyEmoji: "🍕", color: .orange)
        let t5 = Theme(xEmoji: "⚽️", oEmoji: "🏀", emptyEmoji: "🥅", color: .purple)
        return [t1, t2, t3, t4, t5]
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var butCasillas: [UIButton]!
    @IBOutlet weak var labMensaje: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    private var themes: [Theme]!
    private var selectedTheme: Theme! {
        didSet {
            for button in butCasillas {
                button.backgroundColor = selectedTheme.color
                button.setTitle(selectedTheme.emptyEmoji, for: .normal)
            }
        }
    }
    
    var michiManager: MichiManager!
    var endGame: Bool = false
    var count: Int = 0 {
        didSet{
            labMensaje.text = "Número de intentos: \(count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.michiManager = MichiManager()
        self.themes = Theme.loadThemes()
        self.selectedTheme = themes[Int(arc4random_uniform(4))]
        self.resetButton.setTitle("Reset", for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resetButton.layer.cornerRadius = resetButton.frame.height / 2.5
        resetButton.layer.masksToBounds = true
    }
    
    @IBAction func seleccionarCasiilla(_ sender: UIButton) {
        if endGame {
            return
        }
        count += 1
        
        if let selectedIndex = butCasillas.index(of: sender){
            michiManager.realizarJugada(posicion: selectedIndex)
            refrescarTablero()
            if michiManager.verificarGanador(posicion: selectedIndex) != -1{
                labMensaje.text = "Ganó el jugador \(michiManager.jugadorTurno+1) y se jugaron \(count) intentos"
                endGame = true
            } else {
                michiManager.cambiarJugador()
            }
        }
    }
    
    func voltearCasilla(casilla boton: UIButton, jugador: Int){
        if jugador == 0 {
            boton.setTitle(selectedTheme.xEmoji, for: .normal)
        } else {
            boton.setTitle(selectedTheme.oEmoji, for: .normal)
        }
    }
    
    func refrescarTablero(){
        for i in 0..<butCasillas.count{
            let (x, y) = michiManager.translate(position: i)
            if michiManager.tablero[x][y] != -1 {
                voltearCasilla(casilla: butCasillas[i],jugador: michiManager.tablero[x][y])
            }
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        endGame = false
        for casilla in butCasillas {
            casilla.setTitle("🐶", for: .normal)
        }
        michiManager.inicializarTablero()
        count = 0
        self.selectedTheme = themes[Int(arc4random_uniform(4))]
    }
}

