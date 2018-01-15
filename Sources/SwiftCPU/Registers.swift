//
//  Registers.swift
//  SwiftCPUPackageDescription
//
//  Created by Antwan van Houdt on 15/01/2018.
//

internal enum Register: UInt16 {
    case r0 = 0
    case r1 = 1
    case r2 = 2
    case r3 = 3
    case r4 = 4
    
    func put(cpu: CPU, value: UInt32) {
        switch(self) {
        case .r0:
            cpu.registers.r0 = value
            break
        case .r1:
            cpu.registers.r1 = value
            break
        case .r2:
            cpu.registers.r2 = value
            break
        case .r3:
            cpu.registers.r3 = value
            break
        case .r4:
            cpu.registers.r4 = value
            break
        }
    }
}

internal struct Registers: CustomStringConvertible {
    var r0: UInt32
    var r1: UInt32
    var r2: UInt32
    var r3: UInt32
    var r4: UInt32
    
    init() {
        r0 = 0
        r1 = 0
        r2 = 0
        r3 = 0
        r4 = 0
    }
    
    mutating func reset() {
        r0 = 0
        r1 = 0
        r2 = 0
        r3 = 0
        r4 = 0
    }
    
    var description: String {
        var dump = "\n[\n"
        dump += "\tR0: \(r0)\n"
        dump += "\tR1: \(r1)\n"
        dump += "\tR2: \(r2)\n"
        dump += "\tR3: \(r3)\n"
        dump += "\tR4: \(r4)\n"
        dump += "]\n"
        return dump
    }
}
