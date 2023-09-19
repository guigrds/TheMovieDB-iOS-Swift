import UIKit

protocol Identifiable: AnyObject {}

extension Identifiable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: BaseTableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}
