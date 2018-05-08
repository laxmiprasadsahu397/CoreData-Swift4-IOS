//
//  TestModel.swift
//  PraticeXcode
//
//  Created by LaxmiPrasad Sahu on 07/05/18.
//  Copyright © 2018 C1X. All rights reserved.
//

import Foundation

struct TestModel:Decodable {
    let id:Int
    let name: String
    let link: String
    let imageUrl: String
    let number_of_lessons:Int
}
