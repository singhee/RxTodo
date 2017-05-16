import Foundation
import RxSwift
import SwiftyJSON

struct TodoListViewModel {
    let model: TodoModel
    
    let taskList: Observable<[Task]>
    var memoText = Variable<String?>("")

    init() {
        self.model = TodoModel()
        self.taskList = self.model.rx_getTodoList().observeOn(MainScheduler.instance)
    }
    
    func addTask() {
        if let text = memoText.value {
            model.addTask(text: text)
        }
    }
    
    func deleteTask(key: String) {
        model.deleteTask(key: key)
    }
}
