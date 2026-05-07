import Foundation

struct GradesRepository {
    let api: MoodleAPI

    func fetchGrades(token: String, courseId: Int, userId: Int) async throws -> [GradeItem] {
        let dto = try await api.getGrades(token: token, courseId: courseId, userId: userId)
        return dto.usergrades.first?.gradeitems.enumerated().map { index, item in
            item.toModel(index: index)
        } ?? []
    }
}

