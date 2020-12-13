# 2021CodeSquadTest

## 작동 순서 :
1. 초기 큐브 상태 출력 된 후 약속된 명령어를 입력한다. 
2. 각 동작마다 해당 동작 명령어 및 동작 후의 큐브 상태 출력
     - 입력된 명령어들을 수행 한 뒤의 큐브가 모두 맞추어졌는지 검사한다.
3. 종료 시 까지 반복 작동하며, Q를 입력하여 종료
4. 종료 시  작동한 시간, 움직인 횟수와 종료 메세지를 보여준다.


## 사용 상 주의사항 :

### 출력된 큐브 :
큐브의 출력은 수직으로 직교한 모양이다.
``` swift
//                     ㅁ            U
//                    ㅁㅁㅁㅁ    = L  F  R  B
//                     ㅁ            D
```
### 약속된 명령어 :

Q - 종료 
G - 큐브 섞기
*이하의 명령어는 시계방향 회전*
F – 앞 (Front)
R – 오른쪽 (Right)
U – 위 (Up)
B – 뒤 (Back)
L – 왼쪽 (Left)
D – 아랫쪽 (Down)

### 명령어 작성 규칙 및 설명 : 
- 명령어에 Option을 적용 할 수 있다.
    - ' : 작은따옴표, 적용된 명령어를 반시계방향 회전한다. e.g.) F'
    - 2 : 명령을 2회 수행한다. e.g.) F2
        - 해당 Option은 움직인 횟수를 +2한다. 내부적으로 F2를 FF로 변환하여 처리한다.
    - 옵션 먼저 작성 할 수 없다. e.g.) 'F, 2F    
    - 두개의 옵션을 동시에 사용 할 수 없다.
- 대소문자 무관하며, 다수의 명령어 입력 시 연속으로 작동한다 (종료 및 큐브섞기 명령어 포함) 
    - FDR2
- 명령의 중간에 "Q"가 있을 경우 이후의 동작은 실행되지 않는다.
- 입력 중 약속된 명령어가 아닌 경우, 해당 내용을 무시하고 정상 동작 명령어를 순차 작동

### 주의사항 : 
- 1시간 이상 사용 시, 옳은 시간이 표현되지 않을 수 있다. 현재의 소요시간 출력은 mm:ss의 형태로 지정되어 있다.
- F''와 같은 비정상 명령어를 입력 시 프로그램이 오류로 인해 종료 될 수 있다.

## 코드에 대한 설명 :

### 구조체에 대한 설명 : 
구조체는 Cube2D와 Cube3D가 존재한다.

1. Cube2D
    Cube2D는 step-2에서 쓰인, 큐브의 하나의 평면이다.
    Cube3D에서 전체 면이 동일한지 검사하기위해 Equtable을 상속한다.
    
    내부 메서드로 현재 평면을 Clockwise, CounterClockwise로 회전시키거나, 행,열의 요소를 받거나, 지정하는 것 등이 존재한다.

``` swift

struct Cube2D : Equatable {
    var topLayer : [String]
    var middleLayer : [String]
    var bottomLayer : [String]
```


* Cube2D의 내부 메소드는 다음과 같다.*
 - .init
 - 평면의 시계,반시계 회전
 - 평면의 row, column의 변형된 get, set
 - 평면 내용 출력

2. Cube3D
    3차원 큐브, 각 면은 Cube2D이다.
        cubeSides에 각 면을 [Cube2D]로 저장한다. 
        enum NumberingSides와 index가 일치하는 각 면의 역할을 지정한다.
        startTime은 큐브가 생성된 시간을 갖는다, 추후 종료시간과 비교를 통해 소요 시간을 계산한다.
        side 구조체 메서드 중 읽고 쓰기 복잡한 코드가 일부 존재한다. (큐브 움직임 관련), 해당 코드의 가시성을 높이고자 만들어낸 변수.
        moves  큐브의 움직인 횟수를 기록하는 변수
        
``` swift
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
``` 

*Cube3D의 내부 메소드는 다음과 같다.*
 - .init
 - 큐브 회전
    - 시계방향 회전
    - 반시계 방향 회전
        - target 평면에 붙은 옆면의 이동 관련 메소드 e.g ) U명령의 target평면은 Upper이며, 옆면은 FRBL 이다.
 - 큐브 내용 표시
 - 큐브 종료
 - 큐브 움직임 횟수 출력
 - 큐브 사용 시간 출력
 - 큐브 맞춰짐 확인
 - 위 기능들을 위한 내부 메소드

### 작동 순서에 따른 설명.

