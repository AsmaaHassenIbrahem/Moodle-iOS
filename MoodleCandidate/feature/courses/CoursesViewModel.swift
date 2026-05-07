import Foundation

final class CoursesViewModel: ObservableObject {
    @Published private(set) var state: ViewState<[Course]> = .idle

    private let repository: CoursesRepository

    init(repository: CoursesRepository) {
        self.repository = repository
    }

    @MainActor
    func load(session: SessionStore) async {
        state = .loading
        do {
            let courses = try await repository.fetchCourses(token: session.token, userId: session.userId)
            state = .loaded(courses)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
