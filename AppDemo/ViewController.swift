//
//  ViewController.swift
//  AppDemo
//
//  Created by Andrea Perera on 11/12/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//


// Swift

import FBSDKLoginKit

// Add this to the body
class ViewController: UIViewController,LoginButtonDelegate {
    var hotelArray: Array<Any> = []
    var allHotels:[Hotel] = []

    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        getHotelDetails();
        //checking wether the user is signin or not
        if let token = AccessToken.current,
            !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod:.get)
            request.start(completionHandler: { (connection,result, error) in
                print("\(result)")
                if ((error) != nil)
                {
                    print("Error took place: \(error)")
                }
                else
                {
                    print("Print entire fetched result: \(result)")
                    let data = result as! [String : Any]
                    let name = data["name"] as! String
                    self.userName.text = name
                    let email = data["email"] as! String
                     self.userEmail.text = email
                }
               
                    
            })
            
           
        }
        else{
//            loginButton.delegate=self
            loginButton.permissions = ["public_profile", "email"]
        }
       
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod:.get)
        request.start(completionHandler: { (connection,result, error) in
            print("\(result)")
        })
    }
     
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    
    }
    
    func getHotelDetails(){
        let session = URLSession.shared
        let url = URL(string: "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
        // Check the response
//            print(response)
            
            // Check if an error occured
            if error != nil {
                print(error)
                return
            }
            
            // Serialize the data into an object
            do {
                
                let json=try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
//                print(json)
                self.hotelArray = (json?["data"] as! NSArray) as! Array<Any>
                print("ASynchronous\(self.hotelArray)")
                print("..........................................")
//                print(self.hotelArray)
                //iterating in hotelarray
                for anItem in self.hotelArray as! [Dictionary<String, AnyObject>] {
                    //getting values
                    let address = anItem["address"] as! String
                    let title = anItem["title"] as! String
                    let images=anItem["image"]?["small"] as! String
                      let longitude=anItem["longitude"] as! String
                      let latitude=anItem["latitude"] as! String
                      let url = URL(string:  images)
                      let data = try? Data(contentsOf: url!) 
    //                self.testUi.image = UIImage(data: data!)
                      let ID = anItem["id"] as! Int
                      let x : Int = ID
                      var id = String(x)
                  let description = anItem["description"] as! String
                    let hotels = Hotel(hotelID: ID, image: UIImage(named:id)!, title: title, address: address, description: description,latitude: latitude,longitude: longitude)
                    self.allHotels.append(hotels)
                    
                }
                
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
            
        })
        task.resume()
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //segue for show detail view
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            destination.hotelsDetails=self.allHotels[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allHotels.count

    }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var hotel = self.allHotels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotelCell", for: indexPath) as! HotelViewCell
        cell.configure(hotel: hotel)
        return cell
    }

}

  
