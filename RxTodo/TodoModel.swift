import Foundation
import FirebaseDatabase
import RxSwift

struct TodoModel {
    let ref: FIRDatabaseReference
    
    init() {
        self.ref = FIRDatabase.database().reference()
    }
    
    func rx_getTodoList() -> Observable<[String]> {
        return Observable.create { observer in
            let handle = self.ref.child("list").observe(.value, with: { snapshot in
                observer.onNext(snapshot.children.flatMap { $0 as? String })
            })
            return Disposables.create {
                self.ref.removeObserver(withHandle: handle)
            }
        }
    }
    
    func addTask(text: String) {
        let key = self.ref.child("list").childByAutoId().key
        let todo = [
            "/list/\(key)": text
        ]
        
        ref.updateChildValues(todo)
    }
}


