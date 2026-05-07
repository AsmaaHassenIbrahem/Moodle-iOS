import SwiftUI

struct GradesScreen: View {
    @EnvironmentObject private var session: SessionStore
    @StateObject private var viewModel: GradesViewModel

    let course: Course

    init(course: Course, container: AppContainerType) {
        self.course = course
        _viewModel = StateObject(wrappedValue: container.resolveGradesViewModel())
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView(AppStrings.loadingGrades)
            case .failed(let message):
                ErrorStateView(message: message) {
                    Task { await viewModel.load(courseId: course.id, session: session) }
                }
            case .loaded(let items):
                List(items) { item in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.grade)
                            .font(.subheadline)
                        if let percentage = item.percentage, !percentage.isEmpty {
                            Text(percentage)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle(AppStrings.gradesTitle)
        .task {
            guard case .idle = viewModel.state else { return }
            await viewModel.load(courseId: course.id, session: session)
        }
    }
}
