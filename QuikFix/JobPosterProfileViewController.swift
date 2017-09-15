//
//  JobPosterProfileViewController.swift
//  QuikFix
//
//  Created by Thomas Threlkeld on 9/12/17.
//  Copyright © 2017 Thomas Threlkeld. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import GuillotineMenu




class JobPosterProfileViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
   /* @IBAction func guillotinePressed(_ sender: Any) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self 
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender as? UIView
        present(menuViewController, animated: true, completion: nil)
    }*/
    @IBOutlet weak var navigationBar: UINavigationBar!
    //@IBOutlet weak var guillotineMenuButton: UIButton!
    
    @IBAction func okayPressed(_ sender: Any) {
        Database.database().reference().child("jobPosters").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshots{
                    if snap.key == "currentListings"{
                        self.currentListingsCount.text = String(describing: (snap.value as! [String]).count)
                        self.jobPostedView.isHidden = true
                        self.postJobsButton.isHidden = false
                        break
                    }
                }
            }
        })

        

    }
    
    @IBOutlet weak var jobPostedView: UIView!
    @IBAction func responseBubblePressed(_ sender: Any) {
    }
    @IBOutlet weak var responseBubble: UIButton!
    @IBOutlet weak var postJobsButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func postJobPressed(_ sender: Any) {
    }
    @IBOutlet weak var jobsCompletedCount: UILabel!
    @IBOutlet weak var currentListingsCount: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var showJobPostedView: Bool?
    func menuSelected(_ sender: Any){
        
        
        
    }
    @IBAction func menuBoundsPressed(_ sender: Any) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self as UIViewControllerTransitioningDelegate
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = self.navigationController?.navigationBar
        present(menuViewController, animated: true, completion: nil)
        
    }
    @IBOutlet weak var menuBounds: UIBarButtonItem!
    //var actualMenuBounds
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = self.navigationController!.navigationBar
       // menuBounds.setBackgroundImage(UIImage(named: "Image"), for: .normal, barMetrics: UIBarMetrics.default)
        
       
        navigationItem.leftBarButtonItem = menuBounds
        
       
        
        
       // navBar.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        //navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        profileImageView.layer.shadowColor = UIColor.black.cgColor
        profileImageView.layer.shadowRadius = profileImageView.frame.width + 20
        
        
        if showJobPostedView == true{
            jobPostedView.isHidden = false
            postJobsButton.isHidden = true
            
        }
        
        jobPostedView.layer.cornerRadius = 10
        responseBubble.layer.cornerRadius = responseBubble.frame.width/2
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.clipsToBounds = true
        Database.database().reference().child("jobPosters").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshots{
                    if snap.key == "name"{
                        //(self.navigationBar as UINavigationBar). //
                        self.nameLabel.text = snap.value as! String
                        
                    }
                        
                    else if snap.key == "pic"{
                        if let messageImageUrl = URL(string: snap.value as! String) {
                            
                            if let imageData: NSData = NSData(contentsOf: messageImageUrl) {
                                self.profileImageView.image = UIImage(data: imageData as Data) } }
                        //  loadImageUsingCacheWithUrlString(snap.value as! String)
                    }
                    else if snap.key == "currentListings"{
                        self.currentListingsCount.text = String(describing: (snap.value as! [String]).count)
                    }
                    else if snap.key == "responses"{
                    
                        self.responseBubble.titleLabel?.text = String(describing:(snap.value as! [String]).count)
                        
                    }
                }
            }
        })


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        print("pressss")
        presentationAnimator.animationDuration = 0.1
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    
    @available(iOS 2.0, *)
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        print("dissss")
        presentationAnimator.animationDuration = 0.1
        presentationAnimator.mode = .dismissal
        return presentationAnimator
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
/*extension JobPosterProfileViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("pressss")
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("dissss")
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}*/