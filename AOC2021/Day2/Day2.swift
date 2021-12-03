//
//  Day2.swift
//  AOC2021
//
//  Created by Mirza Ucanbarlic on 3. 12. 2021..
//

import Foundation

enum CommandName: String {
    case forward = "forward"
    case up = "up"
    case down = "down"
}

struct Command {
    let command: CommandName
    let value: Int
}

class Day2: Day {
    override func start() {
        var text: String? = ""
        let fileUrl = "/Users/mirza.ucanbarlic/Desktop/mirza-files/AOC/AOC2021/AOC2021/Day2/input2"
        do {
            text = try String(contentsOf: URL(fileURLWithPath: fileUrl), encoding: .utf8)
        } catch {
            print("Error reading file..")
        }
        guard let commands = text?.split(separator: "\n").compactMap({ string -> Command? in
            let values = string.split(separator: " ")
            let commandName = String(values[0])
            if let commandValue = Int(values[1]) {
             return Command(command: CommandName(rawValue: commandName)!, value: commandValue)
            } else {
                return nil
            }
        }) else {
            exit(1)
        }

        var horizontal = 0
        var depth = 0
        var aim = 0
        
        for command in commands {
            switch command.command {
            case .forward:
                horizontal += command.value
                depth += aim * command.value
            case .down:
                aim += command.value
            case .up:
                aim -= command.value
            }
        }
                
        let final = horizontal * depth
        
        print(final)        
    }
}
