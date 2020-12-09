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
    
    
    if checkQuitMessage(inputMessage) == true {
        break
    }
    splitedMessage = createSplitMessage(inputMessage)
    
    if checkMessageSuited(splitedMessage) == false {
        print("입력에 문제가 있습니다.")
        continue
    }
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
        if inputMessage == "Q" {
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
        print(input)
        return true
    }
    return false
}

func checkingMeesageNumber(_ input : String) ->Bool {
    print(input)
    if let integerInput = Int(input) {
        
        if Int(integerInput) >= -100 && Int(integerInput) < 100 {
            print(input)
            return true
        }
    }
    return false
}

func checkingMeesageDirection(_ input : String) ->Bool {
    print(input)
    let uppercasedInput = input.uppercased()
    if uppercasedInput == "R" || uppercasedInput == "L" {
        return true
    }
    return false
}



