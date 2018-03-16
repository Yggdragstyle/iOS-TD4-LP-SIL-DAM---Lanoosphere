//
//  FormController.swift
//  TD4_iOS
//
//  Created by Yggdragstyle on 12/12/2017.
//  Copyright © 2017 Yggdragstyle. All rights reserved.
//

import UIKit
import MessageUI

class FormController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    // OUTLETS
    
    @IBOutlet weak var nomField: UITextField!
    
    @IBOutlet weak var prenomField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var telephoneField: UITextField!
    
    @IBOutlet weak var rappelField: UISwitch!
    
    @IBOutlet weak var envoyerBtn: UIButton!
    
    
    
    // PROPERTIES
    var elmt: Elmt!
    
    
    // DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Contact " + self.elmt.name
        self.navigationController!.navigationBar.barStyle = UIBarStyle.black
        
        self.view.backgroundColor = UIColor.gray
    }
    
    
    // ACTIONS
    
    @IBAction func Envoyer(_ sender: Any) {
        
        print("\n Je m'appel \(nomField.text!) \(prenomField.text!), mon email est \(emailField.text!) et mon téléphone : \(telephoneField.text!). Je souahite \( rappelField.isOn ? "qu'ont me rappel" : "qu'ont me rappel pas" )")
        
        
        
        
        if let nom: String = nomField.text, let prenom: String = prenomField.text, let mail: String = emailField.text, let tel: String = telephoneField.text, let rappel: String = (rappelField.isOn ? "OUI" : "NON"), ValidName(nom) && ValidName(prenom) && ValidMail(mail) && ValidPhone(tel) {
            
            let mailBody: String = "<html><head><style type=\"text/css\">b {text-decoration: underline;}</style></head><body><p><b>Nom :</b> \(nom)</p><p><b>Prénom :</b> \(prenom)</p><p><b>Email :</b> \(mail)</p><p><b>Téléphone :</b> \(tel)</p><p><b>Etre rappeler :</b> \(rappel)</p></body></html>"
        
            
            let mailView = configuredMailComposeViewController(body: mailBody)
            if MFMailComposeViewController.canSendMail() {
                self.present(mailView, animated: true, completion: nil)
            
            } else {
                
                self.ErrorAlert(erreur: (
                    title: "Could Not Send Email",
                    msg: "Your device could not send e-mail.  Please check e-mail configuration and try again."
                ))
            }
        } else {
            
            self.ErrorAlert(erreur: (
                title: "Invalid Field !",
                msg: "Please check your fields !"
            ))
        }
    }
    
    
    // METHODS
    
    func configuredMailComposeViewController(body mailBody: String) -> MFMailComposeViewController {
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            
            mailComposerVC.setToRecipients([elmt.mail])
            mailComposerVC.setSubject("Ma demande de contrat")
            mailComposerVC.setMessageBody(mailBody, isHTML: true)
            
            return mailComposerVC
    }
    
    
    func ErrorAlert(erreur: (title: String, msg: String)) {
        let errorAlert = UIAlertView(title: erreur.title, message: erreur.msg, delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
    }
    
    
    // DELEGATE
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    // VALIDE   (Regex)
    
    func ValidName(_ nom:String) -> Bool {
        
        let nameRegEx = "[A-Za-z]{5,64}" // moi j'aurai mis 3 plutôt que 5..
        
        let test = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return test.evaluate(with: nom)
    }
    
    func ValidMail(_ mail:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let test = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return test.evaluate(with: mail)
    }
    
    func ValidPhone(_ tel:String) -> Bool {
        
        let phoneRegEx = "0[0-9]{9}"
        
        let test = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return test.evaluate(with: tel)
    }
    
}
