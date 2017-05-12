import Foundation
import RxSwift

struct TodoListViewModel {
    let model: TodoModel
    
    let taskList: Observable<[String]>
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
}
