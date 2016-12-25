class YamlSerialiser : Serialiser {

    private(set) var buffer: String = ""

    private static let spacesPerIndent = 2
    private lazy var indentString = {
        return String(repeating: " ", count: spacesPerIndent)
    }()
    private var indentationLevel: Int = 0

    func writeChildren(_ children: [SemanticType]?) {
        guard let children = children, children.count > 0 else {
              write("children: []")
              return
        }

        indentationLevel += 1
        for child in children {
            write("-")
            child.accept(self)
        }
        indentationLevel -= 1
    }

    func writeLocationSpan(_ span: SemanticSpan) {
        write("locationSpan:")
        indentationLevel += 1
        span.accept(self)
        indentationLevel -= 1
    }

    func serialise(_ file: SemanticFile) {
        write("type: \(file.type)")
        write("name: \(file.name)")
        writeLocationSpan(file.locationSpan)
        write("footerSpan: [\(file.footerSpan.0), \(file.footerSpan.1)]")
        write("parsingErrorsDetected: \(file.parsingErrorsDetected)")
        writeChildren(file.children)
    }

    func serialise(_ container: SemanticContainer) {
        write("type: \(container.type)")
        write("name: \(container.name)")
        writeLocationSpan(container.locationSpan)
        write("headerSpan: [\(container.headerSpan.0), \(container.headerSpan.1)]")
        write("footerSpan: [\(container.footerSpan.0), \(container.footerSpan.1)]")
        writeChildren(container.children)
    }

    func serialise(_ node: SemanticNode) {
        write("type: \(node.type)")
        write("name: \(node.name)")
        writeLocationSpan(node.locationSpan)
        write("span: [\(node.span.0), \(node.span.1)]")
        writeChildren(node.children)
    }

    func serialise(_ span: SemanticSpan) {
        write("{ start: [\(span.start.0), \(span.start.1)], end: [\(span.end.0), \(span.end.1)] }")
    }

    private func write(_ string: String) {
        let indent = String(repeating: indentString, count: indentationLevel)
        buffer += indent + string + "\n"
    }

}