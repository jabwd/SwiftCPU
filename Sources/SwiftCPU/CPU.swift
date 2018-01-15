//
//  CPU.swift
//  SwiftCPUPackageDescription
//
//  Created by Antwan van Houdt on 15/01/2018.
//

internal class CPU {
    
    // All hail the glorious 8 core
    static let core0 = CPU()
    static let core1 = CPU()
    static let core2 = CPU()
    static let core3 = CPU()
    static let core4 = CPU()
    static let core5 = CPU()
    static let core6 = CPU()
    static let core7 = CPU()
    
    internal var registers: Registers
    
    internal var overflow:       UInt32
    internal var programCounter: UInt32
    
    private init() {
        registers      = Registers()
        overflow       = 0
        programCounter = 0
    }
    
    func decode(instruction: UInt64) {
        guard let instr = Instruction(instruction) else {
            print("Unable to parse instruction \(instruction)")
            return
        }
        instr.execute(cpu: self)
        programCounter += 1
    }
    
    func reset() {
        self.registers.reset()
        
        overflow       = 0
        programCounter = 0
    }
    
    deinit {
        
    }
}
