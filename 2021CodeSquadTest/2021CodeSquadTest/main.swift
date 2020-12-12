//
//  main.swift
//  2021CodeSquadTest
//
//  Created by 이다훈 on 2020/12/07.
//

import Foundation

struct Cube2D {
    var topLayer : [String]
    var middleLayer : [String]
    var bottomLayer : [String]
    
    init(color : String) {
        topLayer = [color,color,color]
        middleLayer = [color,color,color]
        bottomLayer = [color,color,color]
    }
    
    init() {
        topLayer = []
        middleLayer = []
        bottomLayer = []
    }
    
    func getTopLayer()-> String {
        let item = topLayer[0] + " " + topLayer[1] + " " + topLayer[2]
        return item
    }
    
    func getMiddleLayer()-> String {
        let item = middleLayer[0] + " " + middleLayer[1] + " " + middleLayer[2]
        return item
    }
    
    func getBottomLayer()-> String {
        let item = bottomLayer[0] + " " + bottomLayer[1] + " " + bottomLayer[2]
        return item
    }
    
    func print2DCube(frontSpacing : Int = 0) {
        let spacing = String(repeating: " ", count: frontSpacing)
            print("\(spacing)\(getTopLayer()) ")
            print("\(spacing)\(getMiddleLayer()) ")
        print("\(spacing)\(getBottomLayer()) ", terminator : "\n\n")
        }
}

struct Cube3D {
    var cubeSides = [Cube2D](repeating: Cube2D(), count: 6)
    // cubeSides[0] : 윗면, 1234 좌 앞 우 뒤, 5 아래면
    
    enum NumberingSides : Int {
        case upper = 0
        case left = 1
        case front = 2
        case right = 3
        case back = 4
        case bottom = 5
        
    }
    
    var side : NumberingSides = .front
    
    init (){
        cubeSides[Cube3D.NumberingSides.upper.rawValue] = .init(color: "B")
        cubeSides[Cube3D.NumberingSides.left.rawValue] = .init(color: "W")
        cubeSides[Cube3D.NumberingSides.front.rawValue] = .init(color: "O")
        cubeSides[Cube3D.NumberingSides.right.rawValue] = .init(color: "G")
        cubeSides[Cube3D.NumberingSides.back.rawValue] = .init(color: "Y")
        cubeSides[Cube3D.NumberingSides.bottom.rawValue] = .init(color: "R")
    }
    
    func print3DCube(){
        var middleSidesTopLayer = String()
        var middleSidesMiddleLayer = String()
        var middleSidesBottomLayer = String()
        
        cubeSides[Cube3D.NumberingSides.upper.rawValue].print2DCube(frontSpacing: 15)
        for i in 1...4 {
            middleSidesTopLayer += "     \(cubeSides[i].getTopLayer())"
            middleSidesMiddleLayer += "     \(cubeSides[i].getMiddleLayer())"
            middleSidesBottomLayer += "     \(cubeSides[i].getBottomLayer())"
        }
        print(middleSidesTopLayer, middleSidesMiddleLayer, middleSidesBottomLayer, separator: "\n",terminator:"\n\n")
        cubeSides[Cube3D.NumberingSides.bottom.rawValue].print2DCube(frontSpacing: 15)
    }
}

let testCube = Cube3D.init()
testCube.print3DCube()

