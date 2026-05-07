import Foundation

enum AppConfig {
    static let baseURL = URL(string: "https://moodle.itcorner.qzz.io")!
    static let restPath = "/webservice/rest/server.php"
    static let loginPath = "/login/token.php"

    static let demoUsername = "student1"
    static let demoPassword = "Demo@12345"
    static let demoToken = "c269d73b8ec3265227714bf37f4dd2e4"
    static let demoUserId = 1003
}

