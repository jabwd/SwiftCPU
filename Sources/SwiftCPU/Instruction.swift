//
//  Instruction.swift
//  SwiftCPUPackageDescription
//
//  Created by Antwan van Houdt on 15/01/2018.
//

internal enum OperationCode: UInt16 {
    case add      = 1
    case subtract = 2
    case move     = 3
    
    static func fromString(_ string: String) -> OperationCode? {
        let real = string.lowercased()
        switch(real) {
        case "add":
            return .add
        case "sub":
            return .subtract
        case "mov":
            return .move
        default:
            return nil
        }
    }
    
    func execute(cpu: CPU, register: Register, operand1: UInt16, operand2: UInt16) {
        switch(self) {
        case .add:
            let registerValue = UInt32(operand1 + operand2)
            register.put(cpu: cpu, value: registerValue)
            break
        case .subtract:
            let registerValue = UInt32(operand1 - operand2)
            register.put(cpu: cpu, value: registerValue)
            break
        case .move:
            register.put(cpu: cpu, value: UInt32(operand1))
            break
        }
    }
}

internal struct Instruction {
    private let operand: OperationCode
    
    private let register: Register
    private let operand1: UInt16
    private let operand2: UInt16
    
    init?(_ raw: UInt64) {
        guard let opcode = OperationCode(rawValue: UInt16((raw >> 48) & 0xFFFF)) else {
            return nil
        }
        self.operand = opcode
        
        guard let register = Register(rawValue: UInt16((raw >> 32) & 0xFFFF)) else {
            return nil
        }
        self.register = register
        operand1 = UInt16((raw >> 16) & 0xFFFF)
        operand2 = UInt16((raw)       & 0xFFFF)
    }
    
    func execute(cpu: CPU) {
        self.operand.execute(cpu: cpu, register: self.register, operand1: operand1, operand2: operand2)
    }
}
