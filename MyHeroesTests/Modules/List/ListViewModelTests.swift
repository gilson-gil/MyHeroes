//
//  ListViewModelTests.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import MyHeroes

import Nimble
import Quick

final class ListViewModelTests: QuickSpec {
    override func spec() {
        let sut: ListViewModel = .init()

        describe("given a list view model") {
            context("with a specific count of characters") {
                let characters: [Character] = (0..<7).map { _ in
                    .init(identifier: 0,
                          name: "",
                          description: "",
                          modified: Date(),
                          resourceURI: "",
                          thumbnail: Image(path: "", extension: nil),
                          comics: ListResponse(available: 0, items: []),
                          stories: ListResponse(available: 0, items: []),
                          events: ListResponse(available: 0, items: []),
                          series: ListResponse(available: 0, items: []))
                }
                sut.characters = characters
                it("should have the same count for configurators") {
                    expect(sut.configurators.count).to(equal(characters.count))
                }
            }
        }
    }
}
