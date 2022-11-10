//
//  DetailViewController.swift
//  Private Students
//
//  Created by Wilson Luciano on 1/12/18.
//  Copyright © 2018 Wilson Luciano. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITextFieldDelegate,NSFetchedResultsControllerDelegate {

    
    @IBOutlet var avoidingView: UIView!

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var txtPhone1: UITextField!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var txtbook: UITextField!
    
    @IBOutlet weak var txtChapter: UITextField!
    
    @IBOutlet weak var txtParagraph: UITextField!
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!


    var isupdate:Bool = false
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            
            if let name = txtName {
                name.text = detail.name!.description
            }
            if let address = txtAddress {
                address.text = detail.address!.description
            }
            if let phone = txtPhone {
                phone.text = detail.phone!.description
            }
            if let phone1 = txtPhone1 {
                phone1.text = detail.phone1!.description
            }
            if let datepicker1  = datepicker {
                datepicker1.date = detail.crDate!
            }
            if let book = txtbook {
                book.text = detail.book!.description
            }
            if let chapter = txtChapter {
                chapter.text = detail.chapter!.description
            }
            if let paragraph = txtParagraph {
                paragraph.text = detail.paragraph!.description
            }
            if let comment = txtView {
                comment.text = detail.comment!.description
            }
            isupdate = true
            
          
        }else{
            datepicker.date = Date()
            isupdate = false
           
           
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        configureView()
        
        if isupdate {
        btnSave.setTitle("Update", for: .normal)
        btnCancel.setTitle("Delete", for: .normal)
        }else{
        btnSave.setTitle("Save", for: .normal)
        btnCancel.setTitle("Cancel", for: .normal)
        }

        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Student? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        return true
    }
    
    
    @IBAction func clickOnCancel(_ sender: UIButton) {
       
        if isupdate {
           deleteStudentDetails()
        }else{
        if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
            navController.popViewController(animated: true)
        }
        }
        
        
    }
    
    @IBAction func clickOnSave(_ sender: UIButton) {
        var message:String
        
        if(txtName.text!.count>0 ){
            if(txtView.text!.count>0 ){
                
                let name = txtName.text
                let address = txtAddress.text
                let phone =  txtPhone.text
                let phone1 = txtPhone1.text
                let crDate =  datepicker.date
                let book = txtbook.text
                let chapter = txtChapter.text
                let paragraph = txtParagraph.text
                let comment = txtView.text
                
                if isupdate {
                    self.updateStudentDetails(name: name, address: address, phone: phone, phone1: phone1, crDate: crDate, book: book,  chapter: chapter, paragraph: paragraph, comment: comment)
                }else{
                    self.insertStudentDetails(name: name, address: address, phone: phone, phone1: phone1, crDate: crDate, book: book,  chapter: chapter, paragraph: paragraph, comment: comment)
                }
                
                
                
                
            }
            else {
                message = "Please Fill Comment"
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        else {
           message = "Please Fill Name"
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
           
        }
       
    }
    
    

    func insertStudentDetails(name:String?, address:String?, phone:String?, phone1:String?, crDate:Date, book:String?, chapter:String?, paragraph:String?, comment:String?){
        
        // Reading AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Getting managed object context
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        // Creating Employee Managed Object instance
        let student = Student(context: managedObjectContext)
        student.name = name
        student.address = address
        student.phone = phone
        student.phone1 = phone1
        student.crDate = crDate
        student.book = book
        student.chapter = chapter
        student.paragraph = paragraph
        student.comment = comment
        //employee.dob = dob as NSDate?
        
        // Inserting Employee record as managed objext
        managedObjectContext.insert(student)
    
        // Saving the employee details using save context
        appDelegate.saveContext()
        
        if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
            navController.popViewController(animated: true)
        }
        
        
    }
    
    func updateStudentDetails(name:String?, address:String?, phone:String?, phone1:String?, crDate:Date, book:String?, chapter:String?, paragraph:String?, comment:String?){
        
        // Reading AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Getting managed object context
        //let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        // Creating Employee Managed Object instance
        //let student = Student(context: managedObjectContext)
        detailItem?.setValue(name, forKey: "name")
        detailItem?.setValue(address, forKey: "address")
        detailItem?.setValue(phone, forKey: "phone")
        detailItem?.setValue(phone1, forKey: "phone1")
        detailItem?.setValue(crDate, forKey: "crDate")
        detailItem?.setValue(book, forKey: "book")
        detailItem?.setValue(chapter, forKey: "chapter")
        detailItem?.setValue(paragraph, forKey: "paragraph")
        detailItem?.setValue(comment, forKey: "comment")
        
          appDelegate.saveContext()

        if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
            navController.popViewController(animated: true)
        }
        
        
    }
    
    func deleteStudentDetails(){
        
        // Reading AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Getting managed object context
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        
        managedObjectContext.delete(detailItem!)
        
        // Saving the employee details using save context
        appDelegate.saveContext()
        
        if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
            navController.popViewController(animated: true)
        }
        
        
    }
    
    
    func fetchRecordsFromDatabase(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Getting managed object context
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        do{
            let student = try managedObjectContext.fetch(Student.fetchRequest())
            
            let firstEmpRecord:Student = student.first as! Student
            
            
            print("===================================")
            print("Student name - \(firstEmpRecord.name!)")
            print("Student address - \(firstEmpRecord.address!)")
            print("Student phone - \(firstEmpRecord.phone!)")
            print("Student phone1 - \(firstEmpRecord.phone1!)")
            print("Student crDate - \(firstEmpRecord.crDate!)")
            print("Student book - \(firstEmpRecord.book!)")
            print("Student chapter - \(firstEmpRecord.chapter!)")
            print("Student paragraph - \(firstEmpRecord.paragraph!)")
            print("Student comment - \(firstEmpRecord.comment!)")
           
            
            //let targetDate = firstEmpRecord.dob! as Date
            //let dateAsStr = getDateOfBirthAsStringFromDate(dob:targetDate)
           // print("Emp dob - \(dateAsStr)")
            
            /*
             for employeeRecord in records{
             
             print("===================================")
             print("Emp name - \((employeeRecord as! DBEmployee).name!)")
             print("Emp age - \((employeeRecord as! DBEmployee).age)")
             
             let targetDate = (employeeRecord as! DBEmployee).dob! as Date
             let dateAsStr = getDateOfBirthAsStringFromDate(dob:targetDate)
             print("Emp dob - \(dateAsStr)")
             }
             */
            
        } catch (let error) {
            
            print("Error occured - \(error) ")
        }
        
        
    }
    
    
    
    
//    var _fetchedResultsController: NSFetchedResultsController<Student>? = nil
//
//    var fetchedResultsController: NSFetchedResultsController<Student> {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        // Getting managed object context
//        let managedObjectContext = appDelegate.persistentContainer.viewContext
//
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//
//        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
//
//        // Set the batch size to a suitable number.
//        fetchRequest.fetchBatchSize = 20
//
//        // Edit the sort key as appropriate.
//        let sortDescriptor = NSSortDescriptor(key: "crDate", ascending: false)
//
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        // Edit the section name key path and cache name if appropriate.
//        // nil for section name key path means "no sections".
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchedResultsController.delegate = self
//        _fetchedResultsController = aFetchedResultsController
//
//        do {
//            try _fetchedResultsController!.performFetch()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//
//        return _fetchedResultsController!
//    }


}

