#if os(Linux)
  import Glibc
#else
  import Darwin.C
#endif
import Dispatch

func printHelp(_ args: [String]) {
  print("Usage: \(args[0]) shell flag_file_path")
  print("See: https://users.semanticmerge.com/documentation/external-parsers/external-parsers-guide.shtml")
}

func argumentsAreValid(_ args: [String]) -> Bool {
  return args.count == 3 && args[1] == "shell"
}

func createFlagFile(_ flagFile: String) {
  try! "\n".write(toFile: flagFile, atomically: false, encoding: String.Encoding.utf8)
}

func exitIfEnd(_ value: String) {
  if value.trimmingCharacters(in: .whitespacesAndNewlines) == "end" {
    exit(0)
  }
}

func serialiseOutputObject(_ outputObject: SemanticFile) -> String {
  let serialiser = YamlSerialiser()
  outputObject.accept(serialiser)
  return serialiser.buffer
}


let args = CommandLine.arguments
if !argumentsAreValid(args) {
  printHelp(args)
  exit(1)
}

let flagFile = args[2]

createFlagFile(flagFile)

let iter = readFromStdin()
var lastValue: String? = nil

for value in iter {
  exitIfEnd(value)
  
  guard let inputFile = lastValue?.trimmingCharacters(in: .whitespacesAndNewlines) else { 
    lastValue = value
    continue
  }

  let outputFile = value.trimmingCharacters(in: .whitespacesAndNewlines)

  do {
    let buffer = try String(contentsOfFile: inputFile, encoding: String.Encoding.utf8)
    let outputObject = processBuffer(buffer: buffer)
    let outputString = serialiseOutputObject(outputObject)
    try outputString.write(toFile: outputFile, atomically: false, encoding: String.Encoding.utf8)
    print("OK")
  } catch {
    print("KO")
  }
}
