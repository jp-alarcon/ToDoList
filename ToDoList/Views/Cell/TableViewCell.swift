//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/25/24.
//

import UIKit

protocol CellDelegate: AnyObject {
    
    func completedTapped(cell: TableViewCell)
    func detailsTapped(cell: TableViewCell)
    
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    
    weak var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func check(_ isOn: Bool) {
        if isOn {
            completedButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            completedButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func completedTapped(_ sender: UIButton) {
        delegate?.completedTapped(cell: self)
    }
    
    @IBAction func detailsTapped(_ sender: UIButton) {
        delegate?.detailsTapped(cell: self)
    }
    
}
