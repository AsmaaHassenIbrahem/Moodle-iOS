import Foundation

final class CourseDetailsViewModel: ObservableObject {
    @Published private(set) var state: ViewState<[CourseSection]> = .idle

    private let repository: CourseDetailsRepository

    init(repository: CourseDetailsRepository) {
        self.repository = repository
    }

    @MainActor
    func load(courseId: Int, session: SessionStore) async {
        state = .loading
        do {
            let sections = try await repository.fetchSections(token: session.token, courseId: courseId)
            state = .loaded(sections)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
