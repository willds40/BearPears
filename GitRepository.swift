
import Foundation

class GitRepository{
    
    
func getCommits(){
let urlString = URL(string: "http://jsonplaceholder.typicode.com/users/1")

    if let url = urlString {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error)
        } else {
            if let usableData = data {
                print(usableData) //JSONSerialization
            }
        }
    }
    task.resume()
    }
}
}
