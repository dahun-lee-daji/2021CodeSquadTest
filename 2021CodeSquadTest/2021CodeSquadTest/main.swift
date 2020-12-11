//
//  main.swift
//  2021CodeSquadTest
//
//  Created by 이다훈 on 2020/12/07.
//

import Foundation

while (true){
    print("명령어를 입력하시오. 종료하려면 Q를 입력하시오")
    let inputMessage = readLine()
    var splitedMessage = [String]()
    var inputWord = String()
    var movingCount = Int()
    var mode = String()
    var resultMessage = String()
    
    if checkQuitMessage(inputMessage) == true {
        break
    }
    splitedMessage = createSplitMessage(inputMessage)
    
    if checkMessageSuited(splitedMessage) == false {
        print("입력에 문제가 있습니다.")
        continue
    }
    
    inputWord = splitedMessage[0]
    movingCount = createMovingCount(splitedMessage[1])
    
    if movingCount<0 {
        mode = splitedMessage[2].uppercased() == "R" ? "L" : "R"
        movingCount = -movingCount
    } else {
        mode = splitedMessage[2].uppercased()
    }
    
    movingCount = calculateMovingCount(inputWord.count, movingCount)
    
    
    switch mode {
    case "R":
        resultMessage = movingRight(inputWord, movingCount)
    case "L":
        resultMessage = movingLeft(inputWord, movingCount)
    default:
        print("모드 오류, R,L을 3번째 명령어를 R(r), L(l)로 입력하시오")
    }
    print(resultMessage)
}

func movingRight(_ inputSentence : String, _ movingCount : Int) -> String {
    var item = String()
    let boundaryIndex = inputSentence.index(inputSentence.endIndex, offsetBy: -movingCount)
    item = inputSentence.substring(from:  boundaryIndex) + inputSentence.substring(to: boundaryIndex)
    return item
}

func movingLeft(_ inputSentence : String, _ movingCount : Int) -> String {
    var item = String()
    let boundaryIndex = inputSentence.index(inputSentence.startIndex, offsetBy: movingCount)
    item = inputSentence.substring(from:  boundaryIndex) + inputSentence.substring(to: boundaryIndex)
    return item
}


func calculateMovingCount(_ sentenceLength : Int, _ movingCount : Int) -> Int {
    var item = Int()
    if sentenceLength <= movingCount {
        item = movingCount % sentenceLength
    }
    else {
        item = movingCount
    }
    return item
}

func createMovingCount(_ input: String) -> Int {
    var item = Int()
    if let integerInput = Int(input) {
        item = integerInput
    }
    return item
}

func createSplitMessage(_ input : Optional<String>) -> [String] {
    var item = [String]()
    if let trueInputMessage = input {
        item = trueInputMessage.components(separatedBy: " ")
        
    } else {
        print("입력에 문제가 있습니다.")
    }
    return item
}

func checkQuitMessage(_ input : Optional<String>) -> Bool {
    if let inputMessage = input {
        if inputMessage.uppercased() == "Q" {
            return true
        }
    }
    return false
}

func checkMessageSuited(_ input : [String]) ->Bool {
    if checkingMessageLength(input.count) == false {
        return false
    }
    if checkingMesageNumber(input[1]) == false {
        return false
    }
    if checkingMesageDirection(input[2]) == false {
        return false
    }
    return true
    
    
}

func checkingMessageLength(_ input : Int) ->Bool {
    if input == 3 {
        return true
    }
    return false
}

func checkingMesageNumber(_ input : String) ->Bool {
    if let integerInput = Int(input) {
        
        if Int(integerInput) >= -100 && Int(integerInput) < 100 {
            return true
        }
    }
    return false
}

func checkingMesageDirection(_ input : String) ->Bool {
    let uppercasedInput = input.uppercased()
    if uppercasedInput == "R" || uppercasedInput == "L" {
        return true
    }
    return false
}




