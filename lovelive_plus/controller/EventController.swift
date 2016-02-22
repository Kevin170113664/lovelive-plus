import UIKit

class EventController: UITableViewController {
    var eventArray = [Event]()
    var simpleEventArray = [SimpleEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventArray = EventManager().queryAllEvents()
        for event in eventArray {
            simpleEventArray.append(generateSimpleEvent(event))
        }
    }
    
    func generateSimpleEvent(event: Event) -> SimpleEvent {
        let simpleEvent = SimpleEvent()
        simpleEvent.name = event.japaneseName!
        simpleEvent.image = event.image
        simpleEvent.end = event.end
        
        return simpleEvent
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
            cell.eventImageButton.sd_setBackgroundImageWithURL(NSURL(string: eventImageUrl), forState: UIControlState.Normal)
        }
        if let eventName = simpleEventArray[indexPath.row].name {
            cell.eventNameLabel.text = eventName
        }
        
        return cell
    }
}
