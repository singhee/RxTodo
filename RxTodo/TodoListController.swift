import UIKit
import RxSwift
import SwiftyJSON
import RxCocoa
import RxDataSources

class TodoListController: UIViewController {
    
    @IBOutlet weak var taskField: UITextField!
    @IBOutlet weak var taskAddButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = TodoListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.taskList.bind(to: tableView.rx.items) { tableView, row, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
            cell.updateUI(taskModel: element)
            return cell
            }.disposed(by: disposeBag)
        
        self.taskField.rx.text.bind(to: viewModel.memoText).disposed(by: disposeBag)
        
        self.taskAddButton.rx.tap.subscribe(onNext: {
            self.viewModel.addTask()
            self.taskField.text = ""
        }).disposed(by: disposeBag)
        
        self.tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            let cell = self.tableView.cellForRow(at: indexPath) as! TaskCell
            if let key = cell.key {
                self.viewModel.deleteTask(key: key)
            }
        }).disposed(by: disposeBag)
    }
}
