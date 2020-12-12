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
        topLayer = [String](repeating: color, count: 3)
        middleLayer = [String](repeating: color, count: 3)
        bottomLayer = [String](repeating: color, count: 3)
    }
    
    init() {
        topLayer = []
        middleLayer = []
        bottomLayer = []
    }
    
    mutating func turnRight() {
        let tempside = self
        self.topLayer = tempside.getIndicedColumn(columnOrder: 0, direction: false)
        self.middleLayer = tempside.getIndicedColumn(columnOrder: 1, direction: false)
        self.bottomLayer = tempside.getIndicedColumn(columnOrder: 2, direction: false)
    }
    mutating func turnLeft() {
        let tempside = self
        self.topLayer = tempside.getIndicedColumn(columnOrder: 2, direction: true)
        self.middleLayer = tempside.getIndicedColumn(columnOrder: 1, direction: true)
        self.bottomLayer = tempside.getIndicedColumn(columnOrder: 0, direction: true)
    }
    
    func doIndiceString(_ input : String) -> [String] {
        var item = [String]()
        for i in input.indices {
            item.append(String(input[i]))
        }
        return item
    }
    
    func getIndicedColumn(columnOrder : Int, direction : Bool)-> [String] {
        var item = String()
        if direction {
            item = topLayer[columnOrder] + middleLayer[columnOrder] + bottomLayer[columnOrder]
        } else {
            item = bottomLayer[columnOrder] + middleLayer[columnOrder] + topLayer[columnOrder]
        }
        return doIndiceString(item)
    }
    mutating func setRow(input:ArraySlice<String> ,rowOrder : Int) {
        var item = input
        switch rowOrder {
        case 0:
            for i in 0..<input.count {
                topLayer[i] = item.popFirst()!
            }
        case 1:
            for i in 0..<input.count {
                middleLayer[i] = item.popFirst()!
            }
        case 2:
            for i in 0..<input.count {
                bottomLayer[i] = item.popFirst()!
            }
        default:
            ""
        }
    }
    
    mutating func setColumn(input: ArraySlice<String>,columnOrder : Int) {
        var item = input
        topLayer[columnOrder] = item.popFirst()!
        middleLayer[columnOrder] = item.popFirst()!
        bottomLayer[columnOrder] = item.popFirst()!
    }
    
    func getRow(rowOrder : Int, direction : Bool)-> String {
        switch (rowOrder, direction) {
        case (0,true):
            return topLayer[0] + " " + topLayer[1] + " " + topLayer[2]
        case (1,true):
            return middleLayer[0] + " " + middleLayer[1] + " " + middleLayer[2]
        case (2,true):
            return bottomLayer[0] + " " + bottomLayer[1] + " " + bottomLayer[2]
        case (0,false):
            return topLayer[2] + " " + topLayer[1] + " " + topLayer[0]
        case (1,false):
            return middleLayer[2] + " " + middleLayer[1] + " " + middleLayer[0]
        case (2,false):
            return bottomLayer[2] + " " + bottomLayer[1] + " " + bottomLayer[0]
        default:
            return ""
        }
    }
    
    func print2DCube(frontSpacing : Int = 0) {
        let spacing = String(repeating: " ", count: frontSpacing)
        print("\(spacing)\(getRow(rowOrder:0, direction: true)) ")
        print("\(spacing)\(getRow(rowOrder:1, direction: true)) ")
        print("\(spacing)\(getRow(rowOrder:2, direction: true )) ", terminator : "\n\n")
        }
}

struct Cube3D {
    enum NumberingSides : Int {
        case upper = 0
        case left = 1
        case front = 2
        case right = 3
        case back = 4
        case bottom = 5
        
        func upper() -> Int {
            return NumberingSides.upper.rawValue
        }
        func left() -> Int {
            return NumberingSides.left.rawValue
        }
        func front() -> Int {
            return NumberingSides.front.rawValue
        }
        func right() -> Int {
            return NumberingSides.right.rawValue
        }
        func back() -> Int {
            return NumberingSides.back.rawValue
        }
        func bottom() -> Int {
            return NumberingSides.bottom.rawValue
        }
    }
    var cubeSides = [Cube2D](repeating: Cube2D(), count: 6)
    
