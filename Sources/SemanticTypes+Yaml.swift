
extension SemanticSpan: Yamlable {
    func toYamlString() -> String {
        return "{ start: [\(self.start.0), \(self.start.1)], end: [\(self.end.0), \(self.end.1)] }"
    }
}

extension SemanticType {

    func processChildren(children: [SemanticType]?) -> String {
        guard let children = children else { return "[]" }
        let childYamls: [String] = children.map { "- \($0.toYamlString())\n" }
        return childYamls.joined(separator: "\n")
    }

}

extension SemanticFile: Yamlable {

    func toYamlString() -> String {
        return "type: \(self.type)\n" +
            "name: \(self.name)\n" +
            "locationSpan: \(self.locationSpan.toYamlString())\n" +
            "footerSpan: [\(self.footerSpan.0), \(self.footerSpan.1)]\n" +
            "parsingErrorsDetected: \(self.parsingErrorsDetected)\n" +
            "children: \(self.processChildren(children: self.children))\n"
    }

}

extension SemanticContainer: Yamlable {

    func toYamlString() -> String {
        return "type: \(self.type)\n" +
            "name: \(self.name)\n" +
            "locationSpan: \(self.locationSpan.toYamlString())\n" +
            "headerSpan: [\(self.headerSpan.0), \(self.headerSpan.1)]\n" +
            "footerSpan: [\(self.footerSpan.0), \(self.footerSpan.1)]\n" +
            "children: \(self.processChildren(children: self.children))\n"
    }

}

extension SemanticNode: Yamlable {

    func toYamlString() -> String {
        return "type: \(self.type)\n" +
            "name: \(self.name)\n" +
            "locationSpan: \(self.locationSpan.toYamlString())\n" +
            "span: [\(self.span.0), \(self.span.1)]\n" +
            "children: \(self.processChildren(children: self.children))\n"
    }

}
