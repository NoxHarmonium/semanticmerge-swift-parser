var buffer: String = ""

for line in readFromStdin() {
  if (line == "end\n") {
    let output = processBuffer(buffer: buffer)
    print ("---\n\(output.toYamlString())")
    break
  }
  buffer += line
}