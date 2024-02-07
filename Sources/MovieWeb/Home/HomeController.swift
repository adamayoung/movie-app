import MovieDomain
import Vapor

public struct HomeController: RouteCollection {

    public init() { }

    public func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
    }

    func index(request: Request) async throws -> View {
        return try await request.view.render("home/home")
    }

}
