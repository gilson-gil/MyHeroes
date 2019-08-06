//
//  ImageTextViewBuilderTests.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import MyHeroes

import Quick
import Nimble

final class ImageTextViewBuilderTests: QuickSpec {
    override func spec() {
        describe("given a image text view builder") {
            context("when it builds") {
                let view = ImageTextViewBuilder().setContentMode(.redraw).setCornerRadius(16).setTextSize(24).build()
                it("should apply the correct values to the created view") {
                    expect(view).to(beAKindOf(ImageTextView.self))
                    expect(view.imageView.contentMode).to(equal(.redraw))
                    expect(view.layer.cornerRadius).to(equal(16))
                    expect(view.titleLabel.font.pointSize).to(equal(24))
                }
            }
        }
    }
}
