import UIKit

class FilterRowTableViewCell: UITableViewCell {
    let filterType: FilterType
    
    init(filterType: FilterType) {
        self.filterType = filterType
        super.init(style: .value1, reuseIdentifier: FilterRowTableViewCell.identifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
