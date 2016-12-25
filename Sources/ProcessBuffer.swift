import Foundation
import SourceKittenFramework

func processBuffer(buffer: String, filePath: String) -> SemanticFile {
    let file = File(contents: buffer)
    let structure = Structure(file: file)
    let filename = URL(fileURLWithPath: filePath).lastPathComponent
    return getRootFile(dict: structure.dictionary, filename: filename)
}

func getRootFile(dict: [String: SourceKitRepresentable], filename: String) -> SemanticFile {
    return SemanticFile(
        type: "file",
        name: filename,
        locationSpan: SemanticSpan(start: (0, 0), end: (0, 0)),
        footerSpan: (0, -1),
        parsingErrorsDetected: false,
        children: processRepresentableChildren(children: dict["key.substructure"])
    )
}

func isValidNode(_ node: SourceKitRepresentable) -> Bool {
  guard let dict = node as? [String: SourceKitRepresentable],
    let _ = dict["key.kind"] as? String,
    let _ = dict["key.name"] as? String else { return false }
  return true
}

func processRepresentableChildren(children: SourceKitRepresentable?) -> [SemanticType]? {
    guard let children = children as? [SourceKitRepresentable] else { return nil }

    return children
      .filter { isValidNode($0) }
      .map {
        let dict = $0 as! [String: SourceKitRepresentable]
        let kind = dict["key.kind"] as! String
        let name = dict["key.name"] as! String

        if (isContainer(dict: dict)) {
            return SemanticContainer(
                type: kind,
                name: name,
                locationSpan: SemanticSpan(start: (0, 0), end: (0, 0)),
                headerSpan: (0, 0),
                footerSpan: (0, 0),
                children: processRepresentableChildren(children: dict["key.substructure"])
            )
        } else {
            return SemanticNode(
                type: kind,
                name: name,
                locationSpan: SemanticSpan(start: (0, 0), end: (0, 0)),
                span: (0, 0),
                children: nil
            )
        }
    }
}

func isContainer(dict: [String: SourceKitRepresentable]?) -> Bool {
    return dict?["key.substructure"] != nil
}