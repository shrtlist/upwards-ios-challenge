//
//  TopAlbumsView.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

struct TopAlbumsView: View {
    @State var viewModel: TopAlbumsViewModel
    @State private var selectedAlbum: Album?
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else {
                    List(searchResults) { album in
                        AlbumRowView(album: album)
                            .onTapGesture {
                                selectedAlbum = album
                                debugPrint(album)
                            }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Top Albums")
            .sheet(item: $selectedAlbum) { album in
                AlbumDetailView(album: album)
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }

    var searchResults: [Album] {
        let albums = viewModel.albums

        if searchText.isEmpty {
            return albums
        } else {
            return albums.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
