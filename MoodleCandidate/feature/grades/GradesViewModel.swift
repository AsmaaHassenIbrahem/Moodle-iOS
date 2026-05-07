import Foundation

final class GradesViewModel: ObservableObject {
    @Published private(set) var state: ViewState<[GradeItem]> = .idle

    private let repository: GradesRepository

    init(repository: GradesRepository) {
        self.repository = repository
    }

    @MainActor
    func load(courseId: Int, session: SessionStore) async {
        state = .loading
        do {
            let grades = try await repository.fetchGrades(token: session.token, courseId: courseId, userId: session.userId)
            state = .loaded(grades)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
