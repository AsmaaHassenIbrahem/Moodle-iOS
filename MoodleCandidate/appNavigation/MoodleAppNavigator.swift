import SwiftUI

struct MoodleCandidateAppView: View {
    @StateObject private var session: SessionStore
    private let container: AppContainerType

    init(container: AppContainerType) {
        self.container = container
        _session = StateObject(wrappedValue: container.resolveSessionStore())
    }

    var body: some View {
        NavigationStack {
            CoursesScreen(container: container)
        }
        .environmentObject(session)
    }
}
