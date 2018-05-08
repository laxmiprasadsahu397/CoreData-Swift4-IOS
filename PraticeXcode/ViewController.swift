//
//  ViewController.swift
//  PraticeXcode
//
//  Created by LaxmiPrasad Sahu on 07/05/18.
//  Copyright © 2018 C1X. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        guard let url =  URL.init(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, err) in
            guard let data = data else { return }
            
            do {
            let json = try JSONDecoder().decode(TestModel.self, from: data)
                print(json)
//                Save To CoreData
            guard CoreDataHandler.saveValueToEntity(testModel: json) else {
                    return
                }
//                FetchWithOutFilter
                guard let value = CoreDataHandler.fetchdataFromTest() else { return}
                for item in value {
                    print(item.name)
                }
                
//                FetchWithFilter
                guard let values = CoreDataHandler.fetchdataWithFilter() else { return}
                for item in values {
                    print(item)
                }
//                Delete
                guard CoreDataHandler.deleteDataFromCoreData(param:"1")! else { return}
            } catch let jerr {
               print(jerr)
            }
            }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

