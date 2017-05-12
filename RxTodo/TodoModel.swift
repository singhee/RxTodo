import Foundation
import FirebaseDatabase
import RxSwift

struct TodoModel {
    let ref: FIRDatabaseReference
    
    init() {
        self.ref = FIRDatabase.database().reference(withPath: "/List")
    }
    
    func rx_getTodoList() -> Observable<[String]> {
        return Observable.create { observer in
            let handle = self.ref.observe(.value, with: { snapshot in
                print(snapshot.value as! [String])
                observer.onNext(snapshot.value as! [String])
            })
            return Disposables.create {
                self.ref.removeObserver(withHandle: handle)
            }
        }
    }

}


