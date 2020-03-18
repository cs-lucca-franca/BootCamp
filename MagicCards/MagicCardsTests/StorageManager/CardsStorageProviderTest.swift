//
//  CardsStorageProviderTest.swift
//  MagicCardsTests
//
//  Created by Adriel de Arruda Moura Freire on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

// swiftlint:disable all

@testable import MagicCards
import XCTest
import Foundation
import CoreData

final class CardsStorageProvideTest: XCTestCase {
    
    private var sut: CardsStorageProvider!
    
    private lazy var mockPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CardsDataModel", managedObjectModel: mockManagedObject)
        return container
    }()
    
    private lazy var mockManagedObject: NSManagedObjectModel = {
        let managedObject = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObject
    }()
    
    override func setUp() {
        super.setUp()
        sut = CardsStorageProvider(container: mockPersistentContainer)
        insertInitialItens()
    }
    
    override func tearDown() {
        removeAllItens()
        super.tearDown()
    }
    
    private func testSave() {
        let oldItensCount = numberOfItemsInPersistentStore()
        sut.save(objects: [Card(id: "b", name: "test", imageUrl: "", types: [""])])
        let newItensCount = numberOfItemsInPersistentStore()
        
        XCTAssertEqual(oldItensCount, newItensCount - 1)
    }
    
    private func testFetch() {
        let itens = sut.fetch()
        XCTAssertEqual(itens.count, 2)
    }
    
    private func testfetchedObjectValue() {
        let card = Card(id: "01", name: "First Object", imageUrl: "imageurl.com.br", types: ["agua", "fogo", "terra", "ar"])
        let fetchedCards = sut.fetch()
        XCTAssertTrue(fetchedCards.contains(where: {$0.name == card.name}))
    }
    
    private func testReset() {
        sut.reset()
        let countItens = numberOfItemsInPersistentStore()
        XCTAssertEqual(countItens, 0)
    }
    
    private func testDelete() {
        let oldItensCount = numberOfItemsInPersistentStore()
        let card = Card(id: "01", name: "First Object", imageUrl: nil, imageData: nil, types: ["agua", "fogo", "terra", "ar"])
        sut.delete(objects: [card])
        let newItensCount = numberOfItemsInPersistentStore()
        
        XCTAssertEqual(oldItensCount - 1, newItensCount)
    }
    
    private func insertInitialItens() {
        let obj1 = NSEntityDescription.insertNewObject(forEntityName: "CDCard", into: mockPersistentContainer.viewContext)
        obj1.setValue("First Object", forKey: "name")
        obj1.setValue("01", forKey: "id")
        obj1.setValue(nil, forKey: "imageData")
        obj1.setValue(["agua", "fogo", "terra", "ar"], forKey: "types")
        
        let obj2 = NSEntityDescription.insertNewObject(forEntityName: "CDCard", into: mockPersistentContainer.viewContext)
        obj2.setValue("second Object", forKey: "name")
        
        do {
            try mockPersistentContainer.viewContext.save()
        }  catch {
            print("Create initial itens failed: \(error)")
            XCTFail()
        }
    }
    
    private func removeAllItens() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCard")
        let objs = try! mockPersistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistentContainer.viewContext.delete(obj)
        }
        
        do {
            try mockPersistentContainer.viewContext.save()
        } catch {
            XCTFail()
        }
    }
    
    private func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDCard")
        let results = try! mockPersistentContainer.viewContext.fetch(request)
        return results.count
    }
}
