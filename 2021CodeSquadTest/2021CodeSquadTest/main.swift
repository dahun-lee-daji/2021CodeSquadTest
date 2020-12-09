//
//  main.swift
//  2021CodeSquadTest
//
//  Created by 이다훈 on 2020/12/07.
//

import Foundation

print("해당 작동은 1회 진행됨, 반복 실행을 위해서 재 작동 시킬 것")
print("단어(space)N(space)방향, EX) banana 3 R 을 입력할 것")
print("단어 내 띄어쓰기 불가, -100<=N<100, 방향 : R, L")
print("한글의 경우 자음 모음이 분리됨")

while (true){
    print("입력하시오 종료하려면 Q를 입력하시오")
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
    movingCount = createMovingCount(splitedMessage[1]) // 입력값의 무빙카운트 String -> Int 형 변환 하여 저장
    movingCount = calculateMovingCount(sentenceLength: splitedMessage[0].count, movingCount: movingCount) // 현재 단어의 길이와 입력된 무빙카운트를 계산하여 다시 저장.
    mode = splitedMessage[2].uppercased()
    
    
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


func calculateMovingCount(sentenceLength : Int, movingCount : Int) -> Int {
    var item = Int()
    if sentenceLength <= movingCount {
        item = movingCount % sentenceLength
    }
    else {
        item = movingCount
    }
    print("MovingCount: \(item)")
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
    if checkingMeesageNumber(input[1]) == false {
        return false
    }
    if checkingMeesageDirection(input[2]) == false {
        return false
    }
    return true
    
    
}

func checkingMessageLength(_ input : Int) ->Bool {
    if input == 3 {
        print("MessageLength : \(input) ")
        return true
    }
    return false
}

func checkingMeesageNumber(_ input : String) ->Bool {
    print("MessageNumber : \(input) ")
    if let integerInput = Int(input) {
        
        if Int(integerInput) >= -100 && Int(integerInput) < 100 {
            return true
        }
    }
    return false
}

func checkingMeesageDirection(_ input : String) ->Bool {
    print("MessageDirection : \(input) ")
    let uppercasedInput = input.uppercased()
    if uppercasedInput == "R" || uppercasedInput == "L" {
        return true
    }
    return false
}




