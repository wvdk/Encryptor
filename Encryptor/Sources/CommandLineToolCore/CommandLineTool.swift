import Foundation
import Files

public final class CommandLineTool {
    
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count == 4 else {
            throw Error.incorrectArguments
        }
        
        let operation = arguments[1]
        let fileName = arguments[2]
        let password = arguments[3]
        guard let file = try? Folder.current.file(at: fileName), let fileData = try? file.read() else {
                throw Error.couldNotLoadFile
        }
        let targetFileName = "\(fileName).e"
        
        switch operation {
        case "encrypt":
            print("Encrypting \(fileName) with password...")
            
            let encryptedData = RNCryptor.encrypt(data: fileData, withPassword: password)
            
            do {
                try Folder.current.createFile(at: targetFileName, contents: encryptedData)
                
                print("Finished. Encrypted file saved as \(targetFileName)")
            } catch {
                print("Error: \(error)")
            }
        case "decrypt":
            print("Decrypting...")
            
            do {
                let decryptedData = try RNCryptor.decrypt(data: fileData, withPassword: password)
                let newFileName = fileName.replacingOccurrences(of: ".e", with: "")
                
                do {
                    try Folder.current.createFile(at: newFileName, contents: decryptedData)
                    
                    print("Finished. Decrypted file saved as \(newFileName)")
                } catch {
                    print("Error: \(error)")
                }
            } catch {
                throw Error.couldNotDecryptWithPassword
            }
        default:
            throw Error.incorrectArguments
        }
    }
        
    enum Error: Swift.Error {
        
        case missingFileName
        
        case failedToCreateFile
        
        case couldNotLoadFile
        
        case incorrectArguments
        
        case couldNotDecryptWithPassword
        
    }
    
}

