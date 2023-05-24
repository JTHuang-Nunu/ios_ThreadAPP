//
//  ViewController.swift
//  ThreadAPP
//
//  Created by Mac15 on 2023/5/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultsTextView: UITextView!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBAction func doButton(_ sender: UIButton) {
        let startTime = NSDate()
        self.resultsTextView.text = ""
        spinnerView.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(fetchedData)
            let firstResult = self.calculateFirstResult(processedData)
            let secondResult = self.calculateSecondResult(processedData)
            let resultsSummary = "First: [\(firstResult)]\nSecond:[\(secondResult)]"
            DispatchQueue.main.async {
                self.resultsTextView.text = resultsSummary
                self.spinnerView.stopAnimating()
            }
            let endTime = NSDate()
            print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
        }
        let startTime = NSDate()
        self.resultsTextView.text = ""
        spinnerView.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        let fetchedData = self.fetchSomethingFromServer()
        let processedData = self.processData(fetchedData)
        let firstResult = self.calculateFirstResult(processedData)
        let secondResult = self.calculateSecondResult(processedData)
        let resultsSummary = "First: [\(firstResult)]\nSecond:[\(secondResult)]"
        DispatchQueue.main.async {
            self.resultsTextView.text = resultsSummary
            self.spinnerView.stopAnimating()
        }
        let endTime = NSDate()
        print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
    }
    @IBAction func doGroupButton(_ sender: UIButton) {
        let startTime = NSDate()
        self.resultsTextView.text = ""
        spinnerView.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(fetchedData)
            var firstResult: String!
            var secondResult: String!
            let group = DispatchGroup()
            queue.async(group: group) {
                firstResult = self.calculateFirstResult(processedData)
            }
            queue.async(group: group) {
                secondResult = self.calculateSecondResult(processedData)
            }
            group.notify(queue: queue) {
                let resultsSummary = "First: [\(firstResult)]\nSecond:[\(secondResult)]"
                DispatchQueue.main.async {
                    self.resultsTextView.text = resultsSummary
                    self.spinnerView.stopAnimating()
                    let endTime = Date()
                    print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
                }
                
            }
        }
    }
    

    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "Hi there"
    }
    func processData(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spinnerView.hidesWhenStopped = true
    }


}

