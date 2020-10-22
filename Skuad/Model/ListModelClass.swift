//
//  ListModelClass.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/15/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import Foundation

struct PixaBayModel : Codable {
    let total : Int?
    let totalHits : Int?
    let hits : [Hits]?
}

struct Hits : Codable {
    let previewURL : String?
    let largeImageURL : String?
}

