//
//  UserListTableViewController.swift
//  swift_Salesforce
//
//  Created by nsuhara on 2018/11/28.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore

class UserListTableViewController: UITableViewController {

    var dataRows = [Dictionary<String, Any>]()

    override func loadView() {
        super.loadView()
        let request = RestClient.sharedInstance().buildQueryRequest(soql: "SELECT Id, Name, LastLoginDate FROM User LIMIT 10")
        RestClient.sharedInstance().send(request: request, onFailure: { (error, urlResponse) in
            SFSDKLogger.sharedInstance().log(type(of:self), level:.debug, message:"Error invoking: \(request)")
        }) { [weak self] (response, urlResponse) in
            if let jsonResponse = response as? Dictionary<String,Any> {
                if let result = jsonResponse ["records"] as? [Dictionary<String,Any>] {
                    DispatchQueue.main.async {
                        self?.dataRows = result
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataRows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifierUserListView", for: indexPath)
        let obj = dataRows[indexPath.row]
        cell.textLabel?.text =
            "[Name]\t\(obj["Name"] as? String ?? "None")"
            + "\n[Login]\t\t\(obj["LastLoginDate"] as? String ?? "None")"
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
