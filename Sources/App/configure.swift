//
//  configure.swift
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

import Leaf
import TMDb
import Vapor

// configures your application
func configure(_ app: Application) async throws {
    configureTMDb(app)

    let fileMiddleware = FileMiddleware(publicDirectory: app.directory.publicDirectory)
    app.middleware.use(fileMiddleware)

    app.views.use(.leaf)

    try routes(app)
}

private func configureTMDb(_ app: Application) {
    guard let tmdbAPIKey = Environment.get("TMDB_API_KEY") else {
        fatalError("TMDB_API_KEY environment variable not set")
    }

    let tmdbConfiguration = TMDbConfiguration(
        apiKey: tmdbAPIKey,
        httpClient: TMDbHTTPClient(client: app.client)
    )

    TMDbConfiguration.configure(tmdbConfiguration)
}
