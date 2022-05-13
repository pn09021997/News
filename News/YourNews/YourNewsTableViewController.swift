//
//  YourNewsTableViewController.swift
//  News
//
//  Created by Nguyen Phuong on 19/02/1401 AP.
//

import UIKit
import Firebase

class YourNewsTableViewController: UITableViewController {
    private var viewModels = [YourNewsTableViewCellModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        let userID = "-N1HpCU9jKvHNEzRPTrf"
        ref.child("YourNews/\(userID)/").observeSingleEvent(of: .value){
            (snapshot) in let listNews = snapshot.value as? NSDictionary
            if let listNews = listNews {
                for (_, value) in listNews {
                    if let favorNews = value as? NSDictionary {
                        if let title = favorNews.value(forKey: "title"),
                            let urlToImage = favorNews.value(forKey: "urlToImage"),
                            let description = favorNews.value(forKey: "description") {
                            self.viewModels.append(
                                YourNewsTableViewCellModel(
                                    title: title as! String,
                                    subTitle: (description as! String) ?? "No description",
                                    imageURL: URL(string: (urlToImage as! String) ?? "")
                                )
                            )
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YourNewsTableViewCell.identifier, for: indexPath) as? YourNewsTableViewCell else {
            fatalError()
        }
        let article = viewModels[indexPath.row]
        cell.NewsTitle.text = article.title
        if let data = article.imageData {
            cell.NewsImage.image = UIImage(data: data)
        } else if let url = article.imageURL {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                article.imageData = data
                DispatchQueue.main.async {
                    cell.NewsImage.image = UIImage(data: data)
                }
            }.resume()
        }

        // Configure the cell...

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
