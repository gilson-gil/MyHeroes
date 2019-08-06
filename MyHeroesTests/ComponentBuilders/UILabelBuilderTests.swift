//
//  UILabelBuilderTests.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import MyHeroes

import Quick
import Nimble

final class UILabelBuilderTests: QuickSpec {
    override func spec() {
        describe("given a label builder") {
            context("when it builds") {
                let view = UILabelBuilder().setSize(17).setText("farfetch").setColor(.purple).setNumberOfLines(4).setTextAlignment(.justified).build()
                it("should apply the correct values to the created view") {
                    expect(view.font.pointSize).to(equal(17))
                    expect(view.text).to(equal("farfetch"))
                    expect(view.textColor).to(equal(.purple))
                    expect(view.numberOfLines).to(equal(4))
                    expect(view.textAlignment).to(equal(.justified))
                }
            }
        }
    }
}
