//
//  VMCategory.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/12.
//  Copyright © 2019 2017yd. All rights reserved.
//
import CoreData
import Foundation

class VMCategory:NSObject,DataViewModelDelege {
   
    
    var id : UUID
    var name  : String?
    var image : String?
    
    override init() {
        id = UUID()
    }
    static let entityName = "Category"
    static let colId = "id"
    static let colName = "name"
    static let colImage = "image"
    func entityPairs() -> Dictionary<String, Any?> {
        var dic:Dictionary<String,Any?> = Dictionary<String,Any?>()
        dic[VMCategory.colId] = id
        dic[VMCategory.colName] = name
        dic[VMCategory.colImage] = image
        return dic
    }
    
    func packageself(result: NSFetchRequestResult) {
        let category = result as! Category
        id = category.id!
        name = category.name
        image = category.image
    }
}

