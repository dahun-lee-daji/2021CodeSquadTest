# 2021CodeSquadTest
## 작동 순서 : 
1-a. 명령어 형식에 맞춰 명령어 입력
1-b. 명령어 형식 :  WORD(Space)NumberOfMoves(Space)Direction, EX) banana 3 R
1-c. 방향(Direction) 은 R과 L, 대소문자 무관
1-d. 밀어내기 횟수(NumberOfMoves)는 -100<= N <100 범위 내 작동.
2-a. 결과 출력 후 반복적으로 명령어 입력 가능. 
2-b. 명령어 형식이 잘못된 경우 잘못됐다는 안내를 출력 후 다시 명령어를 입력받는다.
3. Q를 입력하여 종료.

## 코드에 대한 설명 :  
변수 선언과 할당 같은 설명이 필수적이지 않을 경우 설명을 누락한 부분이 있습니다.
A. readLine() 을 통해 명령어를 입력.

```swift
    let inputMessage = readLine()
```

B. 입력 메세지와 checkQuitMessage(_ input : Optional<String>) 함수를 사용. 옵셔널 바인딩하고, .uppercased() 메서드적용하여, "Q" 인지 확인.    

```swift
if checkQuitMessage(inputMessage) == true {
    break
}

func checkQuitMessage(_ input : Optional<String>) -> Bool {
    if let inputMessage = input {
        if inputMessage.uppercased() == "Q" {
            return true
        }
    }
    return false
}
```


C. 입력 메세지와  createSplitMessage(_ input : Optional<String>) 함수를 사용, 공백문자로 분리하여 문자열 배열로 반환



```swift
splitedMessage = createSplitMessage(inputMessage)

func createSplitMessage(_ input : Optional<String>) -> [String] {
    var item = [String]()
    if let trueInputMessage = input {
        item = trueInputMessage.components(separatedBy: " ")
    
    } else {
        print("입력에 문제가 있습니다.")
    }
    return item
}
```
    

D.  분리된 메세지가 실행 조건에 맞는지 확인. 
조건에 적합하지 않을경우, 명령어를 다시 입력받는다. 
적합한 명령어의 검열 방법 : 
    1. 분리된 메세지의 갯수가 3개인가?
    2. 입력된 숫자가 -100 <= N <100의 범위에 있으며, Int형이 맞는가? 
    3. 입력된 방향이 R, L 인가? 

``` swift
    if checkMessageSuited(splitedMessage) == false {
    print("입력에 문제가 있습니다.")
    continue
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
```


E.  입력값의 밀어낼 횟수를 String -> Int 형 변환 하여 저장

``` swift
    movingCount = createMovingCount(splitedMessage[1])
    
    func createMovingCount(_ input: String) -> Int {
        var item = Int()
        if let integerInput = Int(input) {
            item = integerInput
        }
        return item
    }
```

    

F.  밀어낼 횟수가 음수일 경우, 명령어의 방향과 반대로 밀어낼 것 이므로, 방향을 반대로 변경하고, 음수를 양수로 바꿔줍니다.


``` swift
    if movingCount<0 {
    mode = splitedMessage[2].uppercased() == "R" ? "L" : "R"
    movingCount = -movingCount
    } else {
        mode = splitedMessage[2].uppercased()
    }
    
```


G.  현재 입력된 단어보다 밀어낼 횟수가 더 큰 경우 나머지연산을 통해 밀어낼 횟수를 단어 길이보다 작게 만듭니다.


```swift
    movingCount = calculateMovingCount(inputWord.count, movingCount)
    
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
```


H. 방향 값에 따라 다른 함수를 실행합니다. 이동할 방향에 따라 잘라낼 Index를 boundaryIndex로 할당하고 해당 위치를 잘라내어 두 개의 SubString으로 변환, 이를 앞뒤를 바꾸어 병합하여 반환합니다.

``` swift
    switch mode {
    case "R":
        resultMessage = movingRight(inputWord, movingCount)
    case "L":
        resultMessage = movingLeft(inputWord, movingCount)
    default:
        print("모드 오류, R,L을 3번째 명령어를 R(r), L(l)로 입력하시오")
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
```


