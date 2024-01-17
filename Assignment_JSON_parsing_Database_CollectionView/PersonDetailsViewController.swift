//
//  PersonDetailsViewController.swift
//  Assignment_JSON_parsing_Database_CollectionView
//
//  Created by Mac on 15/01/24.
//

import UIKit

class PersonDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var catchphraseLabel: UILabel!
    @IBOutlet weak var bsLabel: UILabel!
    
    var personContainer : Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
    }
    func fetchData()
    {
        self.nameLabel.text = personContainer?.name.description.codingKey.stringValue
        self.userNameLabel.text = personContainer?.username.description.codingKey.stringValue
        self.cityLabel.text = personContainer?.address.city.description.codingKey.stringValue
        self.zipcodeLabel.text = personContainer?.address.zipcode.description.codingKey.stringValue
        self.latLabel.text = personContainer?.address.geo.lat.description.codingKey.stringValue
        self.lngLabel.text = personContainer?.address.geo.lng.description.codingKey.stringValue
        self.phoneLabel.text = personContainer?.phone.description.codingKey.stringValue
        self.websiteLabel.text = personContainer?.website.description.codingKey.stringValue
        self.catchphraseLabel.text = personContainer?.company.catchPhrase.description.codingKey.stringValue
        self.bsLabel.text = personContainer?.company.bs.codingKey.stringValue
    }
    

    

}
