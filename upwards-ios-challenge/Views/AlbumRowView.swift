//
//  AlbumRowView.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

struct AlbumRowView: View {
    let album: Album

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(album.name)
                .font(.headline)
            Text(album.artistName)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
