//
//  Day5.swift
//  AOC2021
//
//  Created by Mirza Ucanbarlic on 5. 12. 2021..
//

import Foundation

struct Point {
    let x: Int
    let y: Int
}

struct Line {
    let startPoint: Point
    let endPoint: Point
    var isHorizontal: Bool {
        startPoint.x == endPoint.x
    }
    var isVertical: Bool {
        startPoint.y == endPoint.y
    }
    var isDiagonal: Bool {
        return !isVertical && !isHorizontal
    }
    var maxX: Int {
        return max(startPoint.x, endPoint.x)
    }
    var maxY: Int {
        return max(startPoint.y, endPoint.y)
    }
    var minX: Int {
        return min(startPoint.x, endPoint.x)
    }
    var minY: Int {
        return min(startPoint.y, endPoint.y)
    }
}

struct SubmarineCoordinateSystem {
    var matrix: [[Int]]
    
    mutating func fitLine(line: Line) {
        let maxX = line.maxX
        let maxY = line.maxY
        
        if maxX >= matrix.count {
            for _ in 0...maxX - matrix.count + 1 {
                matrix.append([Int](repeating: 0, count: matrix[0].count))
            }
        }
        if maxY >= matrix[0].count {
            for (index, _) in matrix.enumerated() {
                matrix[index].append(contentsOf: [Int](repeating: 0, count: maxY - matrix[index].count + 1))
            }
        }
    }
    
    mutating func addLine(line: Line) {
        /// Make space for new line
        fitLine(line: line)
        
        if line.isVertical {
            for i in line.minX...line.maxX {
                matrix[i][line.maxY] = matrix[i][line.maxY] + 1
            }
        } else if line.isHorizontal {
            for i in line.minY...line.maxY {
                matrix[line.maxX][i] = matrix[line.maxX][i] + 1
            }
        } else {
            let (xOffset, yOffset) = getXYOffsets(line: line)
            var xStart = line.startPoint.x
            var yStart = line.startPoint.y
            var flag: Bool = false
            while(true) {
                if xStart == line.endPoint.x && yStart == line.endPoint.y {
                    flag = true
                }
                matrix[xStart][yStart] = matrix[xStart][yStart] + 1
                xStart += xOffset
                yStart += yOffset
                if(flag) {
                    break;
                }
            }
        }
    }
    
    func getXYOffsets(line: Line) -> (Int,Int) {
        let xOffset: Int
        if line.startPoint.x == line.endPoint.x {
            xOffset = 0
        } else if line.startPoint.x > line.endPoint.x {
            xOffset = -1
        } else {
            xOffset = 1
        }
        
        let yOffset: Int
        if line.startPoint.y == line.endPoint.y {
            yOffset = 0
        } else if line.startPoint.y > line.endPoint.y {
            yOffset = -1
        } else {
            yOffset = 1
        }
        return (xOffset, yOffset)
    }
    
    func numberOfOverlappingLines() -> Int {
        var counter = 0
        for row in matrix {
            for element in row {
                if element >= 2 {
                    counter += 1
                }
            }
        }
        return counter
    }
    
    func printPrettily() {
        print("Final matrix: \n")
        print(matrix.forEach({
            print("\($0.map({ "\($0)"}).joined(separator: " "))\n")
        }))
    }
}

class Day5: Day {
    override func start() {
        let lines = readInput(filePath: "/Users/mirza.ucanbarlic/Desktop/mirza-files/AOC/AOC2021/AOC2021/Day5/input").split(separator: "\n").map { string -> Line in
            let points = string.components(separatedBy: "->")
            let startPointsString = points[0].split(separator: ",")
            let endPointsString = points[1].split(separator: ",")
            let startPoint = Point(x: Int(startPointsString[1].trimmingCharacters(in: .whitespaces))!, y: Int(startPointsString[0])!)
            let endPoint = Point(x: Int(endPointsString[1])!, y: Int(endPointsString[0].trimmingCharacters(in: .whitespaces))!)
            return Line(startPoint: startPoint, endPoint: endPoint)
        }
        
        var submarineCooardinate = SubmarineCoordinateSystem(matrix: [[0]])
        
        for line in lines {
            submarineCooardinate.addLine(line: line)
        }
        submarineCooardinate.printPrettily()
        
        print("Solution 2: \(submarineCooardinate.numberOfOverlappingLines())")
        
    }
}
