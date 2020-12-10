//
//  main.swift
//  2021CodeSquadTest
//
//  Created by 이다훈 on 2020/12/07.
//

/*
 U  가장 윗줄을 왼쪽으로 한 칸 밀기 RRW -> RWR
 > U' 가장 윗줄을 오른쪽으로 한 칸 밀기 RRW -> WRR
 > R  가장 오른쪽 줄을 위로 한 칸 밀기 WWB -> WBW
 > R' 가장 오른쪽 줄을 아래로 한 칸 밀기 WWB -> BWW
 > L  가장 왼쪽 줄을 아래로 한 칸 밀기 RGG -> GRG (L의 경우 R과 방향이 반대임을 주의한다.)
 > L' 가장 왼쪽 줄을 위로 한 칸 밀기 RGG -> GGR
 > B  가장 아랫줄을 오른쪽으로 한 칸 밀기 GBB -> BGB (B의 경우도 U와 방향이 반대임을 주의한다.)
 > B' 가장 아랫줄을 왼쪽으로 한 칸 밀기 GBB -> BBG
 > Q  Bye~를 출력하고 프로그램을 종료한다.
 
 처음 시작하면 초기 상태를 출력한다.
 간단한 프롬프트 (CLI에서 키보드 입력받기 전에 표시해주는 간단한 글자들 - 예: CUBE> )를 표시해 준다.
 한 번에 여러 문자를 입력받은 경우 순서대로 처리해서 매 과정을 화면에 출력한다.
*/

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
        print("\(bottomSide[0]) \(bottomSide[1]) \(bottomSide[2]) ")
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
    
    doCommands(dicedMessage,currentCube)
}

func doCommands(_ commands : [String], _ cube : Cube2D) {
    for i in 0..<commands.count {
        switch commands[i] {
        case <#pattern#>:
            <#code#>
        default:
            print("잘못된 명령어 입니다, 입력된 명령 : \(commands[i])")
        }
    }
}

func doOptionalBinding(_ input : Optional<String>) -> String {
    var item = String()
    if let inputMessage = input?.uppercased() {
        item = inputMessage
    } else {
        print("입력 값 오류")
    }
    print("doOptionalBinding : \(item)")
    return item
}

func doIndiceString(_ input : String) -> [String] {
    var item = [String]()
    for i in input.indices {
        item.append(String(input[i]))
    }
    print("doIndiceString : \(item)")
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
    print("commacombiantion : \(item)")
    return item
}

