import Foundation

struct MoodleSectionDTO: Decodable {
    let id: Int
    let name: String?
    let summary: String?

    func toModel() -> CourseSection {
        let fallback = HTMLSanitizer.plainText(from: summary ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        return CourseSection(
            id: id,
            title: (name?.isEmpty == false ? name! : fallback).ifEmpty(AppStrings.untitledSection)
        )
    }
}

private extension String {
    func ifEmpty(_ fallback: String) -> String {
        isEmpty ? fallback : self
    }
}

private enum HTMLSanitizer {
    static func plainText(from html: String) -> String {
        guard let data = html.data(using: .utf8) else { return html }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? html
    }
}

