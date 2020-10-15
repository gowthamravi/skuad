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
    let id : Int?
    let pageURL : String?
    let type : String?
    let tags : String?
    let previewURL : String?
    let previewWidth : Int?
    let previewHeight : Int?
    let webformatURL : String?
    let webformatWidth : Int?
    let webformatHeight : Int?
    let largeImageURL : String?
    let imageWidth : Int?
    let imageHeight : Int?
    let imageSize : Int?
    let views : Int?
    let downloads : Int?
    let favorites : Int?
    let likes : Int?
    let comments : Int?
    let user_id : Int?
    let user : String?
    let userImageURL : String?
}
