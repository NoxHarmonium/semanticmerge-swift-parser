// Thanks: https://github.com/algal/swiftecho

#if os(Linux)
  import Glibc
#else
  import Darwin.C
#endif

func readFromStdin() -> AnyIterator<String> {
    return lineGenerator(file: stdin)
}

func lineGenerator(file:UnsafeMutablePointer<FILE>) -> AnyIterator<String>
{
  return AnyIterator { () -> String? in
    var line:UnsafeMutablePointer<CChar>? = nil
    var linecap:Int = 0
    defer { free(line) }
    let ret = getline(&line, &linecap, file)
    
    if ret > 0 {
      guard let line = line else { return nil }
      return String(validatingUTF8: line)
    }
    else {
      return nil
    }
  }
}
