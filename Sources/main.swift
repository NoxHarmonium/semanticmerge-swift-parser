var buffer: String = ""

for line in readFromStdin() {
  if (line == "end\n") {
    let output = processBuffer(buffer: buffer)
    print(output)
    break
  }
  buffer += line
}