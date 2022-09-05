//
//  ViewController.swift
//  Projects 1-3-2
//
//  Created by sasageyo on 3.09.2022.
//

import UIKit
import Foundation

extension String {
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

class ViewController: UITableViewController {
  
    @IBOutlet var flagView: UIImageView!
    
    var flags = [String]()
    var images: Array<UIImage> = []
    var rawNames = [String]()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if(item.hasSuffix("png")) {
                rawNames.append(item)
            }
        }
        
        for item in items {
            if(item.hasSuffix(".png")) {
                let name = item.deletingSuffix(".png")
                flags.append(name.uppercased())
            }
        }
        flags.sort()
        rawNames.sort()
        
        for item in rawNames {
                images.append(UIImage(named: item)!)
        }
        
        
    }
    
    
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Picture")! as UITableViewCell

        cell.textLabel?.text = countryCodes[flags[indexPath.row]]
        cell.imageView?.image = images[indexPath.row]
        cell.imageView?.layer.borderWidth = 0.1
        cell.imageView?.layer.cornerRadius = 5
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // vc.uppercasedName = flags[indexPath.row]
            vc.uppercasedName = countryCodes[flags[indexPath.row]]
            vc.selectedImage = rawNames[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

