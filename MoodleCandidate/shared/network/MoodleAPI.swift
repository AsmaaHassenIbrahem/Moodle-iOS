import Foundation
import Moya

enum MoodleTarget {
    case login(username: String, password: String)
    case userCourses(token: String, userId: Int)
    case courseContents(token: String, courseId: Int)
    case grades(token: String, courseId: Int, userId: Int)
}

extension MoodleTarget: TargetType {
    var baseURL: URL {
        AppConfig.baseURL
    }

    var path: String {
        switch self {
        case .login:
            return AppConfig.loginPath
        case .userCourses, .courseContents, .grades:
            return AppConfig.restPath
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(
                parameters: [
                    APIConstants.usernameParameter: username,
                    APIConstants.passwordParameter: password,
                    APIConstants.serviceParameter: APIConstants.serviceName
                ],
                encoding: URLEncoding.default
            )
        case .userCourses(let token, let userId):
            return .requestParameters(
                parameters: [
                    APIConstants.tokenParameter: token,
                    APIConstants.functionParameter: APIConstants.getUserCoursesFunction,
                    APIConstants.formatParameter: APIConstants.jsonFormat,
                    APIConstants.userIdParameter: userId
                ],
                encoding: URLEncoding.default
            )
        case .courseContents(let token, let courseId):
            return .requestParameters(
                parameters: [
                    APIConstants.tokenParameter: token,
                    APIConstants.functionParameter: APIConstants.getCourseContentsFunction,
                    APIConstants.formatParameter: APIConstants.jsonFormat,
                    APIConstants.courseIdParameter: courseId
                ],
                encoding: URLEncoding.default
            )
        case .grades(let token, let courseId, let userId):
            return .requestParameters(
                parameters: [
                    APIConstants.tokenParameter: token,
                    APIConstants.functionParameter: APIConstants.getGradesFunction,
                    APIConstants.formatParameter: APIConstants.jsonFormat,
                    APIConstants.courseIdParameter: courseId,
                    APIConstants.userIdParameter: userId
                ],
                encoding: URLEncoding.default
            )
        }
    }

    var headers: [String: String]? {
        ["Accept": "application/json"]
    }

    var sampleData: Data {
        Data()
    }
}

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case server(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return AppStrings.invalidURL
        case .invalidResponse:
            return AppStrings.invalidResponse
        case .server(let message):
            return message
        }
    }
}

struct TokenResponseDTO: Decodable {
    let token: String?
    let error: String?
    let errorcode: String?
}

struct MoodleAPI {
    private let provider: MoyaProvider<MoodleTarget>

    init(provider: MoyaProvider<MoodleTarget> = MoyaProvider<MoodleTarget>()) {
        self.provider = provider
    }

    func login(username: String, password: String) async throws -> String {
        let data = try await request(.login(username: username, password: password))
        let dto = try JSONDecoder().decode(TokenResponseDTO.self, from: data)
        if let token = dto.token {
            return token
        }
        throw APIError.server(dto.error ?? AppStrings.loginFailed)
    }

    func getUserCourses(token: String, userId: Int) async throws -> [MoodleCourseDTO] {
        let data = try await request(.userCourses(token: token, userId: userId))
        return try JSONDecoder().decode([MoodleCourseDTO].self, from: data)
    }

    func getCourseContents(token: String, courseId: Int) async throws -> [MoodleSectionDTO] {
        let data = try await request(.courseContents(token: token, courseId: courseId))
        return try JSONDecoder().decode([MoodleSectionDTO].self, from: data)
    }

    func getGrades(token: String, courseId: Int, userId: Int) async throws -> MoodleGradesResponseDTO {
        let data = try await request(.grades(token: token, courseId: courseId, userId: userId))
        return try JSONDecoder().decode(MoodleGradesResponseDTO.self, from: data)
    }

    private func request(_ target: MoodleTarget) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    guard 200..<300 ~= response.statusCode else {
                        continuation.resume(throwing: APIError.invalidResponse)
                        return
                    }
                    continuation.resume(returning: response.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
