//
//  ShowCarViewController.swift
//  Automobili
//
//  Created by Stefan Djordjevic on 3/27/17.
//  Copyright © 2017 Stefan Djordjevic. All rights reserved.
//

import UIKit

class ShowCarViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var boja: UILabel!
    @IBOutlet weak var registrovano: UILabel!
    @IBOutlet weak var vrata: UILabel!
    @IBOutlet weak var kubikaza: UILabel!
    @IBOutlet weak var gorivo: UILabel!
    var sing = MySingleton.sharedInstance
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var slika: UIImageView!
    var slikee = [UIImage]()
    var urll = [String]()
    var brSlike : Int = 0
    var ucitano : Bool = false
    var index : Int = 0
    @IBOutlet weak var dugme: UIBarButtonItem!
    @IBOutlet weak var slika1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text=car.model;
        slika.image=sl
        slika1.image=sl
         UIView.animate(withDuration: 0.5, animations: {
            self.slika1.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0) } )
        
        scroll.contentSize.height=1000
        ucitaj ()
        
        prikaziText()
    }
    func  prikaziText() -> Void {
        
        text.text = "Proizvodjac: "+car.marka + "\n\n Model : "+car.model + "\n\nCena :"+car.Cena + "\n\n Godina proizvodnje :"+car.godiste + "\n\nPosledji put izmenjeno :"+car.postavljeno
    }
    @IBOutlet weak var text: UITextView!
    
    var car = Car()
    var sl = UIImage()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        //kad se skroluje sta da radi :)
    }

    
    
    func ucitaj () -> Void
    {
      ///ucitavamo sve za vozilo 
       let id = String(car.id)
        let url = URL(string: "http://quadrixsoft.com/auto/public/api/vehicles/"+id)
        let task = URLSession.shared.dataTask(with: url!) { (data ,response , error) in
            if error != nil{
                print ("ERROR")
            }
            else{
                if let content = data{
                    do {
                        
                        let myJson = try JSONSerialization.jsonObject(with: content) as! [String: AnyObject]
                     
                            let p = myJson["image_urls"] as! [String]
                            for i in p {
                                self.urll.append(i)}
                        let name = myJson["kit_names"] as! [String]
                        for i in name {
                            self.car.kit_names.append(i)}
                        let vehicle=myJson["vehicle_condition_names"] as! [String]
                        for ve in vehicle {
                            self.car.vehicle.append(ve)}
                        let sec = myJson["security_names"] as! [String]
                        for se in sec {
                            self.car.security.append(se)}
                        
                        self.car.godiste=myJson["year"] as? String ?? ""
                        self.car.cc=myJson["cc"] as? String ?? ""
                        self.car.gorivo = myJson["fuel"] as? String ?? ""
                        self.car.kw=myJson["power_kw"] as? String ?? ""
                        self.car.ks=myJson["power_ks"] as? String ?? ""
                        self.car.km = myJson["kilometers"] as? String ?? ""
                        self.car.emision = myJson["emission_class"] as? String ?? ""
                        self.car.drive = myJson["drive"] as? String ?? ""
                        self.car.menjac = myJson["gearshift"] as? String ?? ""
                        self.car.vrata = myJson["doors"] as? String ?? ""
                        self.car.sediste = myJson["seats"] as? String ?? ""
                        self.car.volan = myJson["steering_wheel_side"] as? String ?? ""
                        self.car.klima = myJson["air_conditioner"] as? String ?? ""
                        self.car.boja = myJson["color"] as? String ?? ""
                        self.car.nterior_material = myJson["interior_materials"] as? String ?? ""
                        self.car.interior_color = myJson["interior_color"] as? String ?? ""
                        self.car.registracija = myJson["registration"] as? String ?? ""
                        self.car.ostecenja = myJson["damage"] as? String ?? ""
                        self.car.zamena = myJson["change"] as? String ?? ""
                        self.car.origin = myJson["origian"] as? String ?? ""
                        self.car.count = myJson["count"] as? String ?? ""
                        self.car.status = myJson["status"] as? String ?? ""
                        self.car.special_status = myJson["special_status"] as? String ?? ""
                        self.car.opis = myJson["description"] as? String ?? ""
                        self.car.created = myJson["created_at"] as? String ?? ""
                        self.car.telefon = myJson["phone"] as? String ?? ""
                    
                        
                        
                     self.ucitajSlike()
                    }//
                        
                        
                    catch{
                        print ("error")
                    }
                }
            }
            
        }
        task.resume()
        
    }
    
    func ucitajSlike () -> Void {
        
        for i in urll {
            let str = NSURL(string : i )
            let dst = NSData(contentsOf: str as! URL)!
            
            slikee.append(UIImage(data: dst as Data)!)
            
                    }
        if urll.count > 0 {
        ucitano=true
        }
        
    }

    
   
    @IBAction func levo(_ sender: UISwipeGestureRecognizer) {
      
        ///slide levo  napravljeno kao kruzno
        
     /*   if ucitano{
        brSlike+=1
        if brSlike==0 {
            slika.image=sl
            slika1.image=sl
        }
        else if brSlike == urll.count+1
        {
            brSlike=0
            slika.image=sl
            slika1.image=sl
        }
        if brSlike>0 {
            
            slika.image=slikee[brSlike-1]
            slika1.image=slikee[brSlike-1]
          
            }


        }
        if urll.count == 0 {
            info.text="Nema dodatnih slika uz ovo vozilo"
        }*/
         index+=1
        if(index<sing.car.count){
        self.slika.image=sing.slikeKola[index]
        slika1.image=sing.slikeKola[index]
        car=sing.car[index]
            prikaziText()
        }
        else {
            index = 0
            self.slika.image=sing.slikeKola[index]
            slika1.image=sing.slikeKola[index]
            car=sing.car[index]
            prikaziText()
        }
        prikaziDetalje()
    }
    
    
 
    @IBAction func desno(_ sender: UISwipeGestureRecognizer) {
        ///slide desno  napravljeno kao kruzno
       /* if ucitano {
        brSlike-=1
        
        if brSlike==0 {
            slika.image=sl
            slika1.image=sl
        }
        if brSlike>0 {
       
        slika.image=slikee[brSlike-1]
        slika1.image=slikee[brSlike-1]
        }
            else if brSlike == -1
        {
            brSlike=urll.count
            slika.image=slikee[brSlike-1]
            slika1.image=slikee[brSlike-1]
        }
        }*/
        index-=1
        if(index>0){
            self.slika.image=sing.slikeKola[index]
            slika1.image=sing.slikeKola[index]
            car=sing.car[index]
            prikaziText()
        }
        else {
            index = sing.car.count-1
            self.slika.image=sing.slikeKola[index]
            slika1.image=sing.slikeKola[index]
            car=sing.car[index]
            prikaziText()
        }
      prikaziDetalje()
        
    }
   func prikaziDetalje() -> Void
   {
    ucitaj()
    gorivo.text!=car.gorivo
    kubikaza.text=car.km //treba kilometrazaa
    vrata.text!=car.vrata
    registrovano.text=car.registracija
    boja.text!=car.boja
    
    
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
    }

        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