    let startTime = Date.init(timeIntervalSinceNow: 0)
    var side : NumberingSides = .front
    var moves = Int()
    
    init (){
        cubeSides[side.upper()] = .init(color: "B")
        cubeSides[side.left()] = .init(color: "W")
        cubeSides[side.front()] = .init(color: "O")
        cubeSides[side.right()] = .init(color: "G")
        cubeSides[side.back()] = .init(color: "Y")
        cubeSides[side.bottom()] = .init(color: "R")
    }
    
    func print3DCube(){
        var middleSidesTopLayer = String()
        var middleSidesMiddleLayer = String()
        var middleSidesBottomLayer = String()
        
        cubeSides[Cube3D.NumberingSides.upper.rawValue].print2DCube(frontSpacing: 15)
        for i in 1...4 {
            middleSidesTopLayer += "     \(cubeSides[i].getRow(rowOrder: 0, direction: true))"
            middleSidesMiddleLayer += "     \(cubeSides[i].getRow(rowOrder: 1, direction: true))"
            middleSidesBottomLayer += "     \(cubeSides[i].getRow(rowOrder: 2, direction: true))"
        }
        print(middleSidesTopLayer, middleSidesMiddleLayer, middleSidesBottomLayer, separator: "\n",terminator:"\n\n")
        cubeSides[Cube3D.NumberingSides.bottom.rawValue].print2DCube(frontSpacing: 15)
    }
    
    mutating func turnClockwise(target : NumberingSides) {
        moves += 1
        switch target {
        case .front:
            setRightMovedRow(target: target)
            cubeSides[target.rawValue].turnRight()
        case .back:
            setLeftMovedRow(target: target)
            cubeSides[target.rawValue].turnLeft()
        case .upper:
            setRightMovedRow(target: target)
            cubeSides[target.rawValue].turnRight()
        case .bottom:
            setLeftMovedRow(target: target)
            cubeSides[target.rawValue].turnLeft()
        case .left:
            setLeftMovedRow(target: target)
            cubeSides[target.rawValue].turnLeft()
        case .right:
            setRightMovedRow(target: target)
            cubeSides[target.rawValue].turnRight()
        default:
            print("Error: 잘못된 입력 in turnClockwise()", self)
        }
    }
    
    mutating func turnCounterClockwise(target : NumberingSides) {
        moves += 1
        switch target {
        case .front:
            setLeftMovedRow(target: target)
            cubeSides[target.rawValue].turnLeft()
        case .back:
            setRightMovedRow(target: target)
            cubeSides[target.rawValue].turnRight()
        case .upper:
            setLeftMovedRow(target: target)
            cubeSides[target.rawValue].turnLeft()
        case .bottom:
            setRightMovedRow(target: target)
            cubeSides[target.rawValue].turnRight()
        case .left:
            setRightMovedRow(target: target)
            cubeSides[target.rawValue].turnRight()
        case .right:
            setLeftMovedRow(target: target)
            cubeSides[target.rawValue].turnLeft()
        default:
            print("Error: 잘못된 입력 in turnClockwise()", self)
        }
    }
    
