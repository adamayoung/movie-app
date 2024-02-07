//
//  CertificationsController.swift
//  Movie API
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import MovieDomain
import Vapor

public struct CertificationsController: RouteCollection {

    private let fetchMovieCertificationsUseCase: any FetchMovieCertificationsUseCase
    private let fetchTVSeriesCertificationsUseCase: any FetchTVSeriesCertificationsUseCase

    public init(
        fetchMovieCertificationsUseCase: some FetchMovieCertificationsUseCase,
        fetchTVSeriesCertificationsUseCase: some FetchTVSeriesCertificationsUseCase
    ) {
        self.fetchMovieCertificationsUseCase = fetchMovieCertificationsUseCase
        self.fetchTVSeriesCertificationsUseCase = fetchTVSeriesCertificationsUseCase
    }

    public func boot(routes: RoutesBuilder) throws {
        let certifications = routes.grouped("certifications")
        certifications.get("movies", use: showMovies)
        certifications.get("tvseries", use: showTVSeries)
    }

    func showMovies(request: Request) async throws -> View {
        let certifications = try await fetchMovieCertificationsUseCase.execute()
        let certificationsContext = CertificationsContextMapper.map(certifications)

        return try await request.view.render("certifications/certifications-list", certificationsContext)
    }

    func showTVSeries(request: Request) async throws -> View {
        let certifications = try await fetchTVSeriesCertificationsUseCase.execute()
        let certificationsContext = CertificationsContextMapper.map(certifications)

        return try await request.view.render("certifications/certifications-list", certificationsContext)
    }

}
