//
//  Repository.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/15.
//  Copyright © 2019 2017yd. All rights reserved.
//
import CoreData
import Foundation
class Repository<T: DataViewModelDelege> where T:NSObject{
    
    var app : AppDelegate
    var context : NSManagedObjectContext
    
    init(_ app:AppDelegate) {
        self.app = app
        context = app.persistentContainer.viewContext
    }
    
    func insert(vm : T){
        let description = NSEntityDescription.entity(forEntityName: T.entityName, in: context)
        let obj = NSManagedObject(entity: description!, insertInto: context)
        //
        for(key,value) in vm.entityPairs(){
            obj.setValue(value, forKey: key)
        }
        app.saveContext()
    }
    
    func isEntityEnxists(_ cols : [String],keyword : String) throws -> Bool {
        var format = " "
        var args = [String] ()
        for col in cols{
            format += "\(col) = %@ || "
            args .append(keyword)
        }
        format.removeLast(3)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: format, argumentArray: args)
        do{
            let result = try context.fetch(fetch)
            return result.count > 0
        }catch{
            throw DataError.entityExistsError("判断数据存在失败")
        }
    }
    
    func get() throws -> [T] {
        var item = [T]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        do{
            let result = try context.fetch(fetch)
            for c in result{
                let m = T()
                m.packageself(result: c as! NSFetchRequestResult)
                item.append(m)
            }
        }catch{
            throw DataError.readSingleError("读取数据失败")
        }
       return item
    }
    ///根据关键词查询某一事实体符合条件的数据 ，模糊查询
    ///
    /// - parameter cols 需要匹配的 例如 （name ，publisher）
    /// - parameter keyword 需要搜索的关键词
    /// - returns 视图模型对象集合
    func getBy(_ cols:[String],keyword :[String] ) throws -> [T] {
        var format = " "
        var args = [String]()
        for col in cols {
            format += "\(col) like %@ || "
            args.append("*\(keyword)*")
        }
        format.removeLast(3)
        var items = [T]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: format, argumentArray: args)
        do{
            let result =  try context.fetch(fetch)
            for c in result {
                let t = T()
                t.packageself(result: c as! NSFetchRequestResult)
                items.append(t)
            }
            return items
        }catch{
            throw DataError.readSingleError("读取数据错误")
        }
    }
    
    func getByRepository(_ cols:[String],keyword :String ) throws -> [T] {
        var format = " "
        var args = [String]()
        for col in cols {
            format += "\(col) = %@ || "
            args.append(keyword)
        }
        format.removeLast(3)
        var items = [T]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: format, argumentArray: args)
        do{
            let result =  try context.fetch(fetch)
            for c in result {
                let t = T()
                t.packageself(result: c as! NSFetchRequestResult)
                items.append(t)
            }
            return items
        }catch{
            throw DataError.readSingleError("读取数据错误")
        }
    }
    
    func update(vm:T)throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", vm.id.uuidString)
        do{
            let obj = try context.fetch(fetch) [0] as! NSManagedObject
            for (key,value) in vm.entityPairs(){
                obj.setValue(value, forKey: key)
                app.saveContext()
            }
        }catch{
            throw DataError.updataError("更新失败")
        }
    }
    
    func delete(id:UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: "id = %@",id.uuidString)
        do{
            let obj = try context.fetch(fetch) [0] as! NSManagedObject
            context.delete(obj)
            app.saveContext()
        }catch{
            throw DataError.deteleError("删除失败")
        }
    }
    
}
