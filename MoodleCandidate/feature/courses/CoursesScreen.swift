import SwiftUI

struct CoursesScreen: View {
    @EnvironmentObject private var session: SessionStore
    @StateObject private var viewModel: CoursesViewModel

    private let container: AppContainerType

    init(container: AppContainerType) {
        self.container = container
        _viewModel = StateObject(wrappedValue: container.resolveCoursesViewModel())
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView(AppStrings.loadingCourses)
            case .failed(let message):
                ErrorStateView(message: message) {
                    Task { await viewModel.load(session: session) }
                }
            case .loaded(let courses):
                List {
                    if let authError = session.authError {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(AppStrings.usingFallbackToken)
                                .font(.headline)
                            Text(authError)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }

                    ForEach(courses) { course in
                        NavigationLink(value: course) {
                            CourseRow(course: course)
                        }
                    }
                }
                .navigationDestination(for: Course.self) { course in
                    CourseDetailsScreen(course: course, container: container)
                }
            }
        }
        .navigationTitle(AppStrings.coursesTitle)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task { await viewModel.load(session: session) }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .task {
            guard case .idle = viewModel.state else { return }
            if session.token == AppConfig.demoToken {
                await session.authenticateWithDemoLogin()
            }
            await viewModel.load(session: session)
        }
    }
}

private struct CourseRow: View {
    let course: Course

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: course.imageURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.15)
            }
            .frame(width: 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 8) {
                Text(course.title)
                    .font(.headline)
                if let progress = course.progress {
                    ProgressView(value: progress / 100.0)
                    Text(AppStrings.progressComplete(progress))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Text(AppStrings.progressUnavailable)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
