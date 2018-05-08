//
//  CoreDataHandeler.swift
//  PraticeXcode
//
//  Created by LaxmiPrasad Sahu on 08/05/18.
//  Copyright © 2018 C1X. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    /*** get the ManagedObjectContext */
    private class func getcontext() -> NSManagedObjectContext{
     let objectContext = UIApplication.shared.delegate as! AppDelegate
        return objectContext.persistentContainer.viewContext
    }
    /*** Create Enttity To Add Values */
    open class func createEntity(entityName: String) -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.getcontext()) else {
            return NSEntityDescription()
        }
        return entity
    }
    
    /*** Save valu to entity */
    open class func saveValueToEntity(testModel:TestModel) -> Bool{
        let context = getcontext()
        let managedObjectModel = NSManagedObject.init(entity: createEntity(entityName: "Test"), insertInto: context)
        managedObjectModel.setValue(testModel.name, forKey: "name")
        managedObjectModel.setValue(testModel.id, forKey: "id")
        do {
            try context.save()
            return true
        } catch  {
            return false
        }
    }
    
    /*** Fetch datafrom entity */
    open class func fetchdataFromTest() -> [Test]? {
        let context = getcontext()
        var testModel: [Test]?
        do {
             testModel = try context.fetch(Test.fetchRequest())
            return testModel
        } catch  {
            return nil
        }
    }
    /*** Fetch Data from coredata with filter using predicate */
    open class func fetchdataWithFilter() -> [Test]?{
        let context  = getcontext()
        var testModel: [Test]?
        let fetchRequest: NSFetchRequest<Test> = Test.fetchRequest()
        let pradicate = NSPredicate.init(format: "id contains [c] %@", "1")
        fetchRequest.predicate = pradicate
        do {
            testModel =  try context.fetch(fetchRequest)
            return testModel
        } catch  {
            return nil
        }
    }
    /*** Delete data from entity */
    open class func deleteDataFromCoreData(param:String) -> Bool?{
        let context = getcontext()
        let fetchrequest:NSFetchRequest<Test> = Test.fetchRequest()
        let pradicate = NSPredicate.init(format: "id contains [c] %@", param)
        fetchrequest.predicate = pradicate
            if let result = try? context.fetch(fetchrequest) {
            for item in result {
                print(item.id)
                context.delete(item)
                return true
             }
            }
        return false
    }
}
