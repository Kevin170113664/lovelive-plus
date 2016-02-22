import UIKit

class EventController: UITableViewController {
    var eventArray = [Event]()
    var simpleEventArray = [SimpleEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSimpleEventArray()
    }
    
    func loadSimpleEventArray() {
        eventArray = EventManager().queryAllEvents()
        for event in eventArray {
            simpleEventArray.append(generateSimpleEvent(event))
        }
        removeDuplicateEvent()
    }
    
    func generateSimpleEvent(event: Event) -> SimpleEvent {
        let simpleEvent = SimpleEvent()
        simpleEvent.name = event.japaneseName!
        simpleEvent.image = event.image
        simpleEvent.end = event.end
        
        return simpleEvent
    }
    
    func removeDuplicateEvent() {
        let eventDictionary = NSMutableDictionary()
        
        for simpleEvent in simpleEventArray {
            eventDictionary.setValue(simpleEvent, forKey: simpleEvent.name!)
        }
        
        simpleEventArray.removeAll()
        for simpleEvent in eventDictionary {
            simpleEventArray.append(simpleEvent.value as! SimpleEvent)
        }
        
        simpleEventArray = simpleEventArray.sort({ $0.end! > $1.end! })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpleEventArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventTableViewCell", forIndexPath: indexPath) as! EventTableViewCell
        cell.backgroundColor = Color.Blue50()
        
        if let eventImageUrl = simpleEventArray[indexPath.row].image {
            let encodedUrl = eventImageUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            cell.eventImageView.contentMode = UIViewContentMode.ScaleAspectFit
            cell.eventImageView.sd_setImageWithURL(NSURL(string: encodedUrl!))
        }
        
        if let eventName = simpleEventArray[indexPath.row].name {
            cell.eventNameLabel.text = eventName
        }
        
        return cell
    }
}
