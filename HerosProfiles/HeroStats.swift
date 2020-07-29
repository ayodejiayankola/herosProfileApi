//
//  HeroStats.swift
//  HerosProfiles
//
//  Created by Ayodeji Ayankola on 7/28/20.
//  Copyright © 2020 konga. All rights reserved.
//

import Foundation
struct HeroStats:Decodable {
    let localized_name:String
    let primary_attr:String
    let attack_type:String
    let legs:Int
    let img:String
}



