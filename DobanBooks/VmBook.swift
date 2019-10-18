//
//  VmBook.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019 2017yd. All rights reserved.
//
import CoreData
import Foundation

class VmBook :NSObject,DataViewModelDelege{
    
    var author: String?
    var authorIntro: String?
    var binding: String?
    var categoryId: UUID?
    var id: UUID
    var image: String?
    var isbn10: String?
    var isbn13: String?
    var pages: Int32?
    var price: String?
    var pubdate: String?
    var publisher: String?
    var summary: String?
    var title: String?
    
    override init(){
        id=UUID()
    }
    static let entityName = "Book"
    static let colAuthor = "author"
    static let colAuthorIntro = "authorIntro"
    static let colBinding = "binding"
    static let colCategoryId = "categoryId"
    static let colId = "id"
    static let colImage = "image"
    static let colIsbn10 = "isbn10"
    static let colIsbn13 = "isbn13"
    static let colPages = "pages"
    static let colPrice = "price"
    static let colPubdate = "pubdate"
    static let colPublisher = "publisher"
    static let colSummary = "summary"
    static let colTitle = "title"
    
    func entityPairs() -> Dictionary<String, Any?> {
        var  dic : Dictionary<String,Any?> = Dictionary<String,Any?>()
         dic[VmBook.colAuthor] = author
         dic[VmBook.colAuthorIntro] = authorIntro
         dic[VmBook.colBinding] = binding
         dic[VmBook.colCategoryId] = categoryId
         dic[VmBook.colId] = id
         dic[VmBook.colImage] = image
         dic[VmBook.colIsbn10] = isbn10
         dic[VmBook.colIsbn13] = isbn13
         dic[VmBook.colPages] = pages
         dic[VmBook.colPrice] = price
         dic[VmBook.colPubdate] = pubdate
        dic[VmBook.colPublisher] = publisher
        dic[VmBook.colSummary] = summary
        dic[VmBook.colTitle] = title
        return dic
    }
    
    func packageself(result: NSFetchRequestResult) {
        let book = result as! Book
         id  = book.id!
        author  = book.author
        authorIntro  = book.authorIntro
        binding  = book.binding
        categoryId  = book.categoryId
        image  = book.image
        isbn10  = book.isbn10
        isbn13  = book.isbn13
        pages  = book.pages
        price  = book.price
        pubdate  = book.pubdate
        publisher = book.publisher
        summary = book.summary
        title = book.title
    }
    
    
}
