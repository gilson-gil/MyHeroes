//
//  UIActivityIndicatorBuilderTests.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import MyHeroes

import Quick
import Nimble

final class UIActivityIndicatorBuilderTests: QuickSpec {
    override func spec() {
        describe("given a activity indicator view builder") {
            context("when it builds") {
                let view = UIActivityIndicatorBuilder().setIsAnimating(false).setTintColor(.red).build()
                it("should apply the correct values to the created view") {
                    expect(view).to(beAKindOf(UIActivityIndicatorView.self))
                    expect(view.isAnimating).to(beFalse())
                    expect(view.tintColor).to(equal(.red))
                }
            }
        }
    }
}
