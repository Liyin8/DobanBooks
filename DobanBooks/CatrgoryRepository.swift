//
//  CatrgoryRepository.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/12.
//  Copyright © 2019 2017yd. All rights reserved.
//
import CoreData
import Foundation
class CategoryRepository {
    // insert ,get ,getByKeyword,delete, update
    
    var app : AppDelegate
    var context : NSManagedObjectContext
    
    
    init(_ app:AppDelegate) {
        self.app = app
        context=app.persistentContainer.viewContext
    }
    
    func isExists(name:String) throws -> Bool {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMCategory.entityName)
        fetch.predicate = NSPredicate(format: "\(VMCategory.colName) = %@", name)
        do{
            let result = try context.fetch(fetch) as! [VMCategory]
           return result.count > 0
        }catch{
            throw DataError.entityExistsError("错误")
        }
    }

    func insert(vm : VMCategory) {
        let description = NSEntityDescription.entity(forEntityName: VMCategory.entityName, in: context)
//        let description = NSEntityDescription.entity(forEntityName: "Category", in: context)
        let category = NSManagedObject(entity: description!, insertInto: context)
        category.setValue(vm.id, forKey: VMCategory.colId)
        category.setValue(vm.name, forKey: VMCategory.colName)
        category.setValue(vm.image, forKey: VMCategory.colImage)
        app.saveContext()
    }
    
    func get() throws -> [VMCategory]{
        var category = [VMCategory]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:VMCategory.entityName)
        do{
            let result = try context.fetch(fetch) as! [VMCategory]
            for item in result {
                let vm = VMCategory()
                vm.id = item.id
                vm.name = item.name
                vm.image = item.image
                category.append(vm)
            }
        }catch{
            throw DataError.readCollectionError("读取信息错误")
        }
        return category 
    }
    
    func getByCategory(keyword format:String , args:[Any]) throws -> [VMCategory] {
        var category = [VMCategory]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMCategory.entityName)
        fetch.predicate = NSPredicate(format: format, argumentArray: args)
        do{
            let result = try context.fetch(fetch) as! [VMCategory]
            for item in result {
                let vm = VMCategory()
                vm.id = item.id
                vm.image = item.image
                vm.name = item.name
                category.append(vm)
            }
            
        }catch{
            throw DataError.readCollectionError("读取数据失败")
        }
        return category
    }
    
    func updata(vm:VMCategory) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMCategory.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", vm.id.uuidString)
        do{
            let obj = try context.fetch(fetch)[0] as! NSManagedObject
            obj.setValue(vm.id, forKey: VMCategory.colId)
            obj.setValue(vm.name, forKey: VMCategory.colName)
            obj.setValue(vm.image, forKey: VMCategory.colImage)
            app.saveContext()
        }catch{
            throw DataError.updataError("更新失败")
        }
    }
    
    func detele(id:UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VmBook.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        do{
            let result = try context.fetch(fetch)
            for i in result{
                context.delete(i as! NSManagedObject)
            }
        }catch{
            throw DataError.deteleError("删除失败")
        }
    }
    
}
