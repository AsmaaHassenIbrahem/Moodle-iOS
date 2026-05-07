import Foundation

struct CourseDetailsRepository {
    let api: MoodleAPI

    func fetchSections(token: String, courseId: Int) async throws -> [CourseSection] {
        let dto = try await api.getCourseContents(token: token, courseId: courseId)
        return dto.map { $0.toModel() }
    }
}

