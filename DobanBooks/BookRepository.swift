//
//  Repository.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019 2017yd. All rights reserved.
//
import CoreData
import Foundation
class BookRepository {
    var app : AppDelegate
    var context : NSManagedObjectContext
    
    init(_ app:AppDelegate) {
        self.app = app
        context = app.persistentContainer.viewContext
    }
    
    func isExists(isbn10:String, isbn13:String) throws -> Bool {
        let fetch = NSFetchRequest <NSFetchRequestResult>(entityName: VmBook.entityName)
        fetch.predicate = NSPredicate(format: "\(VmBook.colIsbn10) = %@ \(VmBook.colIsbn13)",isbn10,isbn13)
        do{
            let result = try context.fetch(fetch) as! [VmBook]
            return result.count > 0
        }catch{
            throw DataError.entityExistsError("isbn")
        }
    }
    func insert(vm :VmBook){
        let description = NSEntityDescription.entity(forEntityName: VmBook.entityName, in: context)
        let book = NSManagedObject(entity: description!, insertInto: context)
        //（值 ，名称）
        book.setValue(vm.author, forKey: VmBook.colAuthor)
        book.setValue(vm.authorIntro, forKey: VmBook.colAuthorIntro )
        book.setValue(vm.binding, forKey: VmBook.colBinding)
        book.setValue(vm.categoryId, forKey: VmBook.colCategoryId)
        book.setValue(vm.id, forKey: VmBook.colId)
        book.setValue(vm.image, forKey: VmBook.colImage)
        book.setValue(vm.isbn10, forKey: VmBook.colIsbn10)
        book.setValue(vm.isbn13, forKey: VmBook.colIsbn13)
        book.setValue(vm.pages, forKey: VmBook.colPages)
        book.setValue(vm.price, forKey: VmBook.colPrice)
        book.setValue(vm.publisher, forKey: VmBook.colPubdate)
        book.setValue(vm.pubdate, forKey: VmBook.colPubdate)
        book.setValue(vm.summary, forKey: VmBook.colSummary)
        book.setValue(vm.title, forKey: VmBook.colTitle)
        app.saveContext()
    }
    
    func get() throws -> [VmBook] {
        var book = [VmBook]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VmBook.entityName)
        do{
            let result = try context.fetch(fetch) as! [VmBook]
            for item in result{
                let vm = VmBook()
                vm.id = item.id
                vm.author = item.author
                vm.authorIntro = item.authorIntro
                vm.binding = item.binding
                vm.categoryId = item.categoryId
                vm.image = item.image
                vm.isbn10 = item.isbn10
                vm.isbn13 = item.isbn13
                vm.pages = item.pages
                vm.price = item.price
                vm.publisher = item.publisher
                vm.pubdate = item.pubdate
                vm.summary = item.summary
                vm.title = item.title
                book.append(vm)
            }
        }catch{
            throw DataError.readCollectionError(" ")
        }
        return book
    }
    
    
    func getBy(keyword format:String , args:[Any]) throws -> [VmBook] {
        var book = [VmBook]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VmBook.entityName)
       
        fetch.predicate = NSPredicate(format: format, argumentArray: args)
        do{
            let result = try context.fetch(fetch) as! [VmBook]
            for item in result{
                let vm = VmBook()
                vm.id = item.id
                vm.author = item.author
                vm.authorIntro = item.authorIntro
                vm.binding = item.binding
                vm.categoryId = item.categoryId
                vm.image = item.image
                vm.isbn10 = item.isbn10
                vm.isbn13 = item.isbn13
                vm.pages = item.pages
                vm.price = item.price
                vm.publisher = item.publisher
                vm.pubdate = item.pubdate
                vm.summary = item.summary
                vm.title = item.title
                book.append(vm)
            }
        }catch{
            throw DataError.readCollectionError("读取数据错误")
        }
        return book
    }
    
    func updata(vm : VmBook) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VmBook.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", vm.id.uuidString)
        do{
            let obj = try context.fetch(fetch)[0] as! NSManagedObject
            
            obj.setValue(vm.author, forKey: VmBook.colAuthor)
            obj.setValue(vm.authorIntro, forKey: VmBook.colAuthorIntro )
            obj.setValue(vm.binding, forKey: VmBook.colBinding)
            obj.setValue(vm.categoryId, forKey: VmBook.colCategoryId)
            obj.setValue(vm.id, forKey: VmBook.colId)
            obj.setValue(vm.image, forKey: VmBook.colImage)
            obj.setValue(vm.isbn10, forKey: VmBook.colIsbn10)
            obj.setValue(vm.isbn13, forKey: VmBook.colIsbn13)
            obj.setValue(vm.pages, forKey: VmBook.colPages)
            obj.setValue(vm.price, forKey: VmBook.colPrice)
            obj.setValue(vm.publisher, forKey: VmBook.colPubdate)
            obj.setValue(vm.pubdate, forKey: VmBook.colPubdate)
            obj.setValue(vm.summary, forKey: VmBook.colSummary)
            obj.setValue(vm.title, forKey: VmBook.colTitle)
            app.saveContext()
        }catch{
            throw DataError.updataError("更新失败")
        }
    }
    
    func detele(id : UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VmBook.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        do{
            let result = try context.fetch(fetch)
            //读取要删除的数据对象
        for item in result{
            
           context.delete(item as! NSManagedObject)
        }
        app.saveContext()
        }catch{
            throw DataError.deteleError("删除失败")
        }
    }
    
}
