import Foundation

struct CoursesRepository {
    let api: MoodleAPI

    func fetchCourses(token: String, userId: Int) async throws -> [Course] {
        let dto = try await api.getUserCourses(token: token, userId: userId)
        return dto.map { $0.toModel(token: token) }
    }
}

