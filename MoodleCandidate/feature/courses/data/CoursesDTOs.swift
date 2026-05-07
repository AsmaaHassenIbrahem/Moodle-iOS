import Foundation

struct MoodleCourseDTO: Decodable {
    let id: Int
    let fullname: String?
    let displayname: String?
    let progress: Double?
    let courseimage: String?
    let overviewfiles: [MoodleOverviewFileDTO]?

    func toModel(token: String) -> Course {
        let rawImage = courseimage ?? overviewfiles?.first?.fileurl
        let imageURL = rawImage.flatMap { URL(string: $0)?.appendingTokenIfNeeded(token) }
        return Course(
            id: id,
            title: fullname ?? displayname ?? AppStrings.untitledCourse,
            progress: progress,
            imageURL: imageURL
        )
    }
}

struct MoodleOverviewFileDTO: Decodable {
    let fileurl: String?
}

private extension URL {
    func appendingTokenIfNeeded(_ token: String) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }
        var queryItems = components.queryItems ?? []
        if !queryItems.contains(where: { $0.name == AppStrings.tokenQueryName }) {
            queryItems.append(URLQueryItem(name: AppStrings.tokenQueryName, value: token))
        }
        components.queryItems = queryItems
        return components.url ?? self
    }
}

