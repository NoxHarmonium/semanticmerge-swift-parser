import SourceKittenFramework

func processBuffer(buffer: String) -> String {
    let file = File(contents: buffer)
    print(Structure(file: file))
    return ""
}