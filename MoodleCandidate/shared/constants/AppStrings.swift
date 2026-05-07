import Foundation

enum AppStrings {
    static let loadingCourses = "Loading courses..."
    static let loadingSections = "Loading sections..."
    static let loadingGrades = "Loading grades..."
    static let usingFallbackToken = "Using fallback token"
    static let coursesTitle = "Courses"
    static let gradesTitle = "Grades"
    static let viewGrades = "View Grades"
    static let progressUnavailable = "Progress unavailable"
    static let somethingWentWrong = "Something went wrong"
    static let retry = "Retry"
    static let untitledCourse = "Untitled Course"
    static let untitledSection = "Untitled Section"
    static let unnamedGrade = "Unnamed Grade"
    static let gradeFallbackId = "grade"
    static let notAvailable = "N/A"
    static let invalidURL = "Invalid request URL."
    static let invalidResponse = "Unexpected response from server."
    static let loginFailed = "Login failed."
    static let tokenQueryName = "token"

    static func progressComplete(_ value: Double) -> String {
        "\(Int(value))% complete"
    }
}

enum APIConstants {
    static let serviceName = "moodle_mobile_app"
    static let getUserCoursesFunction = "core_enrol_get_users_courses"
    static let getCourseContentsFunction = "core_course_get_contents"
    static let getGradesFunction = "gradereport_user_get_grade_items"
    static let tokenParameter = "wstoken"
    static let functionParameter = "wsfunction"
    static let formatParameter = "moodlewsrestformat"
    static let jsonFormat = "json"
    static let usernameParameter = "username"
    static let passwordParameter = "password"
    static let serviceParameter = "service"
    static let userIdParameter = "userid"
    static let courseIdParameter = "courseid"
}

