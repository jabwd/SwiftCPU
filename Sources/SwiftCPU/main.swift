import Basic
import Utility
import Foundation

let parser = ArgumentParser(usage: "Bla", overview: "bla")
let assemble = parser.add(option: "--assemble", shortName: "-a", kind: String.self, usage: "--assemble filename.s", completion: .filename)

let args = Array(CommandLine.arguments.dropFirst())
do {
    let result = try parser.parse(args)
    if let fileToAssemble = result.get(assemble) {
        // Self location:
        print("Assembling: \(fileToAssemble)")
        guard let assembler = Assembler(fileToAssemble) else {
            fatalError()
        }
        let cwd = FileManager.default.currentDirectoryPath
        assembler.parse(outputFile: URL(string: "file://\(cwd)\(fileToAssemble).bin")!)
    }
} catch {
    print("Error: \(error)")
}

// 0x0001 // ADD
// 0x0000 // R0
// 0x0001 // 1
// 0x0001 // 1
CPU.core0.decode(instruction: 0x0001000000010001)
CPU.core0.decode(instruction: 0x0002000200020001)
CPU.core0.decode(instruction: 0x00030003002A0000)

let state = CPU.core0.registers
print("State: \nProgram counter: \(CPU.core0.programCounter)\(state)")

print("Finished execution")
