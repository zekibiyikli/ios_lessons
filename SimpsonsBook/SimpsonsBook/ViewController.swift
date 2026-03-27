//
//  ViewController.swift
//  SimpsonsBook
//
//  Created by Mono on 27.03.2026.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var simpsonsArray=[Simpsons]()
    var chosenSimpson:Simpsons?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        let homer=Simpsons(name: "Homer",image: UIImage(named: "homer"),detail:"Husband of Marge; father of Bart, Lisa, and Maggie. He is lazy and often eats donuts, which it is his favorite food, he works in a nuclear power plant and he is the safety monitor. His mother Mona left him and his father Abe when he was younger, and he later gets to reunite with her until her death.")
        let marge=Simpsons(name: "Marge",image: UIImage(named: "merge"),detail:"Wife of Homer; mother of Bart, Lisa, and Maggie. She is kind-hearted and stays at home as a housewife. Her father Clancy died when her children Bart and Lisa are 7 and 5 years old and she is of French origin like him.")
        let bart=Simpsons(name: "Bart",image: UIImage(named: "bart"),detail:"Oldest child and only son of Homer and Marge; brother of Lisa and Maggie. He thinks of himself as a destructive \"bad boy\" who is rebellious and mischievous to a fault. Enjoys pulling pranks.")
        let lisa=Simpsons(name: "Lisa",image: UIImage(named: "lisa"),detail:"Middle child and eldest daughter of Homer and Marge; sister of Bart and Maggie. She is intelligent and plays with her saxophone, she is two years younger than her older brother Bart.")
        let maggie=Simpsons(name: "Maggie",image: UIImage(named: "maggie"),detail:"Youngest child and daughter of Homer and Marge; sister of Bart and Lisa. She does not talk.")
        
        simpsonsArray.append(homer)
        simpsonsArray.append(marge)
        simpsonsArray.append(bart)
        simpsonsArray.append(lisa)
        simpsonsArray.append(maggie)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpsonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content=cell.defaultContentConfiguration()
        content.secondaryText=simpsonsArray[indexPath.row].name
        cell.contentConfiguration=content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson=simpsonsArray[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.chosenSimpson = chosenSimpson
        }
    }

}

