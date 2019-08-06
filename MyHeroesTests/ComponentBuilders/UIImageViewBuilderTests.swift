//
//  UIImageViewBuilderTests.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import MyHeroes

import Quick
import Nimble

final class UIImageViewBuilderTests: QuickSpec {
    override func spec() {
        describe("given a image view builder") {
            context("when it builds") {
                let image: UIImage = .init()
                let view = UIImageViewBuilder().setContentMode(.center).setImage(image).build()
                it("should apply the correct values to the created view") {
                    expect(view).to(beAKindOf(UIImageView.self))
                    expect(view.contentMode).to(equal(.center))
                    expect(view.image).to(equal(image))
                }
            }
        }
    }
}
