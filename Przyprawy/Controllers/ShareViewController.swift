//
//  ShareViewController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 14/02/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import MessageUI
protocol ShareViewControllerDelegate {
    
}
class ShareViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    let emailAdressList = ["",""]
    let smsPhoneList = ["",""]
    
    var htmlText = ""
    var smsText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //sendSMS(with: smsText)
        //sendEmail(with: htmlText)
        
    }
    @IBAction func ShareSms(_ sender: Any) {
        //sendSMS(with: smsText)
    }
    @IBAction func ShareButton(_ sender: Any) {
       // sendEmail(with: htmlText)
    }
    
    @IBAction func eMailButtonTap(_ sender: UIButton) {
        sendEmail(with: htmlText)
    }
    
    @IBAction func smsButtonTap(_ sender: UIButton) {
        sendSMS(with: smsText)
    }
    
    @IBAction func phoneButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func contactButtonTap(_ sender: UIButton) {
    }
    //------------------- eMail ------
    func sendEmail(with html: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["kurczewski7@gmail.com","slawomir.kurczewski@gmail.com"])
            mail.setSubject("setSubject: Przyprawy")
            mail.setMessageBody(html, isHTML: true)
            present(mail, animated: true)
        } else {
           print("Error eMail send")
        }
    }
       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           switch result {
           case .sent:
                print("OK")
           case .cancelled:
                print("cancel")
           case .failed:
                print("error")
           case .saved:
                print("saved")
           default: break
           }
           controller.dismiss(animated: true)
       }
    //--------------- SMS -----
    func sendSMS(with text: String) {
        if MFMessageComposeViewController.canSendText() {
            let messageSms = MFMessageComposeViewController()
            let urlString = """
            https://www.google.com/search?q=przyprawy&sxsrf=ACYBGNQ0Bo-yuunOyc4te6g0wto8bR70Hw:1579012459840&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjp447mp4PnAhWOjYsKHXsGBBIQ_AUoAXoECBQQAw&biw=1881&bih=895#imgrc=Jiw8CH4_k032VM:
            """
            messageSms.messageComposeDelegate = self
            messageSms.body = text
            messageSms.recipients=["512589528","515914171"]
            messageSms.addAttachmentURL(URL(fileURLWithPath: urlString), withAlternateFilename: "http://www.gogle.com")
            present(messageSms, animated: true, completion: nil)
        }
    }
func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    
    switch result {
    case .sent:
        print("OK")
    case .cancelled:
        print("cancel")
    case .failed:
        print("error")
    default:
        break
    }
    controller.dismiss(animated: true)
}
//    func sendSMS(with text: String) {
//        if MFMessageComposeViewController.canSendText() {
//            let messageComposeViewController = MFMessageComposeViewController()
//            messageComposeViewController.body = text
//            //messageComposeViewController.addAttachmentURL("www.coogle.com", withAlternateFilename: "http://www.gogle.com")
//            present(messageComposeViewController, animated: true, completion: nil)
//        }
//    }
}
