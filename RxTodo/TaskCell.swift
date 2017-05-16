import UIKit

class TaskCell: UITableViewCell {
    var key: String?
    
    func updateUI(taskModel: Task) {
        self.key = taskModel.key
        self.textLabel?.text = taskModel.text
    }
}
