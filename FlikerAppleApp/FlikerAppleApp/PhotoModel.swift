//
//  PhotoModel.swift
//  FlikerAppleApp
//
//  Created by Dimo Abdelaziz on 02/06/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import NetworkLayer
import Combine

@MainActor
public final class PhotoModel: ObservableObject {
    @Published var state: ListViewModelState<Photo> = .loading
    @Published var text: String = ""
    @Published var debouncedText: String = ""
    private var bag = Set<AnyCancellable>()
    var canLoadLoadMore: Bool = false
    var lastItemIdex = 0
    private var currentPage: Int = 1

    var data: [Photo] {
        switch state {
        case .loaded(let data):
            return data
        default:
            return []
        }
    }

    private let photosService: PhotosService

    init(photosService: PhotosService, dueTime: TimeInterval = 0.5) {
        self.photosService = photosService
        $text
            .removeDuplicates()
            .debounce(for: .seconds(dueTime), scheduler: DispatchQueue.main)
            .filter({ $0.count >= 3 })
            .sink(receiveValue: { [weak self] value in
                self?.debouncedText = value
            })
            .store(in: &bag)
        
        Task {
            try? await searchForPhoto(query: "Cat")
        }
    }

    func searchForPhoto(query: String) async throws {
        print("🤬🤬\(query)")
        state = .loading
        canLoadLoadMore = false
        currentPage += 1
        let photos = try await photosService.searchForPhoto(query: query, page: Int32(currentPage))
        canLoadLoadMore = true
        state = .loaded(data: photos)
    }
}
