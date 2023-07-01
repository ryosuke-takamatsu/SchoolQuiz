//
//  SchoolQuizViewController.swift
//  SchoolQuiz
//
//  Created by 高松諒丞 on 2023/06/09.
//

import UIKit

class SchoolQuizViewController: UIViewController {
    @IBOutlet weak var SchoolQuizLabel: UILabel!
    @IBOutlet weak var SchoolQuizTextView: UITextView!
    @IBOutlet weak var SchoolQuizButton1: UIButton!
    @IBOutlet weak var SchoolQuizButton2: UIButton!
    @IBOutlet weak var SchoolQuizButton3: UIButton!
    @IBOutlet weak var SchoolQuizButton4: UIButton!
    
    var csvArray:[String] = []
    var SchoolQuizArray:[String] = []
    var SchoolQuizCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvArray = loadCSV(filename: "SchoolQuiz")
        print(csvArray)
        
        SchoolQuizArray = csvArray[SchoolQuizCount].components(separatedBy: ",")
        
        SchoolQuizLabel.text = "第\(SchoolQuizCount + 1)問"
        SchoolQuizTextView.text = SchoolQuizArray[0]
        SchoolQuizButton1.setTitle(SchoolQuizArray[2], for: .normal)
        SchoolQuizButton2.setTitle(SchoolQuizArray[3], for: .normal)
        SchoolQuizButton3.setTitle(SchoolQuizArray[4], for: .normal)
        SchoolQuizButton4.setTitle(SchoolQuizArray[5], for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAction(sender: UIButton){
        if sender.tag == Int(SchoolQuizArray[1]){
            print("正解")
        }else{
            print("不正解!!!!")
        }
        nextQuiz()
    }
    
    func nextQuiz(){
        SchoolQuizCount += 1
        if SchoolQuizCount < csvArray.count{
            SchoolQuizArray = csvArray[SchoolQuizCount].components(separatedBy: ",")
            SchoolQuizLabel.text = "第\(SchoolQuizCount + 1)問"
            SchoolQuizTextView.text = SchoolQuizArray[0]
            SchoolQuizButton1.setTitle(SchoolQuizArray[2], for: .normal)
            SchoolQuizButton2.setTitle(SchoolQuizArray[3], for: .normal)
            SchoolQuizButton3.setTitle(SchoolQuizArray[4], for: .normal)
            SchoolQuizButton4.setTitle(SchoolQuizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    func loadCSV(filename:String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: filename, ofType: "csv")!
        do {
            let csvData=try String (contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let linechange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = linechange.components(separatedBy: "\n")
            csvArray.removeLast()
        }catch{
            print("エラー")
        }
        return csvArray
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
