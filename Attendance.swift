import UIKit

class Attendance :UIViewController {
    var peopleDictionary = Dictionary<Int,String>()
    var peopleAnchoringStories = Dictionary<Int,String>()
    var gitRepository = GitRepository()
   

    @IBAction func checkBox(_ sender: UIButton) {sender.isSelected = !sender.isSelected
        if sender.isSelected{
       addAnchors(sender.tag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDictionaryWithPeople()
       gitRepository.getCommits()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "randomPairGenerator"{
            let generatePairs = segue.destination as? GeneratePairs
            generatePairs?.peopleDictionary = peopleDictionary
        }
    }
    
    func setupDictionaryWithPeople (){
        peopleDictionary = [1:"Michael", 2:"Will",3:"Karlyn", 4:"Elizabeth", 5:"Henry",
                            6:"Gustavo", 7:"Luz", 8:"Carol", 9:"Carlos", 10:"Akhil", 11:"Kelvin"]
    }
    
    func removePeopleFromDictionary(_ willRemoveKey:Int){
        for (key, _) in peopleDictionary{
            if key == willRemoveKey{
                peopleDictionary.removeValue(forKey: willRemoveKey)
            }
        }
    }

    func addAnchors(_ anchorKey:Int){
        for (key, name) in peopleDictionary{
            if key == anchorKey{
                peopleDictionary[key] = name + " (Anchor)"
            }
        }
    }
    
    @IBAction func takeAttendance(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            removePeopleFromDictionary(sender.tag)
        }
    }
    
    
    @IBAction func DoneAttendanceButton(_ sender: Any) {
        performSegue(withIdentifier: "randomPairGenerator", sender: self)
    }
}
