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
}

var currentCube = Cube2D.init()
print(currentCube)

while(true) {
    
}

