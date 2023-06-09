//
//  PhotosService.swift
//  FlikerAppleApp
//
//  Created by Dimo Abdelaziz on 02/06/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import NetworkLayer

class PhotosService {

    let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    @MainActor
    func searchForPhoto(query: String, page: Int32) async throws -> [Photo] {

        let flickrService = FlickrService()

        // Inside a coroutine scope
        return try await flickrService.searchPhotos(query: query, page: page)
    }

}
