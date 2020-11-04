import Foundation

public struct SPMModel {
    public static func getRandomNumber()->String{
        let rand = Int.random(in: 0..<100)
        return "Random number = \(rand)"
    }
    
    public static func getAllCountries(_ completion:@escaping ([String]?, Error?)->Void){
        let urlString = "https://restcountries.eu/rest/v2/all"
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error == nil, let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]]
                    let allCountries = json?.map({$0["name"]}) as? [String]
                    completion(allCountries, nil)
                }catch let e {
                    completion(nil,e)
                }
            }else{
                completion(nil,error)
            }
        }.resume()
    }
}
