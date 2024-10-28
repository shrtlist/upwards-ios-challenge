//
//  upwards_ios_challengeTests.swift
//  upwards-ios-challengeTests
//
//  Created by Alex Livenson on 11/3/23.
//

import XCTest
@testable import upwards_ios_challenge

final class upwards_ios_challengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func testfetchAlbums() async {
        let mockNetwork = MockNetwork(sessionConfig: .default)
        let iTunesAPI = ITunesAPI(network: mockNetwork)
        let sut = TopAlbumsViewModel(iTunesAPI: iTunesAPI)

        await sut.loadData()

        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.albums.count > 0)
        XCTAssertNil(sut.error)
    }

    @MainActor func testAlbum() async {
        let mockNetwork = MockNetwork(sessionConfig: .default)
        let sut = ITunesAPI(network: mockNetwork)

        do {
            let albums = try await sut.getTopAlbums()
            XCTAssertTrue(albums.count > 0)

            let album = albums.first
            XCTAssertNotNil(album?.artistName)
            XCTAssertNotNil(album?.artworkUrl100)
            XCTAssertNotNil(album?.name)
            XCTAssertNotNil(album?.releaseDate)
            XCTAssertNotNil(album?.id)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
