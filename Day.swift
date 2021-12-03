//
//  Day.swift
//  AOC2021
//
//  Created by Mirza Ucanbarlic on 3. 12. 2021..
//

import Foundation

class Day {
    init(){}
    
    func readInput(filePath: String) -> String {
        let text: String
        do {
            text = try String(contentsOf: URL(fileURLWithPath: filePath), encoding: .utf8)
        } catch {
            print("Error reading file..")
            fatalError()
        }
        return text
    }
    
    func start(){}
}
