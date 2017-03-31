//
//  GumeViewController.swift
//  Automobili
//
//  Created by Stefan Djordjevic on 3/23/17.
//  Copyright © 2017 Stefan Djordjevic. All rights reserved.
//

import UIKit

class GumeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var res : Bool = true
    var page = 1
    var plac = [Gume]()
    var max=0
    var sing = MySingleton.sharedInstance
    var ucitava : Bool = true
    @IBOutlet weak var dugme: UIBarButtonItem!
    var slika = [UIImage]()
    @IBOutlet weak var kol: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dugme.target = revealViewController()
        dugme.action = #selector(SWRevealViewController.revealToggle(_:))
        self.kol.delegate=self
        self.kol.dataSource=self
        if(!sing.ucitnoGuma){
            ucitaj()
           while(res){}
            sing.ucitnoGuma=true
        }
        else {
            for p in sing.gume {
                showAnimate.append(false)
                plac.append(p)}
            for p in sing.slikeGuma{
                slika.append(p)
            }
        }
        

        //}
    }
    var showAnimate = [Bool]()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sing.gume.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = kol.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.slika.image=sing.slikeGuma[indexPath.row]
        cell.naziv.text = sing.gume[indexPath.row].type
        
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //cell.alpha = 0
        if showAnimate[indexPath.row] == false {
            let rotateTransform = CATransform3DTranslate(CATransform3DIdentity , -500, 10, 0)
            cell.layer.transform = rotateTransform
            UIView.animate(withDuration: 0.5,  animations: {() -> Void in
                
                //cell.alpha=1
                cell.layer.transform = CATransform3DIdentity
            })
               showAnimate[indexPath.row]=true
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /// f-ja ucitava sa servera slike ...
    func ucitaj () -> Void
    {
        let p = String(page)
         page+=1
        let url = URL(string: "http://auto.quadrixsoft.com/api/tires?limit=8&page="+p)
        let task = URLSession.shared.dataTask(with: url!) { (data ,response , error) in
            if error != nil{
                print ("ERROR")
            }
            else{
                if let content = data{
                    do {
                        
                        let myJson = try JSONSerialization.jsonObject(with: content) as! [String: AnyObject]
                        self.max=myJson["total"] as! Int
                        self.sing.maxGume=self.max
                        
                        print(myJson)
                        let p = myJson["tires"] as? [[String: AnyObject]]
                    
                        
                        for hh in p! {
                            let car = Gume()
                            let id = hh["id"]
                            car.id=String(describing: id)
                            car.type = hh["type"] as! String
                            car.manufacturer=hh["manufacturer"] as! String
                            car.width = hh["width"] as! String
                            car.heighr = hh["height"] as! String
                            car.treadDepth = hh["tread_depth"] as! String
                            car.weight = hh["weight"] as! String
                            car.density = hh["density"] as! String
                            car.pallet = hh["pallet"] as! String
                            car.code = hh["code"] as! String
                            car.price=hh["price"] as! String
                            car.count = hh["count"] as!String
                            car.condition=hh["condition"] as! String
                            car.createAt = hh["created_at"] as! String
                            car.uploadAt = hh["updated_at"] as! String
                            car.image = hh["image"] as! String
                           
                            self.showAnimate.append(false)
                            self.sing.gume.append(car)
                        }
                        
                        self.ucitajSlike ()
                        self.res=false
                        self.kol.reloadData()
                        
                    }
                        
                        
                    catch{
                        print ("error")
                    }
                }
            }
            
        }
        task.resume()
        
    }
    func ucitajSlike () -> Void {
        for i in 0..<sing.gume.count {
            let str = NSURL(string : sing.gume[i].image )
            let dst = NSData(contentsOf: str as! URL)!
            slika.append(UIImage(data: dst as Data)!)
            sing.slikeGuma.append(slika[i])
            
        }
         self.kol.reloadData()
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        

        if(sing.maxGume > plac.count) && ucitava{
        let scrollViewHeight = scrollView.frame.size.height;
        
        let scrollContentSizeHeight = scrollView.contentSize.height;
        let scrollOffset = scrollView.contentOffset.y;
        
        if scrollOffset >= (scrollContentSizeHeight - scrollViewHeight) {
            ucitava=false
            ucitaj()
        }
        }
     
    }
    

}
