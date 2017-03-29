//
//  File.swift
//  Automobili
//
//  Created by Stefan Djordjevic on 3/23/17.
//  Copyright © 2017 Stefan Djordjevic. All rights reserved.
//

import Foundation


class Car {
    ///pamtimo sve detalje o vozilu
    var id :Int = 0 //id treba nam kad izaberemo vozilo da posaljemo serveru
    var godiste :String = ""
    var cc : String = ""   //??
    var gorivo : String = ""  //gorivo koje koristi auto
    var kw: String = "" // kilowati
    var ks: String = "" // konjska snaga
    var km:String = "" //kilometraza
    var emision :String = "" //tip motora EURO6
    var drive :String = ""    //4x4
    var menjac :String = ""  // automatski ili manuelni
    var vrata : String = "" //broj vrata 
    var sediste : String = "" //Broj sedista
    var volan : String = "" // strana volana 
    var klima : String = "" // automatska ili ne ?
    var boja : String = ""  // boja auta
    var nterior_material:String = "" //??
    var interior_color:String = "" //??
    var registracija :String = "" // do kada je vozilo registrovano
    var ostecenja:String = "" //da li ima ostecenja na vozilu
    var zamena :String = "" //da li je moguca zamena
    var origin:String = "" //??
    var Cena :String = ""  //cena vozila
    var count : String = "" // ??
    var status : String = "" // u kakvom je stanju vozilo
    var special_status : String = "" // ??
    var postavljeno :String = "" // kada je postavljeno vozilo na sajt
    var created : String = "" //?
    var opis :String = "" //opis vozila
    var marka :String = ""  // marka vozila
    var model :String = ""  // model vozila
    var kit_names = [String]()  //?
    var security = [String]() //?
    var vehicle = [String]() //?
    var telefon: String = "" // telefon vlasnika vozila
    var slika: String = "" //url slike koja se prikaze na pocetnom ekranu
    var josSlike = [String]() // url slika koje se prikazuju kada se udje u detalje 
    
}
