import UIKit

class EventController: UITableViewController {
    let eventDetailIdentifier = "EventDetail"
    var eventArray = [Event]()
    var simpleEventArray = [SimpleEvent]()
    var events = []
    var selectedIndexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
    }

    func loadEvents() {
        EventService().getEvents({
            (allEvents: NSArray) -> Void in
            self.events = allEvents
            self.tableView.reloadData()
        })
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventTableViewCell", forIndexPath: indexPath) as! EventTableViewCell
        cell.backgroundColor = Color.Blue50()

        if let eventImageUrl = events[indexPath.row]["image"]! {
            let encodedUrl = eventImageUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            cell.eventImageView.contentMode = UIViewContentMode.ScaleAspectFit
            cell.eventImageView.sd_setImageWithURL(NSURL(string: encodedUrl!))
        }

        if let eventName = events[indexPath.row]["japanese_name"]! {
            cell.eventNameLabel.text = eventName as? String
        }

        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == eventDetailIdentifier {
            if let selectedIndex = self.tableView.indexPathForSelectedRow {
                let eventDetailController = segue.destinationViewController as! EventDetailController
                eventDetailController.event = events[selectedIndex.row] as! NSDictionary
            }
        }
    }
}
