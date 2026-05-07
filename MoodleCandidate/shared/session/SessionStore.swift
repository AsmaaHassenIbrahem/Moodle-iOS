import Foundation

final class SessionStore: ObservableObject {
    @Published var token: String = AppConfig.demoToken
    @Published var userId: Int = AppConfig.demoUserId
    @Published var isAuthenticating = false
    @Published var authError: String?

    private let api: MoodleAPI

    init(api: MoodleAPI) {
        self.api = api
    }

    @MainActor
    func useDemoCredentials() {
        token = AppConfig.demoToken
        userId = AppConfig.demoUserId
    }

    @MainActor
    func authenticateWithDemoLogin() async {
        isAuthenticating = true
        authError = nil

        defer { isAuthenticating = false }

        do {
            token = try await api.login(
                username: AppConfig.demoUsername,
                password: AppConfig.demoPassword
            )
            userId = AppConfig.demoUserId
            authError = nil
        } catch {
            let message = error.localizedDescription
            authError = error.localizedDescription
            useDemoCredentials()
            authError = message
        }
    }
}
