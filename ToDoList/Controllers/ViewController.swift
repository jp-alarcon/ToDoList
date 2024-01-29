//
//  ViewController.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/24/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [MyTask] = []
    var taskManager = TaskManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: CustomViewsConstants.cellNibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CustomViewsConstants.cellIdentifier)
        
//        taskManager.createTask(record: MyTask(title: "a", completed: false, id: UUID()))
        
        tasks.append(contentsOf: taskManager.getAllTasks() ?? [])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueConstants.tableToDetails, let destinationVC = segue.destination as? DetailsViewController, let task = sender as? MyTask {
            destinationVC.delegate = self
            destinationVC.task = task
        }
        
        if segue.identifier == SegueConstants.tableToDetails, let destinationVC = segue.destination as? DetailsViewController {
            destinationVC.delegate = self
            if let task = sender as? MyTask {
                    destinationVC.task = task
            }
        }
    }
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueConstants.tableToDetails, sender: sender)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomViewsConstants.cellIdentifier, for: indexPath) as! TableViewCell
        let task = tasks[indexPath.row]
        
        cell.delegate = self
        cell.titleLabel.text = task.title
        cell.check(task.completed)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewCell else { return }
        
        var task = tasks[indexPath.row]
        task.completed.toggle()
        let success = taskManager.updateTask(task: task)
        if success {
            tasks[indexPath.row].completed.toggle()
            cell.check(tasks[indexPath.row].completed)
        }
        
    }
    
}

extension ViewController: CellDelegate {
    
    func completedTapped(cell: TableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        
        var task = tasks[index]
        task.completed.toggle()
        let success = taskManager.updateTask(task: task)
        if success {
            tasks[index].completed.toggle()
            cell.check(tasks[index].completed)
        }
    }
    
    func detailsTapped(cell: TableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        let task = tasks[index]
        performSegue(withIdentifier: SegueConstants.tableToDetails, sender: task)
    }
    
}


extension ViewController: DetailsDelegate {
    
    func detailsSaved(task: MyTask) {
        tasks = taskManager.getAllTasks() ?? []
        tableView.reloadData()
    }
    
}
