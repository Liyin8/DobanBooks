//
//  DataError.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/12.
//  Copyright © 2019 2017yd. All rights reserved.
//

import Foundation
enum DataError: Error {
    case readCollectionError(String)
    case readSingleError(String)
    case entityExistsError(String)
    case deteleError(String)
    case updataError(String)
    
}
