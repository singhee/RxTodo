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
//    func rx_getTaskList() -> Observable<[Task]> {
//        return Observable.create { observer in
//            observer.onNext(self.taskList)
//            return Disposables.create()
//        }
//    }
//    
//    func addTask() {
//        taskList.append(Task(memo: memoText.value!))
//    }
//
//    mutating func deleteTask(index: Int) {
//        taskList.remove(at: index)
//    }
}
