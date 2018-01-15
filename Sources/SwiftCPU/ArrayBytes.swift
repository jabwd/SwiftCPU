//
//  ArrayBytes.swift
//  SwiftCPU
//
//  Created by Antwan van Houdt on 15/01/2018.
//

extension Array where Iterator.Element == UInt8 {
    
    func getUInt8(_ offset: Int) -> UInt8 {
        return self[offset]
    }
    
    func getUInt16(_ offset: Int) -> UInt16 {
        return UInt16(littleEndian: self.withUnsafeBufferPointer {
            $0.baseAddress!.advanced(by: offset).withMemoryRebound(to: UInt16.self, capacity: 1) { $0 }
            }.pointee)
    }
    
    func getUInt32(_ offset: Int) -> UInt32 {
        return UInt32(littleEndian: self.withUnsafeBufferPointer {
            $0.baseAddress!.advanced(by: offset).withMemoryRebound(to: UInt32.self, capacity: 1) { $0 }
            }.pointee)
    }
    
    func getUInt64(_ offset: Int) -> UInt64 {
        return UInt64(littleEndian: self.withUnsafeBufferPointer {
            $0.baseAddress!.advanced(by: offset).withMemoryRebound(to: UInt64.self, capacity: 1) { $0 }
            }.pointee)
    }
    
    mutating func appendUInt16(_ value: UInt16) {
        self.append(UInt8(value & 0xFF))
        self.append(UInt8((value >> 8) & 0xFF))
    }
    
    mutating func appendUInt32(_ value: UInt32) {
        self.append(UInt8(value & 0xFF))
        self.append(UInt8((value >> 8) & 0xFF))
        self.append(UInt8((value >> 16) & 0xFF))
        self.append(UInt8((value >> 24) & 0xFF))
    }
    
    mutating func appendUInt64(_ value: UInt64) {
        self.append(UInt8(value & 0xFF))
        self.append(UInt8((value >> 8) & 0xFF))
        self.append(UInt8((value >> 16) & 0xFF))
        self.append(UInt8((value >> 24) & 0xFF))
        
        // Second half
        self.append(UInt8((value >> 32) & 0xFF))
        self.append(UInt8((value >> 40) & 0xFF))
        self.append(UInt8((value >> 48) & 0xFF))
        self.append(UInt8((value >> 56) & 0xFF))
    }
}

