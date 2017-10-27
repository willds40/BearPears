 /*
  //connect go button to start generating pairs
  5. display values on a screen.
  7. create animations
  */
 
 import UIKit
 import AudioToolbox
 
 class GeneratePairs: UIViewController,UICollisionBehaviorDelegate{
    @IBOutlet weak var polarBear: UIImageView!
    @IBOutlet weak var createPairsLabel: UIButton!
    @IBOutlet weak var GoButton: UIButton!
    @IBOutlet weak var PairTextView: UITextView!
    var peopleDictionary = [Int:String]()
    var listOfPairs = ""
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var polarBearView:UIImageView!
    var bowlingPinsView:UIImageView!
    var collision: UICollisionBehavior!

    
    
    @IBAction func goButton(_ sender: Any) {
        listOfPairs = ""
        GoButton.isHidden = true
        createPairsLabel.isHidden = true
          playSound()
        startAnimation()
    }
    
    func startAnimation(){
            animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [polarBearView])
        gravity.magnitude = 0.06
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [polarBearView])
        collision.collisionDelegate = self
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        collision.addBoundary(withIdentifier: "bowlingPins" as NSCopying, for: UIBezierPath(rect: bowlingPinsView.frame))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PairTextView.text = ""
        setupImages()
        }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        bowlingPinsView.isHidden = true
        polarBearView.isHidden = true
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?){
        behavior.removeItem(polarBearView)
        getRandomPairs()
    }
    
    func playSound(){
        let filename = "Bowling Strike Sound Effect"
        let ext = "mp3"
        if let soundUrl = Bundle.main.url(forResource: filename, withExtension: ext) {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesAddSystemSoundCompletion(soundId, nil, nil, { (soundId, clientData) -> Void in
                AudioServicesDisposeSystemSoundID(soundId)
            }, nil)
            AudioServicesPlaySystemSound(soundId)
    }
}
    
    func setupImages(){
        let imageName = "polarBearOnIce.gif"
        let polarBear = UIImage(named: imageName)
        polarBearView = UIImageView(image: polarBear!)
        polarBearView.frame = CGRect(x:self.view.frame.midX/2, y: 110, width: 200, height: 159)
        view.addSubview(polarBearView)
        let bowlingPinsImage = "bowlingPins.jpg"
        let bowlingPins = UIImage(named: bowlingPinsImage)
        bowlingPinsView = UIImageView(image: bowlingPins!)
        bowlingPinsView.frame = CGRect(x: 110, y: 500, width: 200, height: 159)
        view.addSubview(bowlingPinsView)
    }
    
    func getRandomPairs(){
        var names = Set<String>()
        while names.count < peopleDictionary.count {
            let index: Int = Int(arc4random_uniform(UInt32(peopleDictionary.count)))
            let randomVal = Array(peopleDictionary.values)[index]
            names.insert(randomVal)
        }
        getThePairs(names)
    }
    
    func getThePairs(_ names:Set<String>){
        var names = Array(names)
        while names.count >= 2{
            let pair = names[0..<2]
            if areBothAnchors(pair) == false{
            //if if not piared in the last month
            
            listOfPairs += pair[0] + " " + "&" + " " + pair[1] + "\n"
            names.remove(at: 0);names.remove(at: 0)
            
            }
            else {
                self.getRandomPairs()
            }
        }
        if !names.isEmpty{
            listOfPairs += names[0]
        }
        PairTextView.text = listOfPairs
        
}
    func areBothAnchors (_ pairs:ArraySlice<String>)->Bool{
        if pairs[0].contains("Anchor") && pairs[1].contains("Anchor"){
        return true
        }
        return false
    }
 }
