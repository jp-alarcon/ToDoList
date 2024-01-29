//
//  DetailsViewController.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/25/24.
//

import UIKit

protocol DetailsDelegate: AnyObject {
    
    func detailsSaved(task: MyTask)
    
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titelTextField: UITextField!
    @IBOutlet weak var completedSwitch: UISwitch!
    
    var task: MyTask?
    var delegate: DetailsDelegate?
    var taskManager = TaskManager()
    
    @IBAction func deleteTapped(_ sender: UISwitch) {
        if task != nil {
            taskManager.deleteTask(task: task!)
            delegate?.detailsSaved(task: task!)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        if task == nil {
            task = MyTask(title: titelTextField.text ?? "", completed: completedSwitch.isOn, id: UUID())
            taskManager.createTask(record: task!)
        } else {
            task?.title = titelTextField.text ?? ""
            task?.completed = completedSwitch.isOn
            taskManager.updateTask(task: task!)
        }
        
        delegate?.detailsSaved(task: task!)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titelTextField.text = task?.title
        completedSwitch.isOn = task?.completed ?? false
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
