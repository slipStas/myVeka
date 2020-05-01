//
//  HelperExtensions.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 26.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

extension UILabel {
    
    var optimalHeight : CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude - 15))
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text
            
            label.sizeToFit()
            
            return label.frame.height
        }
    }
}

extension UIViewController {
    
    func animateHeightTable(tableView : UITableView) {
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 0.7, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            index += 1
        }
    }
    
    func animateWidthTable(tableView : UITableView) {
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableWidth: CGFloat = tableView.bounds.size.width
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: tableWidth, y: 0)
        }
        
        var index = 0
        
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 0.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            index += 1
        }
    }
    
    func animateAlphaTable(tableView : UITableView) {
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.alpha = 0.1
        }
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 0.5, delay: 0.05 * Double(index), options: [], animations: {
                cell.alpha = 1
            })
            index += 1
        }
    }
    
    func animateCells(_ tableView: UITableView,cell: UITableViewCell) {
        
        cell.alpha = 0.1
        UIView.animate(withDuration: 0.4, delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        cell.transform = CGAffineTransform.identity.scaledBy(x: 3, y: 3)
                        cell.transform = CGAffineTransform.identity.scaledBy(x: 0.4, y: 0.4)
                        cell.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        })
        UIView.animate(withDuration: 0.6, animations: {
            cell.alpha = 1
        })
    }
}
