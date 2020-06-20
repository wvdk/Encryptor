import Foundation
import Files

public final class CommandLineTool {
    
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            // arguments[1] is always the first user-provided argument passed into the process. The [0] is automatically added and provided the path of the executable.
            throw Error.missingFileName
        }
        
        let originalFileName = arguments[1]
        
        guard let originalFile = try? Folder.current.file(at: originalFileName),
            let originalData = try? originalFile.read() else {
            throw Error.couldNotLoadFile
        }
        
        let encryptedData = RNCryptor.encrypt(data: originalData, withPassword: "1234")
        
        var targetFileName = "\(originalFileName).enc"
        if arguments.count > 2 {
            targetFileName = arguments[2]
        }
        
        do {
            try Folder.current.createFile(at: targetFileName, contents: encryptedData)
        } catch {
            print("Error: \(error)")
        }
    }
    
    enum Error: Swift.Error {
        
        case missingFileName
        
        case failedToCreateFile
        
        case couldNotLoadFile
        
    }
    
}

