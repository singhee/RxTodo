import UIKit
import RxSwift
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
        
        self.taskField.rx.text.bind(to: viewModel.memoText).disposed(by: disposeBag)
        
        self.viewModel.taskList.bind(to: tableView.rx.items) { tableView, row, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell")!
            cell.textLabel?.text = element
            return cell
        }.disposed(by: disposeBag)
    }
}
