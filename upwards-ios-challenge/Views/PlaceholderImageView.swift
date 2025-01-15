//
//  PlaceholderImageView.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 1/14/25.
//

import SwiftUI

struct PlaceholderImageView: View {
    var size = 40.0

    var body: some View {
        Image(systemName: "music.note")
            .font(.system(size: size))
    }
}
