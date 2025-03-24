//
//  OrderViewController.swift
//  Assignment1_Priyanshu
//
//  Created by Priyanshu Kaushik on 2025-02-07.
//

import UIKit

class OrderViewController: UIViewController {
    
    //variables for my text fields
    @IBOutlet var tbdeliveryDate: UIDatePicker!
    @IBOutlet var tbsize: UISegmentedControl!
    @IBOutlet var tbaddress: UITextField!
    
    //variables for topping's buttons
    @IBOutlet var tbVTP: UISwitch!
    @IBOutlet var tbVTO: UISwitch!
    @IBOutlet var tbVTT: UISwitch!
    
    @IBOutlet var tbMTP: UISwitch!
    @IBOutlet var tbMTC: UISwitch!
    @IBOutlet var tbMTB: UISwitch!
    
    //avatar variables
    @IBOutlet var avatarBatman:UIImageView!
    @IBOutlet var avatarSuperman:UIImageView!
    @IBOutlet var avatarJoker:UIImageView!
    
    var selectedAvatar:String? = nil;
    

    //getting avatar images
    let avatarImage=["batman","superman","joker"];
    
    
    //making keybaord go away
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder();
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first!
        
        let touchPoint : CGPoint = touch.location(in: self.view)
        
        if avatarBatman.frame.contains(touchPoint){
            selectedAvatar="batman";
        }
        else if avatarSuperman.frame.contains(touchPoint){
            selectedAvatar="superman"
        }
        else if avatarJoker.frame.contains(touchPoint){
            selectedAvatar="joker"
        }
    }
    
    
    
    
    //cleaing orderdata object
    //intiilzing it with user entered data
    //inert into database using appdeligate
    //display's alert box with user entered data
    @IBAction func addOrder(sender:UIButton){
        
        let o = OrderData()
        
        let date = tbdeliveryDate.date.description
        let address = tbaddress.text ?? "No Address"
        let size = tbsize.selectedSegmentIndex
        
        var meatToppings : [String] = []
        if tbMTB.isOn{
            meatToppings.append("Bacon")
        }
        if tbMTC.isOn{
            meatToppings.append("Chicken")
        }
        if tbMTP.isOn{
            meatToppings.append("Pepperoni")
        }
        let meatToppingsString = meatToppings.isEmpty ? "None" : meatToppings.joined(separator: ", ")
        
        
        var vegToppings : [String] = []
        if tbVTT.isOn{
            vegToppings.append("Tomatoes")
        }
        if tbVTO.isOn{
            vegToppings.append("Onions")
        }
        if tbVTP.isOn{
            vegToppings.append("Pineapple")
        }
        let vegToppingsString = vegToppings.isEmpty ? "None" : vegToppings.joined(separator: ", ")
        
        let avatar = selectedAvatar
        
        
        
        o.initWithOrdersData(theRow: 0, thedeliveryDate: date, theaddress: address, thesize: size, themeatToppings: meatToppingsString, thevegToppings: vegToppingsString, theavatar: selectedAvatar ?? "")
        
        let mainDeligate = UIApplication.shared.delegate as! AppDelegate
        
        let returnCode : Bool = mainDeligate.insertIntoDatabase(o: o);
        
        var returnMessage : String = "ORDER RECIEVED \(address) \(size) \(meatToppingsString) \(vegToppingsString) ";
        
        if returnCode == false{
            returnMessage = "Error Adding Person";
        }
        
        let alertController = UIAlertController(title:"Sqllite Add", message: returnMessage, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true)
            
        }
        
    
    
    
    
    
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
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