1. 전역 변수로 Cube3D의 선언, 생성자 내부에서 각 면의 색상을 지정하며,  큐브의 내용을 출력하여 초기 상태를 표시한다.
``` swift
var currentCube = Cube3D.init()
currentCube.print3DCube()

init (){
    cubeSides[side.upper()] = .init(color: "B")
    cubeSides[side.left()] = .init(color: "W")
    cubeSides[side.front()] = .init(color: "O")
    cubeSides[side.right()] = .init(color: "G")
    cubeSides[side.back()] = .init(color: "Y")
    cubeSides[side.bottom()] = .init(color: "R")
}
```
*아래의 내용은 while문 내부에서 반복한다.*

사용자 입력을 받아, doOptionalBinding 함수를 사용하여 옵셔널 바인딩을 수행하고, String을 반환값으로 받는다. 반환값 inputStringMessage를 doIndiceString함수를 사용하여 String을 Charcter로 나눈 뒤 String으로 변환하여 각각을 String 배열에 append하여 반환한다. EX) AS'D가 입력String이라면 ["A","S","\'","D"]가 반환된다.
``` swift
while(true){
    print(" CUBE> ",terminator :"")
    let inputOptionalMessage = readLine()
    let inputStringMessage = doOptionalBinding(inputOptionalMessage)
    var dicedMessage = doIndiceString(inputStringMessage)
    
``` 

insertAdditionalCommands은 [String]내부에 추가 명령어를 찾아 다른 배열 요소에 병합하는 역할을 한다. 명령어 규칙 상 첫번째에 추가 명령어가 나올 수 없으나, Index오류를 발생 시킬 수 있으므로, 예외처리 한다. input을 순회하며 추가 명령어를 찾아서 item의 마지막 배열 요소에  명령어에 맞는 처리를 한다. -> 순차적으로 검사하므로 마지막 배열 요소에 병합하는 것이 옳다.

``` swift
    dicedMessage = insertAdditionalCommands(dicedMessage)
    
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
``` 

명령어를 적용하는 부분, doCommands의 리턴값은 기본값으로 false, 종료 명령어가 발생하면 True이다. 이 경우 반복문 while을 break하며 프로그램을 종료한다.
명령어 G의 경우, 큐브 무작위 섞기 기능이다. 0...5범위에서 20개의 숫자를뽑아 CW회전 명령어에 각각 대응하여 명령어들을 만들고, doCommands를 재귀하여 출력한다. 이 때 사용자의 큐브회전 동작이 없으므로, moves는 0으로 초기화한다.

``` swift
    if doCommands(dicedMessage,&currentCube) {
        break
        }
        
    func doCommands(_ commands : [String], _ cube : inout Cube3D) -> Bool {
        var exitFlag = false
        for i in 0..<commands.count {
            switch commands[i] {
            case "G":
                doCommands(makeRandom(), &cube)
                cube.moves = 0
                print(commands[i])
                cube.print3DCube()
            case "F":
                print(commands[i])
                cube.turnClockwise(target: Cube3D.NumberingSides.front)
                cube.print3DCube()
                
            // 다수의 회전 동작 생략....
            
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
    
    func makeRandom () -> [String] {
        var item = [String]()
        for i in 0...19{
            let num = Int.random(in: 0...5)
            switch num {
            case 0: item.append("U")
            case 1: item.append("B")
            case 2: item.append("R")
            case 3: item.append("L")
            case 4: item.append("F")
            default: item.append("B")
            }
        }
        return item
    }

``` 

큐브가 맞춰진 것을 판별하는 요소는 두가지이다. 
1. moves가 0보다 큰가?
2. 현재 큐브와 Cube3D.init과 모든 면의 요소가 같은가?
두 가지를 만족할 경우, 축하와 종료메세지를 보내고 반복문 while을 break하여 프로그램을 종료한다.
``` swift
    if (currentCube.checkComplete())&&(currentCube.moves > 0) {
        print("축하합니다, 큐브를 맞췄습니다!")
        currentCube.exitCubing()
        break
    }
}
``` 

### 큐브의 회전

아래와 같이 명령어에 따라, 시계 혹은 반시계 회전을 수행한다. ( cube.turnClockwise, cube.turnCounterClockwise )
기준면 (target)의 평면 자기회전과, 인접한 면의 연결된 블록또한 회전 방향에 맞게 회전한다.
``` swift
func doCommands(_ commands : [String], _ cube : inout Cube3D) -> Bool {
    
    //의 내부에서 
    case "F":
        print(commands[i])
        cube.turnClockwise(target: Cube3D.NumberingSides.front)
        cube.print3DCube()
    case "F'":
        print(commands[i])
        cube.turnCounterClockwise(target: Cube3D.NumberingSides.front)
        cube.print3DCube()
}

mutating func turnClockwise(target : NumberingSides) {
    moves += 1
    switch target {
    case .front:
        setRightMovedRow(target: target)
        cubeSides[target.rawValue].turnRight()
    
    // 중략...
    
    case .right:
        setRightMovedRow(target: target)
        cubeSides[target.rawValue].turnRight()
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
    //후략...
    }
}
``` 
