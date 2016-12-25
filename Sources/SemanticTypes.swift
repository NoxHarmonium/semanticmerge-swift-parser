
typealias Pair = (Int, Int)

struct SemanticSpan {
    var start: Pair
    var end: Pair
}

protocol SemanticType: Serialisable {
    var type: String { get }
    var name: String { get }
    var locationSpan: SemanticSpan { get }
    var children: [SemanticType]? { get }
}

struct SemanticFile: SemanticType {
    var type: String
    var name: String
    var locationSpan: SemanticSpan
    var footerSpan: Pair
    var parsingErrorsDetected: Bool
    var children: [SemanticType]?
}

struct SemanticContainer: SemanticType {
    var type: String
    var name: String
    var locationSpan: SemanticSpan
    var headerSpan: Pair
    var footerSpan: Pair
    var children: [SemanticType]?
}

struct SemanticNode: SemanticType {
    var type: String
    var name: String
    var locationSpan: SemanticSpan
    var span: Pair
    var children: [SemanticType]?
}
