//
//  Assembler.swift
//  SwiftCPUPackageDescription
//
//  Created by Antwan van Houdt on 15/01/2018.
//

import Foundation

class Assembler {
    
    let contents: String
    
    init?(_ fileName: String) {
        let directory = FileManager.default.currentDirectoryPath
        guard let fileURL = URL(string: "file://\(directory)/\(fileName)") else {
            print("Unable to create a proper url for file reading \(directory)")
            return nil
        }
        guard let buff = try? Data(contentsOf: fileURL) else {
            print("Unable to open file")
            return nil
        }
        guard let str = String(data: buff, encoding: .utf8) else {
            print("Unable to open file")
            return nil
        }
        self.contents = str
    }
    
    func parse(outputFile: URL) {
        let lines = contents.components(separatedBy: "\n")
        var buffer: [UInt8] = [UInt8](repeating: 0, count: 0)
        var lineNumber: Int = 0
        for line in lines {
            guard let instr = self.assemble(instruction: line) else {
                print("Error: unable to parse instruction: '\(line)', on line: \(lineNumber)")
                return
            }
            buffer += instr
            lineNumber += 1
        }
        let dat = Data(bytes: buffer)
        try? dat.write(to: outputFile)
    }
    
    func assemble(instruction: String) -> [UInt8]? {
        let parts = instruction.components(separatedBy: " ")
        guard parts.count > 0 else {
            // Could be an empty line, just ignore this one
            return []
        }
        guard let opCode = parts.first else {
            print("Unable to find opcode in \(instruction)")
            return nil
        }
        var register: String = ""
        var operand1: String = ""
        var operand2: String = ""
        if parts.count > 1 {
            register = parts[1]
        }
        if parts.count > 2 {
            operand1 = parts[2]
        }
        if parts.count > 3 {
            operand2 = parts[3]
        }
        guard let op = OperationCode.fromString(opCode) else {
            print("Unknown opcode \(opCode)")
            return nil
        }
        var registerCount = register.dropFirst()
        registerCount = registerCount.dropLast()
        guard let registerIndex = UInt16(registerCount) else {
            print("Unknown register '\(registerCount)'")
            return nil
        }
        guard let reg = Register(rawValue: registerIndex) else {
            print("Unknown register \(register)")
            return nil
        }
        print("Found instruction: \(op) \(reg) \(operand1) \(operand2)")
        return nil
    }
}
