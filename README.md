# 2021CodeSquadTest
## 작동 순서 :
1. 초기 상태 출력 후 동작 명령어 입력. 
    대소문자 무관
    다수의 명령어 입력 시 연속으로 작동한다 (Q 포함) 
    명령의 중간에 "Q"가 있을 경우 이후의 동작은 실행되지 않는다.
2. 입력 중 약속된 명령어가 아닌 경우, 해당 내용을 무시하고 정상 동작 명령어를 순차 작동
3. 각 동작마다 해당 동작 명령어 및 동작 후의 큐브 상태 출력
4. 종료 시 까지 반복 작동하며, Q를 입력하여 종료

## 코드에 대한 설명 :  
변수 선언과 할당 같은 설명이 필수적이지 않을 경우 설명을 누락한 부분이 있습니다.

### 구조체 설명:
구조체 내부에는 큐브의 각 셀에 대한 정보를 가지는 배열, 큐브 내용을 Print하는 메소드, 큐브의 셀을 이동하는 메소드가 있음.

구조체 내 3개의 문자열 배열로 3개의 프로퍼티 선언. 
2차원 배열이 아닌 아래와 같이 구현한 사유는 가독성의 편의를 위함.
```swift
    struct Cube2D {
    var topSide : [String]
    var middleSide : [String]
    var bottomSide : [String]
    }
```

또한 큐브의 초기상태가 정해져 있으므로 생성자는 아래와 같다.
```swift
    init() {
    topSide = ["R","R","W"]
    middleSide = ["G","C","W"]
    bottomSide = ["G","B","B"]
    }
```
8개의 이동 메서드는 아래와 같은 방식으로 구현되어있음.
이해를 위해 두개의 메서드를 설명한다.

struct인 Cube2D를 수정해야 하므로, 메서드는 mutating 키워드를 사용한다.
이동에 사용되는 movingCellsLeft() 메서드는 String을 입력으로 받기 때문에 cellsToMove를 선언하여 사용한다. 
해당 구현에는 여러번 이동하는 경우가 없으므로, movingCellsLeft()의 매개변수인 movingCount는 1로 고정된다.

movingCellsLeft()는 매개변수 inputSentence의 시작 인덱스로부터 movingCount만큼 떨어진 Index를 boundaryIndex에 저장한다. 이를 기준으로 단어를 분리하여 앞 뒤를 바꾸어 병합하여 이동을 구현한다.

movingCellsLeft()의 결과값은 String이므로 doIndiceString을 통해 [String] 형태로 변환하여 각 셀에 다시 대입한다.

leftSideMovingUp()의 경우, 왼쪽에서 오른쪽으로 위의 셀부터 아래 셀로 매칭 할 수 있다.
맨 왼쪽의 것을 왼쪽으로 밀면, 오른쪽으로 가는 것이
맨 위의 것을 위로 밀면 맨 아래로 가는 것으로 치환한 것으로 볼 수 있다.
```swift

    mutating func topSideMovingLeft() {
    let cellsToMove = "\(topSide[0])\(topSide[1])\(topSide[2])"
    topSide = doIndiceString(movingCellsLeft(cellsToMove, 1))
    
    mutating func leftSideMovingUp() {
        let cellsToMove = "\(topSide[0])\(middleSide[0])\(bottomSide[0])"
        let afterCellsMove = doIndiceString(movingCellsLeft(cellsToMove, 1))
        topSide[0] = afterCellsMove[0]
        middleSide[0] = afterCellsMove[1]
        bottomSide[0] = afterCellsMove[2]
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
```


### 작동 순서에 따른 코드 설명

1. Cube2D 구조체를 선언, 초기 상태를 보여준다.
```swift
    var currentCube = Cube2D.init()
    currentCube.printCube()
```
**아래의 내용은 while문 내부에서 반복한다.**

2. 간단한 프롬프트 표시를 위해, print문의 terminator에 공백을 넣어 줄바꿈이 일어나지 않게 한다.
```swift
        print(" CUBE> ",terminator :"")
```

3. 사용자 입력을 받아, doOptionalBinding 함수를 사용하여 옵셔널 바인딩을 수행하고, String을 반환값으로 받는다.
    반환값 inputStringMessage를 doIndiceString함수를 사용하여 String을 Charcter로 나눈 뒤 String으로 변환하여  각각을 String 배열에 append하여 반환한다.
    EX) AS'D가 입력String이라면 ["A","S","\'","D"]가 반환된다.
```swift
    let inputOptionalMessage = readLine()
    let inputStringMessage = doOptionalBinding(inputOptionalMessage)
    var dicedMessage = doIndiceString(inputStringMessage)
    
    func doIndiceString(_ input : String) -> [String] {
        var item = [String]()
        for i in input.indices {
            item.append(String(input[i]))
        }
        return item
    }
```
4. doCommaCombination은 [String]내부에 작은쉼표를 찾아 다른 배열 요소에 병합하는 역할을 한다.
    명령어 규칙 상 첫번째에 작은쉼표가 나올 수 없으나, Index오류를 발생 시킬 수 있으므로, 예외처리 한다.
    input을 순회하며 작은쉼표를 찾아서  item의 마지막 배열 요소에 병합한다. -> 순차적으로 검사하므로 마지막 배열 요소에 병합하는 것이 옳다.
```swift
    dicedMessage = doCommaCombination(dicedMessage)
    
    func doCommaCombination(_ input : [String]) -> [String] {
        var item = [String]()
        for i in 0..<input.count {
            if input[i] == "\'" {
                if i == 0 {
                    print("명령의 첫번째가 '이므로 이를 삭제합니다.")
                    continue
                } else {
                    item[item.count-1] = "\(item[item.count-1])'"
                }
            }
            else {
            item.append(input[i])
            }
        }
        return item
    }
```

5.  doCommands는 명령을 순차 실행하는 함수이다. 사용자가 명령어 도중 혹은 마지막에 종료 커맨드를 사용할 수 있으므로 종료 커맨드"Q" 또한 해당 함수에 같이 구현하였다.
    종료 커맨드 입력 시 True을 반환하여  2~5번까지의 반복을 종료하도록 했다.
    각 이동 명령어의 Case는 구조체 내부의 메서드를 사용하여 구현했다.
```swift
    if doCommands(dicedMessage,currentCube) {
    break
    }
    
    func doCommands(_ commands : [String], _ cube : Cube2D) -> Bool {
        var exitFlag = false
        for i in 0..<commands.count {
            switch commands[i] {
            case "U":
                print(commands[i])
                currentCube.topSideMovingLeft()
                currentCube.printCube()
            
            //사이의 유사한 case 중략 이하 U' B B' R R' L
            
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
```


