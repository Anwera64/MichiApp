//
//  MichiManager.swift
//  MichiApp
//
//  Created by E4401 on 4/10/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import Foundation

class MichiManager {
    var tablero: [[Int]]
    var jugadorTurno: Int
    let size = 3
    
    init() {
        jugadorTurno = 0
        tablero = [[Int]]()
        inicializarTablero()
    }
    
    func inicializarTablero() {
        tablero = Array(repeating: Array(repeating: -1, count: size), count: size)
    }
    
    func realizarJugada(posicion: Int) {
        let (x, y) = translate(position: posicion)
        if tablero[x][y] == -1 {
            tablero[x][y] = jugadorTurno
        }
    }
    
    func translate(position: Int) -> (x: Int, y: Int) {
        let x = (position/size), y = (position%size)
        return (x, y)
    }
    
    func verificarGanador(posicion: Int) -> Int {
        if checkHorizontalVertical(posicion: posicion) || checkDiagonal() {
            return jugadorTurno
        } else {
            return -1
        }
    }
    
    func cambiarJugador() {
        if jugadorTurno == 0 {
            jugadorTurno = 1
        } else {
            jugadorTurno = 0
        }
    }
    
    func checkHorizontalVertical(posicion pos: Int) -> Bool {
        let (x, y) = translate(position: pos)
        var finished = true;
        for i in 0...(size-1) {
            if tablero[x][0+i] != jugadorTurno {
                finished = false
                break
            }
        }
        if finished { return true }
        
        for i in 0...(size-1) {
            if tablero[0+i][y] != jugadorTurno { return false }
        }
        return true
    }
    
    func checkDiagonal() -> Bool {
        var finished = true;
        for i in 0...(size-1) {
            if (tablero[i][i] != jugadorTurno) {
                finished = false
            }
        }
        if (finished) { return true }
        let y = size - 1
        for i in 0...(size - 1) {
            if (tablero[i][y-i] != jugadorTurno) {
                return false
            }
        }
        return true
    }
}

/*
00 01 02
10 11 12
20 21 22
*/
