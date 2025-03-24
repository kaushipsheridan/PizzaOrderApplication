//
//  AppDelegate.swift
//  Assignment1_Priyanshu
//
//  Created by Priyanshu Kaushik on 2025-02-07.
//

import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var databaseName: String = "myordersdb.db";
    var databasePath: String = "";
    
    var order : [OrderData] = [];
    
    
    //determine database location
    //checking if database exists - checkAndCreateDatabase()
    //adding data to database - readDataFromDatabase()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true)
        
        let documentDir = documentPaths[0]
        
        //setting path
        databasePath = documentDir + "/" + databaseName
        
        checkAndCreateDatabase()
        
        readDataFromDatabase()
        
        
        return true;
    }
   
    //checking if document exists - if no create
    //    Checks if the database file exists.
    //    If not, it copies a database file from the app's resources.

    func checkAndCreateDatabase(){
        
        var success = false;
        let fm = FileManager.default
        
        success = fm.fileExists(atPath: databasePath)
        
        if success{
            return ;
        }
        
        //if not found - check and create
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName)
        
        try? fm.copyItem(atPath: databasePathFromApp!, toPath: databasePath)
        
        return ;
        
    }
    
    
    //    Inserts a new order into the database using an SQL INSERT statement.
    //    If successful, it prints the inserted row ID.
    
    func insertIntoDatabase(o:OrderData)->Bool{
        
        var db:OpaquePointer?=nil;
        var returnCode:Bool = true ;
        
        if sqlite3_open(databasePath, &db) == SQLITE_OK{
            
        print("Successfully opened database connection")
        
            //setting up query
            var insertStatement:OpaquePointer?=nil;
            
            var insertStatementString:String = "INSERT INTO orders values (null,?,?,?,?,?,?) ";
            
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
                
                let deliveryDateStr = o.deliveryDate! as NSString;
                let addressStr = o.address! as NSString;
                let sizeStr = o.size! as NSInteger;
                let meatToppingsStr = o.meatToppings! as NSString // Join array
                let vegToppingsStr = o.vegToppings! as NSString // Join array
                let avatar = o.avatar! as NSString;
                
                
                sqlite3_bind_text(insertStatement,1,deliveryDateStr.utf8String,-1,nil);
                sqlite3_bind_text(insertStatement,2,addressStr.utf8String,-1,nil);
                sqlite3_bind_int(insertStatement,3,Int32(sizeStr));
                sqlite3_bind_text(insertStatement,4,meatToppingsStr.utf8String,-1,nil);
                sqlite3_bind_text(insertStatement,5,vegToppingsStr.utf8String,-1,nil);
                sqlite3_bind_text(insertStatement,6,avatar.utf8String,-1,nil);
                
                
                    //now executing query
                    
                    if sqlite3_step(insertStatement) == SQLITE_DONE{
                        let rowId = sqlite3_last_insert_rowid(db);
                        print("Successfully inserted row \(rowId)")
                    }else{
                        print("Insert statement could not be executed")
                        
                        //cleaning up memory allocation
                        sqlite3_finalize(insertStatement)
                    }
            }else{
                    print("insert statement could not be processed")
                    returnCode = false;
                }
                
                //cleaning up space
                sqlite3_close(db);
            
                
        }
    
    else{
        print("could not open database")
        returnCode = false;
    }

    return returnCode;
            

        }
            
        
    func readDataFromDatabase(){
        
        order.removeAll()
        
        var db:OpaquePointer?=nil;
        
        if sqlite3_open(databasePath, &db) == SQLITE_OK{
            print("Successfully opened connection to database at \(databasePath)")
            
            
            var queryStatement:OpaquePointer?=nil;
            let queryStatementString:String = "SELECT * from orders";
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
                
                while sqlite3_step(queryStatement) == SQLITE_ROW{
                    
                    let id:Int = Int(sqlite3_column_int(queryStatement, 0))
                    
                    let cdeliveryDate = sqlite3_column_text(queryStatement, 1);
                    let caddress = sqlite3_column_text(queryStatement, 2);
                    let csize = sqlite3_column_int(queryStatement, 3);
                    let cmeatToppings=sqlite3_column_text(queryStatement, 4);
                    let cvegToppings=sqlite3_column_text(queryStatement, 5);
                    let cavatar=sqlite3_column_text(queryStatement, 6);
                    
                    let deliveryDate:String = String(cString: cdeliveryDate!)
                    let address:String = String(cString: caddress!)
                    let size = Int(csize)
                    let meatToppings = String(cString: cmeatToppings!)
                    let vegToppings = String(cString: cvegToppings!)
                    let avatar:String = String(cString: cavatar!)
                    
                    
                    let data:OrderData = .init()
                    data.initWithOrdersData(theRow: id, thedeliveryDate: deliveryDate, theaddress: address, thesize: size, themeatToppings: meatToppings, thevegToppings: vegToppings, theavatar: avatar)
                    
                    order.append(data)
                    
                    let finalString:String = "\(id) | \(deliveryDate) | \(address) | \(size) | \(meatToppings) | \(vegToppings) | \(avatar)";
                    
                    
                    print("Query Result")
                    print("\(id) | \(deliveryDate) | \(address) | \(size) | \(meatToppings) | \(vegToppings) | \(avatar)")
                    
                                                          }
                sqlite3_finalize(queryStatement)
            }else{
                print("select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
            
        }else{
            
            print("unable to open database")
            
        }
        
    }



    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

