import SwiftUI

@main
struct MoodleCandidateApp: App {
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            MoodleCandidateAppView(container: container)
        }
    }
}
