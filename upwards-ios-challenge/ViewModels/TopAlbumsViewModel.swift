//
//  TopAlbumsViewModel.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

@MainActor
class TopAlbumsViewModel: ObservableObject {
    @Published var albums: [Album] = []
    @Published var isLoading = false
    @Published var error: Error?

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
