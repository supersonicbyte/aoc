//
//  Day4.swift
//  AOC2021
//
//  Created by Mirza Ucanbarlic on 4. 12. 2021..
//

import Foundation

extension Array where Element : Collection {
    subscript(column column : Element.Index) -> [ Element.Iterator.Element ] {
        return map { $0[column] }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


struct Board {
    struct BoardNumber {
        let number: Int
        var isChecked: Bool
    }
    var matrix: [[BoardNumber]]
    
    var isBingo: Bool {
        for i in 0...matrix.count - 1 {
            if matrix[i].allSatisfy({ $0.isChecked}) || matrix[column: i].allSatisfy({ $0.isChecked }){
                return true
            }
        }
        return false
    }
    
    mutating func checkNumber(number: Int) {
        for (indexRow,row) in matrix.enumerated() {
            for (indexColumn, element) in row.enumerated() {
                if element.number == number {
                    matrix[indexRow][indexColumn].isChecked = true
                }
            }
        }
    }
    
    func unamarkedSum() -> Int {
        var sum = 0
        for row in matrix {
            for element in row {
                if !element.isChecked {
                    sum += element.number
                }
            }
        }
        return sum
    }
}

class Day4: Day {
    
    override func start() {
        var text = readInput(filePath: "/Users/mirza.ucanbarlic/Desktop/mirza-files/AOC/AOC2021/AOC2021/Day4/input").split(separator: "\n")
        let numbers = text[0].split(separator: ",").map({ Int($0)! })
        
        /// Create bord
        text.removeFirst()
        var boards: [Board] = []
        let boardStrings = text.chunked(into: 5)
        for boardString in boardStrings {
            var matrix: [[Board.BoardNumber]] = []
            for row in boardString {
                let matrixRow = row.split(separator: " ").map({ Board.BoardNumber(number: Int($0)!, isChecked: false)})
                matrix.append(matrixRow)
            }
            boards.append(Board(matrix: matrix))
        }
        
        var firstBoardIndex = -1
        var firstBoardNumber = 0
        var lastBoardIndex = 0
        var lastBoardNumber = 0
        for (index, number) in numbers.enumerated() {
            for (boardIndex, _) in boards.enumerated() {
                if boards[boardIndex].isBingo {
                    continue
                }
                boards[boardIndex].checkNumber(number: number)
                if index >= 4 && boards[boardIndex].isBingo {
                    if firstBoardIndex == -1 {
                        firstBoardIndex = boardIndex
                        firstBoardNumber = number
                    } else {
                        lastBoardIndex = boardIndex
                        lastBoardNumber = number
                    }
                }
            }
        }
        
        print("Solution 1: \(boards[firstBoardIndex].unamarkedSum() * firstBoardNumber)")
        print("Solution 2: \(boards[lastBoardIndex].unamarkedSum() * lastBoardNumber)")
        
    }
}