    mutating func setRightMovedRow(target : NumberingSides) {
        var movingRow = String()
        var indicedMovedRow = [String]()
        switch target {
        case .front:
            movingRow = cubeSides[side.left()].getIndicedColumn(columnOrder: 2, direction: false).joined() + cubeSides[side.upper()].getRow(rowOrder: 2,direction: true).components(separatedBy: " ").joined() + cubeSides[side.right()].getIndicedColumn(columnOrder: 0, direction: true).joined() + cubeSides[side.bottom()].getRow(rowOrder: 0, direction: false).components(separatedBy: " ").joined()
            indicedMovedRow = doIndiceString(movingCellsRight(movingRow, 3))
            cubeSides[side.left()].setColumn(input: indicedMovedRow[0...2], columnOrder: 2)
            cubeSides[side.upper()].setRow(input: indicedMovedRow[3...5], rowOrder: 2)
            cubeSides[side.right()].setColumn(input: indicedMovedRow[6...8], columnOrder: 0)
            cubeSides[side.bottom()].setRow(input: indicedMovedRow[9...11], rowOrder: 0)
        case .back:
            movingRow = cubeSides[side.left()].getIndicedColumn(columnOrder: 0, direction: false).joined() + cubeSides[side.upper()].getRow(rowOrder: 0,direction: true).components(separatedBy: " ").joined() + cubeSides[side.right()].getIndicedColumn(columnOrder: 2, direction: true).joined() + cubeSides[side.bottom()].getRow(rowOrder: 2, direction: false).components(separatedBy: " ").joined()
            indicedMovedRow = doIndiceString(movingCellsRight(movingRow, 3))
            cubeSides[side.left()].setColumn(input: indicedMovedRow[0...2], columnOrder: 0)
            cubeSides[side.upper()].setRow(input: indicedMovedRow[3...5], rowOrder: 0)
            cubeSides[side.right()].setColumn(input: indicedMovedRow[6...8], columnOrder: 2)
            cubeSides[side.bottom()].setRow(input: indicedMovedRow[9...11], rowOrder: 2)
        case .right:
            movingRow = cubeSides[side.front()].getIndicedColumn(columnOrder: 2, direction: false).joined() + cubeSides[side.upper()].getIndicedColumn(columnOrder: 2, direction: false).joined() + cubeSides[side.back()].getIndicedColumn(columnOrder: 0, direction: true).joined() + cubeSides[side.bottom()].getIndicedColumn(columnOrder: 2, direction: false).joined()
            indicedMovedRow = doIndiceString(movingCellsRight(movingRow, 3))
            cubeSides[side.front()].setColumn(input: indicedMovedRow[0...2], columnOrder: 2)
            cubeSides[side.upper()].setColumn(input: indicedMovedRow[3...5], columnOrder: 2)
            cubeSides[side.back()].setColumn(input: indicedMovedRow[6...8], columnOrder: 0)
            cubeSides[side.bottom()].setColumn(input: indicedMovedRow[9...11], columnOrder: 2)
        case .left:
            movingRow = cubeSides[side.front()].getIndicedColumn(columnOrder: 0, direction: false).joined() + cubeSides[side.upper()].getIndicedColumn(columnOrder: 0, direction: false).joined() + cubeSides[side.back()].getIndicedColumn(columnOrder: 2, direction: true).joined() + cubeSides[side.bottom()].getIndicedColumn(columnOrder: 0, direction: false).joined()
            indicedMovedRow = doIndiceString(movingCellsRight(movingRow, 3))
            cubeSides[side.front()].setColumn(input: indicedMovedRow[0...2], columnOrder: 0)
            cubeSides[side.upper()].setColumn(input: indicedMovedRow[3...5], columnOrder: 0)
            cubeSides[side.back()].setColumn(input: indicedMovedRow[6...8], columnOrder: 2)
            cubeSides[side.bottom()].setColumn(input: indicedMovedRow[9...11], columnOrder: 0)
        case .upper:
            let tempRow = cubeSides[side.front()].topLayer
            cubeSides[side.front()].topLayer = cubeSides[side.right()].topLayer
            cubeSides[side.right()].topLayer = cubeSides[side.back()].topLayer
            cubeSides[side.back()].topLayer = cubeSides[side.left()].topLayer
            cubeSides[side.left()].topLayer = tempRow
        case .bottom:
            let tempRow = cubeSides[side.front()].bottomLayer
            cubeSides[side.front()].bottomLayer = cubeSides[side.right()].bottomLayer
            cubeSides[side.right()].bottomLayer = cubeSides[side.back()].bottomLayer
            cubeSides[side.back()].bottomLayer = cubeSides[side.left()].bottomLayer
            cubeSides[side.left()].bottomLayer = tempRow
        default:
            ""
        }
    }
    
