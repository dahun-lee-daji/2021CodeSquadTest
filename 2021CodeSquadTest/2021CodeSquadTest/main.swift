//
//  main.swift
//  2021CodeSquadTest
//
//  Created by 이다훈 on 2020/12/07.
//

import Foundation

struct Cube2D {
    var topSide : [String]
    var middleSide : [String]
    var bottomSide : [String]
    
    init() {
        topSide = ["R","R","W"]
        middleSide = ["G","C","W"]
        bottomSide = ["G","B","B"]
    }
    
    func printCube() {
        print("\(topSide[0]) \(topSide[1]) \(topSide[2]) ")
        print("\(middleSide[0]) \(middleSide[1]) \(middleSide[2]) ")
        print("\(bottomSide[0]) \(bottomSide[1]) \(bottomSide[2]) ", terminator :"\n\n")
    }
    
    mutating func topSideMovingLeft() {
        let cellsToMove = "\(topSide[0])\(topSide[1])\(topSide[2])"
        topSide = doIndiceString(movingCellsLeft(cellsToMove, 1))
    }
    
    mutating func topSideMovingRight() {
        let cellsToMove = "\(topSide[0])\(topSide[1])\(topSide[2])"
        topSide = doIndiceString(movingCellsRight(cellsToMove, 1))
    }
    
    mutating func bottomSideMovingLeft() {
            let cellsToMove = "\(bottomSide[0])\(bottomSide[1])\(bottomSide[2])"
        bottomSide = doIndiceString(movingCellsLeft(cellsToMove, 1))
    }
    
    mutating func bottomSideMovingRight() {
            let cellsToMove = "\(bottomSide[0])\(bottomSide[1])\(bottomSide[2])"
        bottomSide = doIndiceString(movingCellsRight(cellsToMove, 1))
    }
    
    mutating func leftSideMovingUp() {
        let cellsToMove = "\(topSide[0])\(middleSide[0])\(bottomSide[0])"
        let afterCellsMove = doIndiceString(movingCellsLeft(cellsToMove, 1))
        topSide[0] = afterCellsMove[0]
        middleSide[0] = afterCellsMove[1]
        bottomSide[0] = afterCellsMove[2]
    }
    
    mutating func leftSideMovingDown() {
        let cellsToMove = "\(topSide[0])\(middleSide[0])\(bottomSide[0])"
        let afterCellsMove = doIndiceString(movingCellsRight(cellsToMove, 1))
        topSide[0] = afterCellsMove[0]
        middleSide[0] = afterCellsMove[1]
        bottomSide[0] = afterCellsMove[2]
        
    }
    
    mutating func rightSideMovingUp() {
        let cellsToMove = "\(topSide[2])\(middleSide[2])\(bottomSide[2])"
        let afterCellsMove = doIndiceString(movingCellsLeft(cellsToMove, 1))
        topSide[2] = afterCellsMove[0]
        middleSide[2] = afterCellsMove[1]
        bottomSide[2] = afterCellsMove[2]
        
    }
    
    mutating func rightSideMovingDown() {
        let cellsToMove = "\(topSide[2])\(middleSide[2])\(bottomSide[2])"
        let afterCellsMove = doIndiceString(movingCellsRight(cellsToMove, 1))
        topSide[2] = afterCellsMove[0]
        middleSide[2] = afterCellsMove[1]
        bottomSide[2] = afterCellsMove[2]
        
    }
    
    
    func movingCellsRight(_ inputSentence : String, _ movingCount : Int) -> String {
        var item = String()
        let boundaryIndex = inputSentence.index(inputSentence.endIndex, offsetBy: -movingCount)
        item = inputSentence.substring(from:  boundaryIndex) + inputSentence.substring(to: boundaryIndex)
        return item
    }

    func movingCellsLeft(_ inputSentence : String, _ movingCount : Int) -> String {
        var item = String()
        let boundaryIndex = inputSentence.index(inputSentence.startIndex, offsetBy: movingCount)
        item = inputSentence.substring(from:  boundaryIndex) + inputSentence.substring(to: boundaryIndex)
        return item
    }
    
    
    func doIndiceString(_ input : String) -> [String] {
        var item = [String]()
        for i in input.indices {
            item.append(String(input[i]))
        }
        return item
    }
    
}

var currentCube = Cube2D.init()
currentCube.printCube()

while(true) {
    print(" CUBE> ",terminator :"")
    let inputOptionalMessage = readLine()
    let inputStringMessage = doOptionalBinding(inputOptionalMessage)
    var dicedMessage = doIndiceString(inputStringMessage)
    dicedMessage = doCommaCombination(dicedMessage)
    
    if doCommands(dicedMessage,currentCube) {
        break
    }
}

func doCommands(_ commands : [String], _ cube : Cube2D) -> Bool {
    var exitFlag = false
    for i in 0..<commands.count {
        switch commands[i] {
        case "U":
            print(commands[i])
            currentCube.topSideMovingLeft()
            currentCube.printCube()
        case "U'":
            print(commands[i])
            currentCube.topSideMovingRight()
            currentCube.printCube()
        case "R":
            print(commands[i])
            currentCube.rightSideMovingUp()
            currentCube.printCube()
        case "R'":
            print(commands[i])
            currentCube.rightSideMovingDown()
            currentCube.printCube()
        case "B":
            print(commands[i])
            currentCube.bottomSideMovingRight()
            currentCube.printCube()
        case "B'":
            print(commands[i])
            currentCube.bottomSideMovingLeft()
            currentCube.printCube()
        case "L":
            print(commands[i])
            currentCube.leftSideMovingDown()
            currentCube.printCube()
        case "L'":
            print(commands[i])
            currentCube.leftSideMovingUp()
            currentCube.printCube()
        case "Q":
            print("bye")
            exitFlag = true
        default:
            print("잘못된 명령어 입니다, 입력된 명령 : \(commands[i])")
        }
    }
    return exitFlag
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

func doCommaCombination(_ input : [String]) -> [String] {
    var item = [String]()
    for i in 0..<input.count {
        if input[i] == "\'" {
            if i == 0 {
                print("명령의 첫번째가 '이므로 이를 삭제합니다.")
                continue
            } else {
            item[i-1] = "\(item[i-1])'"
            }
        }
        else {
        item.append(input[i])
        }
    }
    return item
}

