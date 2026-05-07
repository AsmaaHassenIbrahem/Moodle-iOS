import SwiftUI

struct CourseDetailsScreen: View {
    @EnvironmentObject private var session: SessionStore
    @StateObject private var viewModel: CourseDetailsViewModel

    let course: Course

    private let container: AppContainerType

    init(course: Course, container: AppContainerType) {
        self.course = course
        self.container = container
        _viewModel = StateObject(wrappedValue: container.resolveCourseDetailsViewModel())
    }

    var body: some View {
        List {
            Section {
                NavigationLink(AppStrings.viewGrades) {
                    GradesScreen(course: course, container: container)
                }
            }

            switch viewModel.state {
            case .idle, .loading:
                ProgressView(AppStrings.loadingSections)
            case .failed(let message):
                ErrorStateView(message: message) {
                    Task { await viewModel.load(courseId: course.id, session: session) }
                }
            case .loaded(let sections):
                ForEach(sections) { section in
                    Text(section.title)
                }
            }
        }
        .navigationTitle(course.title)
        .task {
            guard case .idle = viewModel.state else { return }
            await viewModel.load(courseId: course.id, session: session)
        }
    }
}
