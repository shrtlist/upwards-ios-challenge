//
//  AlbumRowView.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

struct AlbumRowView: View {
    let album: Album
    private let frameSize = 60.0
    private let cornerRadius = 8.0
    private let padding = 8.0

    var body: some View {
        HStack {
            if let artworkUrl = album.artworkUrl100,
               let url = URL(string: artworkUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .failure:
                        PlaceholderImageView(size: frameSize) // Indicates an error, show default image
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(cornerRadius)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(cornerRadius)
                    default:
                        // Acts as a placeholder.
                        ProgressView()
                    }
                }
                .frame(maxWidth: frameSize)
            } else {
                PlaceholderImageView(size: frameSize)
            }

            VStack(alignment: .leading, spacing: padding) {
                Text(album.name)
                    .font(.headline)
                Text(album.artistName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, padding)
        }
    }
}

#Preview("CoffeeShopRow") {
    let album = Album(id: "1", name: "Test Album", artworkUrl100: "https://picsum.photos/100/100", artistName: "Test Artist", releaseDate: Date.now)
    AlbumRowView(album: album)
}
