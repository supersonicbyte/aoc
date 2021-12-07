//
//  Day6.swift
//  AOC2021
//
//  Created by Mirza Ucanbarlic on 6. 12. 2021..
//

import Foundation



class Day6: Day {
    override func start() {
        var array = [Int](repeating: 0, count: 9)
        let lanterfishs = readInput(filePath: "/Users/mirza.ucanbarlic/Desktop/mirza-files/AOC/AOC2021/AOC2021/Day6/input").split(separator: ",").map({
            Int($0.trimmingCharacters(in: .newlines))!
        })
        for number in lanterfishs {
            array[number] += 1
        }
        let days = 256
        
        let count = solve(array: &array, days: days)
        
        print("Solution 2: \(count)")
    }
    
    func solve(array: inout [Int], days: Int) -> Int{
        for _ in 0...days - 1 {
            let new = array[0]
            for i in 0...array.count - 2{
                array[i] = array[i + 1]
            }
            array[8] = new
            array[6] += new
        }
        return array.reduce(0, +)
    }
    
    
}
