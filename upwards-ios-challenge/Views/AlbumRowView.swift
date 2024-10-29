//
//  AlbumRowView.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

struct AlbumRowView: View {
    let album: Album
    private let frameSize = 80.0
    private let cornerRadius = 8.0
    private let padding = 8.0

    var body: some View {
        HStack {
            if let artworkUrl = album.artworkUrl100,
               let url = URL(string: artworkUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .failure:
                        Image(systemName: "music.note") // Indicates an error, show default image
                            .resizable()
                            .scaledToFit()
                            .frame(width: frameSize, height: frameSize)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(cornerRadius)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: frameSize)
                            .cornerRadius(cornerRadius)
                    default:
                        // Acts as a placeholder.
                        ProgressView()
                            .frame(width: frameSize, height: frameSize)
                    }
                }
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
