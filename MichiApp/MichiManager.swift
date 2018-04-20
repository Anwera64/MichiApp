//
//  MichiManager.swift
//  MichiApp
//
//  Created by E4401 on 4/10/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import Foundation

class MichiManager{
    var tablero: [[Int]]
    var jugadorTurno: Int
    let size = 3
    
    init(){
        jugadorTurno = 0
        tablero = [[Int]]()
        inicializarTablero()
    }
    
    func inicializarTablero(){
        tablero = Array(repeating: Array(repeating: -1, count: 3), count: 3)
    }
    
    func realizarJugada(posicion: Int){
        let (x, y) = transaltePos(posicion: posicion)
        if tablero[x][y] == -1 {
            tablero[x][y] = jugadorTurno
            if jugadorTurno == 0 {
                jugadorTurno = 1
            } else {
                jugadorTurno = 0
            }
        }
    }
    
    func transaltePos(posicion: Int) -> (x: Int, y: Int) {
        let x = (posicion/size), y = (posicion%size)
        return (x, y)
    }
    
    func verificarGanador(posicion: Int) -> Int{
        if checkHorizontalVertical(posicion: posicion) || checkDiagonal() {
            return jugadorTurno
        } else {
            return -1
        }
    }
    
    func checkHorizontalVertical(posicion pos: Int) -> Bool {
        let (x, y) = transaltePos(posicion: pos)
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
        if size%2 != 0 {
            let middle = size/2
            var finished = true;
            if tablero[middle][middle] != jugadorTurno { return false }
            var limitsPos = [Int](), limitsNeg = [Int]()
            for i in 1...size-middle {
                limitsPos.append(i)
                limitsNeg.append(-i)
            }
            for i in limitsPos {
                if tablero[middle+i][middle+i] != jugadorTurno {
                    finished = false
                    break
                }
            }
            if finished { return true }
            for i in limitsNeg {
                if tablero[middle+i][middle+i] != jugadorTurno { return false }
            }
        }
        return true
    }
    
    
}

