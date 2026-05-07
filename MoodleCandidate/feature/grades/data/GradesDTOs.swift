import Foundation

struct MoodleGradesResponseDTO: Decodable {
    let usergrades: [MoodleUserGradeDTO]
}

struct MoodleUserGradeDTO: Decodable {
    let gradeitems: [MoodleGradeItemDTO]
}

struct MoodleGradeItemDTO: Decodable {
    let itemname: String?
    let gradeformatted: String?
    let percentageformatted: String?

    func toModel(index: Int) -> GradeItem {
        GradeItem(
            id: "\(index)-\(itemname ?? AppStrings.gradeFallbackId)",
            name: (itemname ?? AppStrings.unnamedGrade).ifEmpty(AppStrings.unnamedGrade),
            grade: (gradeformatted ?? AppStrings.notAvailable).ifEmpty(AppStrings.notAvailable),
            percentage: percentageformatted
        )
    }
}

private extension String {
    func ifEmpty(_ fallback: String) -> String {
        isEmpty ? fallback : self
    }
}

