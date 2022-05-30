//
//  YourNewsTableViewController.swift
//  News
//
//  Created by Nguyen Phuong on 19/02/1401 AP.
//

import UIKit
import SafariServices

class YourNewsTableViewController: UITableViewController {
    private var viewModels = [YourNewsTableViewCellModel]()
    private var articles:NSDictionary?
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorListNews()
    
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getFavorListNews () {
        DBManager.DB.getListFavorNew{ [weak self] result in
            switch result {
            case .success(let listNews):
                self?.articles = listNews
                for (_, value) in listNews {
                    if let favorNews = value as? NSDictionary {
                        if let title = favorNews.value(forKey: "title"),
                           let urlToImage = favorNews.value(forKey: "urlToImage"),
                           let description = favorNews.value(forKey: "description"),
                           let url = favorNews.value(forKey: "url") {
                            self?.viewModels.append(
                                YourNewsTableViewCellModel(
                                    title: title as! String,
                                    subTitle: (description as! String) ?? "No description",
                                    url: url as! String,
                                    imageURL: URL(string: (urlToImage as! String) ?? "")
                                )
                            )
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
        cell.NewsTitle.text = article.title.prefix(120) + " ..."
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
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let articleURL = viewModels[indexPath.row].url
        guard let url = URL(string: articleURL ?? "") else {
            return
        }
        
        let vcSafari = SFSafariViewController(url: url)
        present(vcSafari, animated: true)
        
        
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // create the alert
            let alert = UIAlertController(title: "UIAlertController", message: "Are you want to delete it?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                switch action.style{
                    case .default:
                    let url = self.viewModels[indexPath.row].url
                    self.viewModels.remove(at: indexPath.row)
                    DBManager.DB.deleteFavorNews_Id(url: url)
                    // Delete the row from the data source
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.reloadData()
                    
                    case .cancel:
                    break
                    
                    
                    case .destructive:
                    break
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancle", style: .default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
