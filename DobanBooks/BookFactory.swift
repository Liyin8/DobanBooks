//
//  BookFactory.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019 2017yd. All rights reserved.
//

import Foundation
class BookFactory {
    var repository : Repository<VmBook>
    private static var instance :BookFactory?
    private init(_ app:AppDelegate){
        repository = Repository<VmBook>(app)
    }
    static func getInstance(_ app: AppDelegate) -> BookFactory{
        if let obj = instance {
            return obj
        }else{
            let token = "net.lzzy.factory.book"
            DispatchQueue.once(token: token, block: {
                if instance == nil {
                    instance = BookFactory(app)
                }
            })
            return instance!
        }
    }
    
    func getBookOf(category id: UUID) throws -> [VmBook] {
        return try repository.getByRepository([VmBook.colCategoryId], keyword: id.uuidString)
    }
    
    func addBook(book:VmBook) throws -> (Bool,String?){
        do{
            if try repository.isEntityEnxists([VmBook.colIsbn10], keyword: book.isbn10!){
                return (false,"isbn码已存在")
            }
            repository.insert(vm: book)
            return (true,nil)
        }catch DataError.entityExistsError(let info){
            return (false, info)
        }catch{
            return(false,error.localizedDescription)
        }
    }
    
    func getBookBy(id:UUID) throws -> VmBook? {
        let books = try repository.getByRepository([VmBook.colId], keyword: id.uuidString)
        if books.count > 0 {
            return books[0]
        }
        return nil
    }
    
    func isBookExists(book:VmBook) throws -> Bool{
        var match10 = false
        var match13 = false
        if let isbn10 = book.isbn10 {
            if isbn10.count > 0{
                match10 = try repository.isEntityEnxists([VmBook.colIsbn10], keyword: isbn10)
            }
        }
        if let isbn13 = book.isbn13 {
            if isbn13.count > 0{
                match13 = try repository.isEntityEnxists([VmBook.colIsbn13], keyword: isbn13)
            }
        }
        return match10 || match13
    }
    
    func searchBooks(keyword :String) throws -> [VmBook] {
        let cols=[VmBook.colIsbn13,VmBook.colAuthor,VmBook.colTitle,VmBook.colSummary]
        let books = try repository.getBy(cols, keyword: [keyword])
        return books
    }
    
}

