//
//  ViewController.swift
//  emailWithPdf
//
//  Created by Acxiom Consulting on 30/07/21.
//
import UIKit
import MessageUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func sendEmail(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
     let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["gupta.mohit1907@gmail.com"])
        composer.setSubject("YouTube Test!!")
        composer.setMessageBody("Hello Guys Nice to See You!!", isHTML: true)
        if let filePath = Bundle.main.path(forResource: "sample", ofType: "pdf")
        {
            if let fileData = NSData(contentsOfFile: filePath){
                composer.addAttachmentData(fileData as Data, mimeType: "application/pdf", fileName: "sample.pdf")
                
            }
        }
        self.present(composer, animated: true, completion: nil)
    }
}
extension ViewController : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error{
            controller.dismiss(animated: true, completion: nil)
        }
        switch result {
        case .cancelled:
            debugPrint("cancelled")
        case .sent:
            debugPrint("sent")
        case .failed:
            debugPrint("failed")
        case .saved:
            debugPrint("saveed")
        default :
            debugPrint("default")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

