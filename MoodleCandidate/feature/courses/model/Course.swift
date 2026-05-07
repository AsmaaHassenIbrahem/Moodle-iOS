import Foundation

struct Course: Identifiable, Hashable {
    let id: Int
    let title: String
    let progress: Double?
    let imageURL: URL?
}

