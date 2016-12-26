import Foundation

func calculateWholeFileSpan(buffer: String) -> SemanticSpan {
    let lines = buffer.components(separatedBy: CharacterSet.newlines)
    let lastLine: String = lines.last ?? ""
    return SemanticSpan(start: (1, 0), end: (lines.count, lastLine.characters.count))
}

func lineOffsetFromOffset(_ buffer: String, offset: Int) -> (Int, Int) {
    let offsetSlice = String(buffer.characters.prefix(offset))
    let tokens = offsetSlice.components(separatedBy: "\n")
    let lineNumber = tokens.count
    let lineOffset = tokens.last?.characters.count ?? 0
    return (lineNumber, lineOffset)
}