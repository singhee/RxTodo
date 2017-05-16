import Foundation
import FirebaseDatabase
import RxSwift
import SwiftyJSON

struct Task {
    let key: String
    let text: String
    
    init(json: JSON) {
        self.key = json["key"].stringValue
        self.text = json["text"].stringValue
    }
}

struct TodoModel {
    let ref: FIRDatabaseReference

    init() {
        self.ref = FIRDatabase.database().reference(withPath: "/list")
    }
    
    func rx_getTodoList() -> Observable<[Task]> {
        return Observable.create { observer -> Disposable in
            let handle = self.ref.observe(.value, with: { snapshot in
                let taskList = snapshot.children.flatMap { ($0 as? FIRDataSnapshot)?.value as? [String: Any]}
                    .map { Task(json: JSON($0)) }
                observer.onNext(taskList)
            })
            return Disposables.create {
                self.ref.removeObserver(withHandle: handle)
            }
        }
    }
    
    func addTask(text: String) {
        let key = self.ref.childByAutoId().key
        let todo = [
            "key" : key,
            "text" : text
        ]
        
        ref.updateChildValues(["/\(key)" : todo])
    }
    
    func deleteTask(key: String) {
        self.ref.child("/\(key)").removeValue()
    }
}


