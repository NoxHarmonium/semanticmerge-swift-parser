
protocol Serialiser {

    func serialise(_ file: SemanticFile)
    func serialise(_ container: SemanticContainer)
    func serialise(_ node: SemanticNode)
    func serialise(_ span: SemanticSpan)

}

protocol Serialisable {

    func accept(_ serialiser: Serialiser)
    
}