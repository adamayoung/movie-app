//
//  TMDbHTTPClient.swift
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

import Foundation
import TMDb
import Vapor

final class TMDbHTTPClient: TMDb.HTTPClient {

    private let client: any Client

    init(client: some Client) {
        self.client = client
    }

    func perform(request: TMDb.HTTPRequest) async throws -> TMDb.HTTPResponse {
        let uri = URI(string: request.url.absoluteString)
        let headers = HTTPHeaders(request.headers.map { $0 })
        let clientResponse = try await client.get(uri, headers: headers)

        let data: Data? = {
            guard let body = clientResponse.body else {
                return nil
            }

            return Data(buffer: body)
        }()

        let response = TMDb.HTTPResponse(
            statusCode: Int(clientResponse.status.code),
            data: data
        )

        return response
    }

}
