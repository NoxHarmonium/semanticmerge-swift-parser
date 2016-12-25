

extension SemanticSpan: Serialisable {

    func accept(_ serialiser: Serialiser) {
        serialiser.serialise(self)
    }

}

extension SemanticFile: Serialisable {

    func accept(_ serialiser: Serialiser) {
        serialiser.serialise(self)
    }

}

extension SemanticContainer: Serialisable {

    func accept(_ serialiser: Serialiser) {
        serialiser.serialise(self)
    }

}

extension SemanticNode: Serialisable {

    func accept(_ serialiser: Serialiser) {
        serialiser.serialise(self)
    }

}
