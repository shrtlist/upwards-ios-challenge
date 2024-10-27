//
//  upwards_ios_challengeApp.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/26/24.
//

import SwiftUI

@main
struct TopAlbumsApp: App {

    var body: some Scene {
        WindowGroup {
            let viewModel = TopAlbumsViewModel(iTunesAPI: ITunesAPI(network: Network(sessionConfig: .default)))
            TopAlbumsView(viewModel: viewModel)
        }
    }
}
