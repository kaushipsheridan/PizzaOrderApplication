//
//  OrderHistoryViewController.swift
//  Assignment1_Priyanshu
//
//  Created by Priyanshu Kaushik on 2025-03-21.
//

import UIKit

class OrderHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.readDataFromDatabase()
    }
        // Set row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    // Number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.order.count
    }
    
    // Populate the table cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create or reuse a basic UITableViewCell
        let cell : OrderCell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as? OrderCell ?? OrderCell(style: .default, reuseIdentifier: "orderCell")
        
        let order = appDelegate.order[indexPath.row]
        
        // Set primary text (Delivery Date)
        cell.primaryLabel.text = order.deliveryDate;
        
        // Set secondary text (Address)
        cell.secondaryLabel.text = order.address;
        
        // Set image (Avatar)	
        let avatarName = order.avatar ?? "batman" // Use a default image if none selected
        cell.myImageView?.image = UIImage(named: avatarName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = appDelegate.order[indexPath.row]
        
        var pizzaSize = ""
        if order.size == 0 {
            pizzaSize = "Small"
        } else if order.size == 1 {
            pizzaSize = "Medium"
        } else if order.size == 2 {
            pizzaSize = "Large"
        }
            let alertController = UIAlertController(title: "Pizza Details", message: """
                    Order Id: \(order.id ?? 0)
                    Date: \(order.deliveryDate ?? "")
                    Address: \(order.address ?? "")
                    Size: \(pizzaSize)
                    Meat Toppings: \(order.meatToppings ?? "")
                    Veg Toppings: \(order.vegToppings ?? "")
                    """, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
        
        
        
    }
}

    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


