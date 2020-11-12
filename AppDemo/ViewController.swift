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

    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //checking wether the user is signin or not
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        getHotelDetails();
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
            loginButton.delegate=self
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
                // HERE you can manage the error
                print(error)
                return
            }
            
            // Serialize the data into an object
            do {
//                let json = try JSONDecoder().decode([Hotel].self, from: data! )
                let json=try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
//                print(json)
                self.hotelArray = (json?["data"] as! NSArray) as! Array<Any>
                print("ASynchronous\(self.hotelArray)")
                
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
            
        })
        task.resume()
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hotel = hotelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotelCell", for: indexPath) as! HotelViewCell
        cell.configure(hotel: hotel as! Hotel)
        return cell
    }

}

  