    mutating func setLeftMovedRow(target : NumberingSides) {
        var movingRow = String()
        var indicedMovedRow = [String]()
        switch target {
        case .front:
            movingRow = cubeSides[side.left()].getIndicedColumn(columnOrder: 2, direction: false).joined() + cubeSides[side.upper()].getRow(rowOrder: 2,direction: true).components(separatedBy: " ").joined() + cubeSides[side.right()].getIndicedColumn(columnOrder: 0, direction: true).joined() + cubeSides[side.bottom()].getRow(rowOrder: 0, direction: false).components(separatedBy: " ").joined()
            indicedMovedRow = doIndiceString(movingCellsLeft(movingRow, 3))
            cubeSides[side.left()].setColumn(input: indicedMovedRow[0...2], columnOrder: 2)
            cubeSides[side.upper()].setRow(input: indicedMovedRow[3...5], rowOrder: 2)
            cubeSides[side.right()].setColumn(input: indicedMovedRow[6...8], columnOrder: 0)
            cubeSides[side.bottom()].setRow(input: indicedMovedRow[9...11], rowOrder: 0)
        case .back:
            movingRow = cubeSides[side.left()].getIndicedColumn(columnOrder: 0, direction: false).joined() + cubeSides[side.upper()].getRow(rowOrder: 0,direction: true).components(separatedBy: " ").joined() + cubeSides[side.right()].getIndicedColumn(columnOrder: 2, direction: true).joined() + cubeSides[side.bottom()].getRow(rowOrder: 2, direction: false).components(separatedBy: " ").joined()
            indicedMovedRow = doIndiceString(movingCellsLeft(movingRow, 3))
            cubeSides[side.left()].setColumn(input: indicedMovedRow[0...2], columnOrder: 0)
            cubeSides[side.upper()].setRow(input: indicedMovedRow[3...5], rowOrder: 0)
            cubeSides[side.right()].setColumn(input: indicedMovedRow[6...8], columnOrder: 2)
            cubeSides[side.bottom()].setRow(input: indicedMovedRow[9...11], rowOrder: 2)
        case .right:
            movingRow = cubeSides[side.front()].getIndicedColumn(columnOrder: 2, direction: false).joined() + cubeSides[side.upper()].getIndicedColumn(columnOrder: 2, direction: false).joined() + cubeSides[side.back()].getIndicedColumn(columnOrder: 0, direction: true).joined() + cubeSides[side.bottom()].getIndicedColumn(columnOrder: 2, direction: false).joined()
            indicedMovedRow = doIndiceString(movingCellsLeft(movingRow, 3))
            cubeSides[side.front()].setColumn(input: indicedMovedRow[0...2], columnOrder: 2)
            cubeSides[side.upper()].setColumn(input: indicedMovedRow[3...5], columnOrder: 2)
            cubeSides[side.back()].setColumn(input: indicedMovedRow[6...8], columnOrder: 0)
            cubeSides[side.bottom()].setColumn(input: indicedMovedRow[9...11], columnOrder: 2)
        case .left:
            movingRow = cubeSides[side.front()].getIndicedColumn(columnOrder: 0, direction: false).joined() + cubeSides[side.upper()].getIndicedColumn(columnOrder: 0, direction: false).joined() + cubeSides[side.back()].getIndicedColumn(columnOrder: 2, direction: true).joined() + cubeSides[side.bottom()].getIndicedColumn(columnOrder: 0, direction: false).joined()
            indicedMovedRow = doIndiceString(movingCellsLeft(movingRow, 3))
            cubeSides[side.front()].setColumn(input: indicedMovedRow[0...2], columnOrder: 0)
            cubeSides[side.upper()].setColumn(input: indicedMovedRow[3...5], columnOrder: 0)
            cubeSides[side.back()].setColumn(input: indicedMovedRow[6...8], columnOrder: 2)
            cubeSides[side.bottom()].setColumn(input: indicedMovedRow[9...11], columnOrder: 0)
        case .upper:
            let tempRow = cubeSides[side.front()].topLayer
            cubeSides[side.front()].topLayer = cubeSides[side.left()].topLayer
            cubeSides[side.left()].topLayer = cubeSides[side.back()].topLayer
            cubeSides[side.back()].topLayer = cubeSides[side.right()].topLayer
            cubeSides[side.right()].topLayer = tempRow
        case .bottom:
            let tempRow = cubeSides[side.front()].bottomLayer
            cubeSides[side.front()].bottomLayer = cubeSides[side.left()].bottomLayer
            cubeSides[side.left()].bottomLayer = cubeSides[side.back()].bottomLayer
            cubeSides[side.back()].bottomLayer = cubeSides[side.right()].bottomLayer
            cubeSides[side.right()].bottomLayer = tempRow
        default:
            ""
        }
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
    
    func exitCubing() -> Bool {
        printExitTime()
        printNumberOfPerformances()
        print("이용해주셔서 감사합니다. 뚜뚜뚜.")
        return true
    }
    
    func printNumberOfPerformances() {
        print("조작갯수: \(moves)")
    }
    
    func printExitTime() {
        
        let end = Date.init(timeIntervalSinceNow: 0)
        print("경과시간: ",calculateIntervalTime(startTime,end) ?? "")
    }
    
    func calculateIntervalTime(_ start : Date, _ end : Date) -> String? {
        let totalSec = end.timeIntervalSince(start)
        let dateFormat = DateComponentsFormatter()
        dateFormat.unitsStyle = .positional
        dateFormat.allowedUnits = [.minute, .second]
        dateFormat.zeroFormattingBehavior = .pad
        
        return dateFormat.string(from: totalSec)
    }
    
    func doIndiceString(_ input : String) -> [String] {
        var item = [String]()
        for i in input.indices {
            item.append(String(input[i]))
        }
        return item
    }
}


var currentCube = Cube3D.init()
currentCube.print3DCube()

while(true){
    print(" CUBE> ",terminator :"")
    let inputOptionalMessage = readLine()
    let inputStringMessage = doOptionalBinding(inputOptionalMessage)
    var dicedMessage = doIndiceString(inputStringMessage)
    dicedMessage = insertAdditionalCommands(dicedMessage)
    if doCommands(dicedMessage,&currentCube) {
            break
        }
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
        if (i == 0) && (input[i] == "\'") || (i == 0) && (input[i] == "2") {
                print("명령의 첫번째가 ' 또는 2이므로 이를 삭제합니다.")
                continue
        }
        
        if input[i] == "\'"{
            item[item.endIndex-1] = "\(item[item.endIndex-1])'"
        }
        else if input[i] == "2" {
            item.append(item[item.endIndex-1])
        }
        else {
        item.append(input[i])
        }
    }
    return item
}

