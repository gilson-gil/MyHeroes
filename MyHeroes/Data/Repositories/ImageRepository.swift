//
//  ImageRepository.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol ImageRepository {
    func fetchImage(for urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void)
}
