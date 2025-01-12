//
//  TopAlbumsViewModel.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

@MainActor
@Observable class TopAlbumsViewModel {
    var albums: [Album] = []
    var isLoading = false
    var error: Error?

    private let iTunesAPI: ITunesAPI

    init(iTunesAPI: ITunesAPI) {
        self.iTunesAPI = iTunesAPI
    }

    func loadData() async {
        guard !isLoading else { return }
        isLoading = true
        error = nil

        do {
            albums = try await iTunesAPI.getTopAlbums(limit: 100)
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
