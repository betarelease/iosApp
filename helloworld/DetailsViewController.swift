import UIKit

class DetailsViewController: UIViewController {
    
    var todo: Todo?
    
    @IBOutlet weak var todoLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoLabel.text = self.todo?.title
    }
}