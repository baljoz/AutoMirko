//
//  SliderViewController.swift
//  Automobili
//
//  Created by Stefan Djordjevic on 3/23/17.
//  Copyright © 2017 Stefan Djordjevic. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var dugme: UIBarButtonItem!
    var page = 1
    var max : Int = 0
    var ucitava : Bool = true
    var res : Bool = true
    var slika = [UIImage]()
    var naziv = [String]()
    var plac = [Car]()
    var sing = MySingleton.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        dugme.target = revealViewController()
        dugme.action = #selector(SWRevealViewController.revealToggle(_:))
        
             // Do any additional setup after loading the view.
        if(!sing.ucitanoCar){
        ucitaj()
       while(res){}
            sing.ucitanoCar=true
            }
        else {
            for p in sing.car {
                plac.append(p)}
            for p in sing.slikeKola{
                slika.append(p)
            }
        }
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plac.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell
        
        cell.ime.text!=sing.car[indexPath.row].marka
        
        cell.ime.text?.append(sing.car[indexPath.row].model)
      cell.slika.image=sing.slikeKola[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "showCar") as! ShowCarViewController
        newViewcontroller.car = plac[indexPath.row]
        newViewcontroller.sl=slika[indexPath.row]
        newViewcontroller.index=indexPath.row
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
            
        self.present(newFrontController, animated: false, completion: nil)
        
    }
    
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var desc
        
    }*/
    
    func ucitaj () -> Void
    {
        let p = String(page)
        let url = URL(string: "http://quadrixsoft.com/auto/public/api/vehicles?limit=4&page="+p)
        page+=1
        let task = URLSession.shared.dataTask(with: url!) { (data ,response , error) in
            if error != nil{
                print ("ERROR")
            }
            else{
                if let content = data{
                    do {
                        
                        let myJson = try JSONSerialization.jsonObject(with: content) as! [String: AnyObject]
                        self.sing.maxCar=myJson["total"] as! Int

                      
                        print(myJson)
                        let p = myJson["vehicles"] as? [[String: AnyObject]]
                       // print(p)
                        
                        for hh in p! {
                            let car = Car()
                            
                               let g=hh["price"] as? String ?? ""
                        
                            car.Cena=String(describing: g)
                          car.marka=hh["mark_name"] as! String
                            car.model = hh["model_name"] as! String
                            car.postavljeno = hh["updated_at"] as!String
                            car.slika = hh["image"] as! String
                           
                            
                            
                            car.id=hh["id"] as! Int
                            self.sing.car.append(car)
                            self.plac.append(car)
                        }
                        
                         self.ucitajSlike ()
                        self.res=false
                        self.table.reloadData()
                    }
                        
                        
                    catch{
                        print ("error")
                    }
                }
            }
            
        }
        task.resume()
      
    }

    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /// ova f-ja mora da se napravi lepo radi ali je pitanje da li radi asinhrono ili kako vec :(
    func ucitajSlike () -> Void {
        for i in 0..<plac.count {
        let str = NSURL(string : plac[i].slika )
        let dst = NSData(contentsOf: str as! URL)!
        
        slika.append(UIImage(data: dst as Data)!)
            sing.slikeKola.append(slika[i])
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
     
        if sing.maxCar > plac.count && ucitava{
        let scrollViewHeight = scrollView.frame.size.height;
     
        let scrollContentSizeHeight = scrollView.contentSize.height;
        let scrollOffset = scrollView.contentOffset.y;
        
        if scrollOffset >= (scrollContentSizeHeight - scrollViewHeight) {
            ucitava=false
            
         ucitaj()
            table.reloadData()
        }
        }
    }



}
