//
//  DetailViewController.swift
//  BlocNotes
//
//  Created by Michelle Rutherford on 8/29/15.
//  Copyright (c) 2015 Michelle Rutherford. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext? = nil
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!

 
    
    @IBOutlet weak var noteTitle: UITextField!
   
  
    @IBOutlet weak var noteBody: UITextView!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("timeStamp")!.description
            }
            if let label = self.noteBody {
                label.text = detail.valueForKey("noteBody")! as? String
            }
            if let label = self.noteTitle {
                label.text = detail.valueForKey("noteTitle")!  as? String
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        updateObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateObject() {
        if let context = self.managedObjectContext {
            _ = NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)
            detailItem!.setValue(self.noteBody.text , forKey: "noteBody")
            detailItem!.setValue(self.noteTitle.text, forKey: "noteTitle")
            // Save the context.
        
            do {
                  try context.save()
               
      
            } catch {
                abort()
            }
        }
    }
}



