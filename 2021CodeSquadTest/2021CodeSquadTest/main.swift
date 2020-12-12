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

let start = Date.init(timeIntervalSinceNow: 0)

var currentCube = Cube3D.init()
currentCube.print3DCube()

//while(true){
//    print(" CUBE> ",terminator :"")
//    let inputOptionalMessage = readLine()
//    let inputStringMessage = doOptionalBinding(inputOptionalMessage)
//    var dicedMessage = doIndiceString(inputStringMessage)
//    dicedMessage = insertAdditionalCommands(dicedMessage)
//
//}
sleep(1)
let end = Date.init(timeIntervalSinceNow: 0)
print("경과시간: ",calculateIntervalTime(start,end) ?? "")


func calculateIntervalTime(_ start : Date, _ end : Date) -> String? {
    let totalSec = end.timeIntervalSince(start)
    let dateFormat = DateComponentsFormatter()
    dateFormat.unitsStyle = .positional
    dateFormat.allowedUnits = [.minute, .second]
    dateFormat.zeroFormattingBehavior = .pad
    
    return dateFormat.string(from: totalSec)
}


func doOptionalBinding(_ input : Optional<String>) -> String {
    var item = String()
    if let inputMessage = input?.uppercased() {
        item = inputMessage
    } else {
        print("입력 값 오류")
    }
    return item
}

func doIndiceString(_ input : String) -> [String] {
    var item = [String]()
    for i in input.indices {
        item.append(String(input[i]))
    }
    return item
}

func insertAdditionalCommands(_ input : [String]) -> [String] {
    var item = [String]()
    for i in 0..<input.count {
        if input[i] == "\'", input[i] == "2" {
            if i == 0 {
                print("명령의 첫번째가 ' 또는 2이므로 이를 삭제합니다.")
                continue
            } else {
                item[item.endIndex-1] = "\(item[item.endIndex-1])'"
            }
        }
        else {
        item.append(input[i])
        }
    }
    return item
}
