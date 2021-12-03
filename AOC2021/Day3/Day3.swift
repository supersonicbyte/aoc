//
//  Day3.swift
//  AOC2021
//
//  Created by Mirza Ucanbarlic on 3. 12. 2021..
//

import Foundation

class Day3: Day {
    func solution1() {
        let text = readInput(filePath: "/Users/mirza.ucanbarlic/Desktop/mirza-files/AOC/AOC2021/AOC2021/Day3/input3")
        var counter = [Int](repeating: 0, count: 12)
        let values =  text.split(separator: "\n")
        values.map ({ String($0) }).forEach { string in
            for (index, bit) in string.enumerated() {
                if bit == "1" {
                    counter[index] += 1
                }
            }
        }
        var gamma = ""
        var epsilon = ""
        for element in counter {
            if element > values.count / 2 {
                gamma += "1"
                epsilon += "0"
            } else {
                gamma += "0"
                epsilon += "1"
            }
        }
        guard let gammaInt = Int(gamma, radix: 2), let epsilonInt = Int(epsilon, radix: 2) else {
            exit(0)
        }
        
        print("Solution 1: \(gammaInt * epsilonInt)")
    }
    
    func findMostCommonValue(array: [String], position: Int) -> Int {
        let valuesOfOnes = array.reduce(0) { value, binaryString in
            if binaryString[binaryString.index(binaryString.startIndex, offsetBy: position)] == "1" {
                return value + 1
            } else {
                return value
            }
        }
        if valuesOfOnes >= array.count / 2 {
            return 1
        }
        return 0
    }
    
    func findLeastCommonValue(array: [String], position: Int) -> Int {
        let value = findMostCommonValue(array: array, position: position)
        return value == 1 ? 0 : 1
    }
    
    func filteringCriteria(string: String, value: Int, position: Int) -> Bool {
        let index = string.index(string.startIndex, offsetBy: position)
        return string[index] == Character("\(value)")
    }
    
    func solution2() {
        let text = readInput(filePath: "/Users/mirza.ucanbarlic/Desktop/mirza-files/AOC/AOC2021/AOC2021/Day3/input3")
        var oxygenGeneratorRading = text.split(separator: "\n").map({ String($0) })
        var co2ScrubberRating = oxygenGeneratorRading
        
        var position = 0
        while oxygenGeneratorRading.count > 1 && position < 12 {
            let mostCommonValueOxygen = findMostCommonValue(array:oxygenGeneratorRading , position: position)
            oxygenGeneratorRading = oxygenGeneratorRading.filter({
                filteringCriteria(string: $0, value: mostCommonValueOxygen, position: position)
            })
            position += 1
        }
        
        position = 0
        while co2ScrubberRating.count > 1 && position < 12 {
            let leastCommonValueScrubber = findLeastCommonValue(array: co2ScrubberRating, position: position)
            co2ScrubberRating = co2ScrubberRating.filter({
                filteringCriteria(string: $0, value: leastCommonValueScrubber, position: position)
            })
            position += 1
        }
        
        guard let oxygen = Int(oxygenGeneratorRading.first!, radix: 2), let scrubber = Int(co2ScrubberRating.first!, radix: 2) else {
            exit(0)
        }
        print("\(oxygen) \(scrubber)")
        print("Solution 2: \(oxygen * scrubber)")
        
    }
    override func start() {
        solution1()
        solution2()
    }
}
