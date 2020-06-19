import Foundation

public final class CommandLineTool {
    
    enum Error: Swift.Error {
        
        case missingFileName
        
        case failedToCreateFile
        
    }
    
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            // arguments[1] is always the first user-provided argument passed into the process. The [0] is automatically added and provided the path of the executable.
            throw Error.missingFileName
        }
        
        print("Hello, \(arguments)")
    }
    
}

