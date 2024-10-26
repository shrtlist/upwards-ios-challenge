//
//  TopAlbumsView.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

struct TopAlbumsView: View {
    @StateObject var viewModel: TopAlbumsViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.albums) { album in
                        AlbumRowView(album: album)
                            .onTapGesture {
                                debugPrint(album)
                            }
                    }
                }
            }
            .navigationTitle("Top Albums")
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}
