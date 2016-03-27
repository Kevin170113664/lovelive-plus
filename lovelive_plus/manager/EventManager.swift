import Foundation
import UIKit
import CoreData

class EventManager: NSObject {
    var managedObjectContext: NSManagedObjectContext

    override init() {
        guard let modelURL = NSBundle.mainBundle().URLForResource("CardModel", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc

        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docURL = urls[urls.endIndex - 1]
        let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")

        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }

    func queryAllEvents() -> [Event] {
        let eventFetch = NSFetchRequest(entityName: "Event")
        eventFetch.returnsObjectsAsFaults = false
        do {
            if let eventList = try self.managedObjectContext.executeFetchRequest(eventFetch) as? [Event] {
                return eventList
            } else {
                return []
            }
        } catch {
            fatalError("Failed to fetch cards: \(error)")
        }
    }

    func queryEventByName(eventName: String!) -> Event? {
        let eventFetch = NSFetchRequest(entityName: "Event")
        eventFetch.predicate = NSPredicate(format: "japaneseName = %@", eventName)
        eventFetch.returnsObjectsAsFaults = false
        do {
            if let eventList = try self.managedObjectContext.executeFetchRequest(eventFetch) as? [Event] {
                if eventList.count != 0 {
                    return eventList[0]
                }
            }
            return nil
        } catch {
            fatalError("Failed to fetch cards: \(error)")
        }
    }
}
