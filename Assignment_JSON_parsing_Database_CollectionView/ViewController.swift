//
//  ViewController.swift
//  Assignment_JSON_parsing_Database_CollectionView
//
//  Created by Mac on 15/01/24.
//

import UIKit
import CoreData
class ViewController: UIViewController {


    @IBOutlet weak var personCollectionView: UICollectionView!
    var person : [Person] = []
    var userArray : [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       fetchDataFromApi()
        initializeCollectionView()
        registerXIBWithCollectionView()
        fetchDataIntoDatabaseFromApi()
        
    }
    
    @IBAction func toggledButton(_ sender: UISwitch) {
        if sender.isOn == true{
            self.person = DatabaseManager.shared.retrivedDataFromCoreData()!
            DispatchQueue.main.async {
                self.personCollectionView.reloadData()
            }
        }else{
            
//            fetchDataFromApi()
            self.person = self.userArray
            DispatchQueue.main.async {
                self.personCollectionView.reloadData()
            }
        //  self.userArray = self.person
            
            
        }
    }
    func fetchDataIntoDatabaseFromApi()
    {
        for eachUser in self.userArray{
            DatabaseManager.shared.insertDataFromApiToCoreData(person: eachUser)
            
        }
        self.person = DatabaseManager.shared.retrivedDataFromCoreData()!
    }
    
    func fetchDataFromApi(){
        let personUrl = URL(string: "https://jsonplaceholder.typicode.com/users")
        var perRequest = URLRequest(url: personUrl!)
        perRequest.httpMethod = "GET"
        let urlSession = URLSession(configuration: .default)
        let perDataTask = urlSession.dataTask(with: perRequest) { personData, personResponse, personError in
            let perResponse = try! JSONSerialization.jsonObject(with: personData!) as! [[String : Any]]
            for eachResponse in perResponse{
                let perDictionary = eachResponse as! [String : Any]
                let perid = perDictionary["id"] as! Int
                let perName = perDictionary["name"] as! String
                let perUserName = perDictionary["username"] as! String
                let perEmail = perDictionary["email"] as! String
                let perAddressResponse = perDictionary["address"] as! [String : Any]
                let perPhone = perDictionary["phone"] as! String
                let perWebsite = perDictionary["website"] as! String
                let perCompany = perDictionary["company"] as! [String : Any]
                
                let perAddressStreet = perAddressResponse["street"] as! String
                let perAddressSuite = perAddressResponse["suite"] as! String
                let perAddressCity = perAddressResponse["city"] as! String
                let perAddressZipCode = perAddressResponse["zipcode"] as! String
                
                let perAddressGeo = perAddressResponse["geo"] as! [String : Any]
                let perAddressGeoLat = perAddressGeo["lat"] as! String
                let perAddressGeoLng = perAddressGeo["lng"] as! String
                
                
                let perCompanyName = perCompany["name"] as! String
                let perCompanyCatchPhrase = perCompany["catchPhrase"] as! String
                let perCompanyBs = perCompany["bs"] as! String
                
                let companyObject = Company(name: perCompanyName, catchPhrase: perCompanyCatchPhrase, bs: perCompanyBs)
                
                let geoObject = Geo(lat: perAddressGeoLat, lng: perAddressGeoLng)
                
                let addressObject = Address(street: perAddressStreet, suite: perAddressSuite, city: perAddressCity, zipcode: perAddressZipCode, geo: geoObject)
                
                let personObject = Person(id: perid, name: perName, username: perUserName, email: perEmail, address: addressObject, phone: perPhone, website: perWebsite, company: companyObject)
                
                self.person.append(personObject)
                
//                print(self.person)
                
        }
            DispatchQueue.main.async {
                self.personCollectionView.reloadData()
            }
                
    }
        perDataTask.resume()

}
    func initializeCollectionView(){
        personCollectionView.dataSource = self
        personCollectionView.delegate = self
    }
    func registerXIBWithCollectionView()
    {
        let uinib = UINib(nibName: "PersonCollectionViewCell", bundle: nil)
        personCollectionView.register(uinib, forCellWithReuseIdentifier: "PersonCollectionViewCell")
    }
//    func saveToCoreData()
//    {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let personEntityDescription = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedContext)
////        let userEntity = UserEntity(context: managedContext)
//
//
//        guard let nsmanagedObject = NSManagedObject(entity: personEntityDescription!, insertInto: managedContext) else {return}

//        for i in 0...3{
//            let personObject = NSManagedObject(entity: personEntityDescription!, insertInto: managedContext)

//            person.setValue("\(person)", forKey: "id")
//            person.setValue("name", forKey: "name")
            
//            personObject.setValue( , forKey: <#T##String#>)
//            personObject.setValue(, forKey: <#T##String#>)
//        }
        
    
    
    
    
    
    
}
extension ViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        person.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let personCollectionViewCell = self.personCollectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as! PersonCollectionViewCell
        
        personCollectionViewCell.idLabel.text = String(person[indexPath.item].id)
        personCollectionViewCell.nameLabel.text = person[indexPath.item].name
        personCollectionViewCell.userNameLabel.text = person[indexPath.item].username
        
        return personCollectionViewCell
    }
    
    
}
extension ViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let personDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "PersonDetailsViewController") as! PersonDetailsViewController
        
        personDetailsViewController.personContainer = person[indexPath.row]
        
        navigationController?.pushViewController(personDetailsViewController, animated: true)
        
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceBetweenTheCells : CGFloat = (flowlayout.minimumInteritemSpacing ?? 0.0) + (flowlayout.sectionInset.left ?? 0.0) + (flowlayout.sectionInset.right ?? 0.0)
        
        let size = (personCollectionView.frame.width - spaceBetweenTheCells) / 2
        
        return CGSize(width: 120, height: 80)
    }
}


