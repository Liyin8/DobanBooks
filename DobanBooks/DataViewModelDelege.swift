//
//  DateViewModelDelege.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/15.
//  Copyright © 2019 2017yd. All rights reserved.
//
import CoreData
import Foundation
/**
 - 约束视图模型实现，暴力CoreData Entity相关属性及组装视图模型对象
 */
protocol DataViewModelDelege{
    /// 视图模型必须具有的id属性
    var id :UUID {get}
    
    /// 视图模型 对应的CoreData entity的n名称
    static var entityName : String {get}
    
    /// CoreData Entity属性与对应的视图模型对象属性值
    ///
    /// - return key是CoreData Entity 的各个属性的名称 ，Any对应的值
    func entityPairs() -> Dictionary<String ,Any?>
    
    /// 根据查询结果组装视图模型对象
    ///
    /// - parameter result fetch方法查询结果
    func packageself(result:NSFetchRequestResult)

}
