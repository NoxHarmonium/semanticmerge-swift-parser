import Foundation
import SourceKittenFramework

func processBuffer(buffer: String, filePath: String) -> SemanticFile {
    let file = File(contents: buffer)
    let structure = Structure(file: file)
    let filename = URL(fileURLWithPath: filePath).lastPathComponent
    let span = calculateWholeFileSpan(buffer: buffer)
    return getRootFile(dict: structure.dictionary, filename: filename, locationSpan: span, buffer: buffer)
}

func getRootFile(dict: [String: SourceKitRepresentable], filename: String, locationSpan: SemanticSpan, buffer: String) -> SemanticFile {
    return SemanticFile(
        type: "file",
        name: filename,
        locationSpan: locationSpan,
        footerSpan: (0, -1),
        parsingErrorsDetected: false,
        children: processRepresentableChildren(children: dict["key.substructure"], buffer: buffer)
    )
}

func isValidNode(_ node: SourceKitRepresentable) -> Bool {
  guard let dict = node as? [String: SourceKitRepresentable],
    let _ = dict["key.kind"] as? String,
    let _ = dict["key.name"] as? String else { return false }
  return true
}

func processRepresentableChildren(children: SourceKitRepresentable?, buffer: String) -> [SemanticType]? {
    guard let children = children as? [SourceKitRepresentable] else { return nil }

    return children
      .filter { isValidNode($0) }
      .map {
        let dict = $0 as! [String: SourceKitRepresentable]
        let kind = dict["key.kind"] as! String
        let name = dict["key.name"] as! String
        let offset = Int(dict["key.offset"] as! Int64)
        let length = Int(dict["key.length"] as! Int64)

        if (isContainer(dict: dict)) {
            let bodyOffset = Int(dict["key.bodyoffset"] as! Int64)
            let bodyLength = Int(dict["key.bodylength"] as! Int64)

            let headerStart = offset
            let headerEnd = bodyOffset
            let footerStart = bodyOffset + bodyLength
            let footerEnd = offset + length 
            let locationSpanStart = lineOffsetFromOffset(buffer, offset: headerStart)
            let locationSpanEnd = lineOffsetFromOffset(buffer, offset: footerEnd)
            
            return SemanticContainer(
                type: kind,
                name: name,
                locationSpan: SemanticSpan(start: locationSpanStart, end: locationSpanEnd),
                headerSpan: (headerStart, headerEnd),
                footerSpan: (footerStart, footerEnd),
                children: processRepresentableChildren(children: dict["key.substructure"], buffer: buffer)
            )
        } else {
            let spanStart = offset
            let spanEnd = offset + length
            let locationSpanStart = lineOffsetFromOffset(buffer, offset: spanStart)
            let locationSpanEnd = lineOffsetFromOffset(buffer, offset: spanEnd)

            return SemanticNode(
                type: kind,
                name: name,
                locationSpan: SemanticSpan(start: locationSpanStart, end: locationSpanEnd),
                span: (offset, offset + length),
                children: nil
            )
        }
    }
}

func isContainer(dict: [String: SourceKitRepresentable]?) -> Bool {
    return dict?["key.substructure"] != nil &&
        dict?["key.bodyoffset"] != nil &&
        dict?["key.bodylength"] != nil
}