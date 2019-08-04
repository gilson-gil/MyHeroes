//
//  TitleDescriptionThumbnailProtocol.swift
//  MyHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

protocol TitleDescriptionThumbnailProtocol {
    var title: String { get }
    var description: String? { get }
    var thumbnail: Image? { get }
}
