//
//  AlbumDetailView.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
    private let frameSize = 300.0
    private let cornerRadius = 12.0
    private let shadowRadius = 5.0
    @Environment(\.dismiss) private var dismiss

    private var formattedReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: album.releaseDate)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Album Artwork
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
                                    .shadow(radius: shadowRadius)
                            default:
                                // Acts as a placeholder.
                                ProgressView()
                                    .frame(width: frameSize, height: frameSize)
                            }
                        }
                    }

                    // Album Info
                    VStack(spacing: 16) {
                        Text(album.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text(album.artistName)
                            .font(.title3)
                            .foregroundColor(.secondary)

                        Text("Released: \(formattedReleaseDate)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Album Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
