import Foundation
import Moya
import Swinject

protocol AppContainerType {
    func resolveSessionStore() -> SessionStore
    func resolveCoursesViewModel() -> CoursesViewModel
    func resolveCourseDetailsViewModel() -> CourseDetailsViewModel
    func resolveGradesViewModel() -> GradesViewModel
}

final class AppContainer: AppContainerType {
    private let container: Container

    init() {
        let container = Container()

        container.register(MoyaProvider<MoodleTarget>.self) { _ in
            MoyaProvider<MoodleTarget>()
        }
        .inObjectScope(.container)

        container.register(MoodleAPI.self) { resolver in
            MoodleAPI(provider: resolver.resolve(MoyaProvider<MoodleTarget>.self)!)
        }
        .inObjectScope(.container)

        container.register(SessionStore.self) { resolver in
            SessionStore(api: resolver.resolve(MoodleAPI.self)!)
        }
        .inObjectScope(.container)

        container.register(CoursesRepository.self) { resolver in
            CoursesRepository(api: resolver.resolve(MoodleAPI.self)!)
        }

        container.register(CourseDetailsRepository.self) { resolver in
            CourseDetailsRepository(api: resolver.resolve(MoodleAPI.self)!)
        }

        container.register(GradesRepository.self) { resolver in
            GradesRepository(api: resolver.resolve(MoodleAPI.self)!)
        }

        container.register(CoursesViewModel.self) { resolver in
            CoursesViewModel(repository: resolver.resolve(CoursesRepository.self)!)
        }

        container.register(CourseDetailsViewModel.self) { resolver in
            CourseDetailsViewModel(repository: resolver.resolve(CourseDetailsRepository.self)!)
        }

        container.register(GradesViewModel.self) { resolver in
            GradesViewModel(repository: resolver.resolve(GradesRepository.self)!)
        }

        self.container = container
    }

    func resolveSessionStore() -> SessionStore {
        container.resolve(SessionStore.self)!
    }

    func resolveCoursesViewModel() -> CoursesViewModel {
        container.resolve(CoursesViewModel.self)!
    }

    func resolveCourseDetailsViewModel() -> CourseDetailsViewModel {
        container.resolve(CourseDetailsViewModel.self)!
    }

    func resolveGradesViewModel() -> GradesViewModel {
        container.resolve(GradesViewModel.self)!
    }
}
