import EncryptorCore

let tool = Encryptor()

do {
    try tool.run()
} catch {
    print("Error: \(error)")
}