func doCommands(_ commands : [String], _ cube : inout Cube3D) -> Bool {
    var exitFlag = false
    for i in 0..<commands.count {
        switch commands[i] {
        case "F":
            print(commands[i])
            cube.turnClockwise(target: Cube3D.NumberingSides.front)
            cube.print3DCube()
        case "F'":
            print(commands[i])
            cube.turnCounterClockwise(target: Cube3D.NumberingSides.front)
            cube.print3DCube()
        case "B":
            print(commands[i])
            cube.turnClockwise(target: Cube3D.NumberingSides.back)
            cube.print3DCube()
        case "B'":
            print(commands[i])
            cube.turnCounterClockwise(target: Cube3D.NumberingSides.back)
            cube.print3DCube()
        case "R":
            print(commands[i])
            cube.turnClockwise(target: Cube3D.NumberingSides.right)
            cube.print3DCube()
        case "R'":
            print(commands[i])
            cube.turnCounterClockwise(target: Cube3D.NumberingSides.right)
            cube.print3DCube()
        case "L":
            print(commands[i])
            cube.turnClockwise(target: Cube3D.NumberingSides.left)
            cube.print3DCube()
        case "L'":
            print(commands[i])
            cube.turnCounterClockwise(target: Cube3D.NumberingSides.left)
            cube.print3DCube()
        case "U":
            print(commands[i])
            cube.turnClockwise(target: Cube3D.NumberingSides.upper)
            cube.print3DCube()
        case "U'":
            print(commands[i])
            cube.turnCounterClockwise(target: Cube3D.NumberingSides.upper)
            cube.print3DCube()
        case "D":
            print(commands[i])
            cube.turnClockwise(target: Cube3D.NumberingSides.bottom)
            cube.print3DCube()
        case "D'":
            print(commands[i])
            cube.turnCounterClockwise(target: Cube3D.NumberingSides.bottom)
            cube.print3DCube()
        case "Q":
            exitFlag = cube.exitCubing()
        default:
            print("잘못된 명령어 입니다, 입력된 명령 : \(commands[i])")
        }
    }
    return exitFlag
}
