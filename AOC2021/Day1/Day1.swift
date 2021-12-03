//
//  Day1.swift
//  AOC2021
//
//  Created by Mirza Ucanbarlic on 3. 12. 2021..
//

import Foundation

class Day1: Day {
    
    override func start() {
        var text: String? = ""
        let fileUrl = "/Users/mirza.ucanbarlic/Desktop/mirza-files/AOC/AOC2021/AOC2021/input"
        do {
            text = try String(contentsOf: URL(fileURLWithPath: fileUrl), encoding: .utf8)
        } catch {
            print("Error reading file..")
        }

        guard let array = text?.split(separator: "\n").map({ Int($0)! }) else { exit(1) }

        var counter = 0

        var previous = 0

        for index in stride(from: 3, to: array.count, by: 1) {
            let value = array[index - 2...index].reduce(0, +)
            if index != 0, value > previous {
                counter += 1
            }
            previous = value
        }

        print(counter)
    }
}
