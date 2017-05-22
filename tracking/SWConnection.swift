
//  SWConnection.swift
//  studio
//
//  Created by Adson Nascimento on 15/03/17.
//  Copyright © 2017 Anaiv Tecnologia. All rights reserved.
//

import Foundation

@objc protocol SWConnectionDelegate {
	
	@objc optional func swconnection(connection:SWConnection, dataSentAndLoadedSucessfully result:SWResult)
	@objc optional func swconnection(connection:SWConnection, dataSendAndLoadFail error:Error)
	
}

public let SWConnectionResultStandard:Int = 1
public let SWConnectionResultGeneric:Int = 2

class SWConnection: NSObject, SWConnectionDelegate, URLSessionDelegate, URLSessionDataDelegate ,URLSessionTaskDelegate  {
	
	private var resultObject:SWResult?
	private var systemError:Error?
	private var receivedData:Data?
	var resultType:Int?


	var delegate:SWConnectionDelegate?
	var url:String?
	var identifier:String?
	static var aIdentifiers = [String]()
	var sendMethod:String?
	var variables:NSDictionary?
	var authorizationHeader:String!
	var headerContentType:String?
	var withCompletion:Bool? = false
	
	enum LogLevel:Int{
		case None = 0
		case Verbose = 1
	}
	var logger:LogLevel!
	
	var task:URLSessionDataTask?
	
	/// Keys to Insert in Connection Variables
	let TIMESTAMP   = "request_timestamp";
	let APP_VERSION = "application_version";
	
	/// Key change Connection Content/type
	static let CONTENT_URL_ENCONDED = "application/x-www-form-urlencoded"
	static let CONTENT_JSON = "application/json"
	
	override init () {
		super.init()
	}
	
	init(url: String, identifier: String) {
		
		self.resultType = SWConnectionResultStandard
		self.identifier = identifier
		self.sendMethod = "GET"
		self.url = url
	}
	
	init(url: String, identifier: String, resultType: Int) {
		
		self.resultType = resultType
		self.identifier = identifier
		self.sendMethod = "GET"
		self.url = url
	}
	
	//MARK: - GET
	private func sendAndLoadGET(){
		
		var vars:String = ""
		
		if self.variables != nil {
			var count = 0
			
			for (key,value) in self.variables! {
				
				if count == 0 { vars = vars + "?" }
				else { vars = vars + "&" }
				
				let str:String = String(format: "%@=%@", key as! String, value as! String)
				vars = vars + str
				count += 1
			}
		}
		
		
		if let url = NSURL(string: (self.url! + vars).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!){
			let req = NSURLRequest(url: url as URL)
			
			let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
			
			task = session.dataTask(with: req as URLRequest) { (dados:Data?, resposta: URLResponse?,  error:Error?) -> Void in
				
				if ( error == nil && dados != nil && dados!.count > 0) {
					
					do {
						
						let json = try JSONSerialization.jsonObject(with: dados!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
						
						print(json)
						
						if( self.resultType == SWConnectionResultStandard )
						{
							self.resultObject = SWResult(data: json)
						}
						else
						{
							let res = SWResult()
							res.isTrue = true
							res.value = "true"
							res.message = "Good! =D"
							res.dataObject = json
							
							self.resultObject = res
						}
						
						if self.delegate != nil {
							self.delegate?.swconnection!(connection:  self, dataSentAndLoadedSucessfully: self.resultObject!)
						}
						
						
					}catch let error as NSError{
						
						self.systemError = error
						
						if self.delegate != nil {
							
							self.delegate?.swconnection!(connection: self, dataSendAndLoadFail: self.systemError!)
						}
						
					}
					
				}
				else
				{
					self.systemError = error
					if self.delegate != nil {
						self.delegate?.swconnection!(connection: self, dataSendAndLoadFail: self.systemError!)
					}
				}
				
			}
			
			task!.resume()
			
			
		}
		
	}
	
	func sendAndLoadGETWithCompletion(completion:@escaping (_ success:Bool,_ result:AnyObject)->()) {
		
		var vars:String = ""
		
		if self.variables != nil {
			var count = 0
			
			for (key,value) in self.variables! {
				
				if count == 0 { vars = vars + "?" }
				else { vars = vars + "&" }
				
				let str:String = "\(key)=\(value)"

				vars = vars + str
				count += 1
			}
		}
		
		
		if let url = NSURL(string: (self.url! + vars)){
			let req = NSMutableURLRequest()
			req.httpMethod = "GET"
			req.url  = url as URL

			let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.current)
			
			task = session.dataTask(with: req as URLRequest) { (dados:Data?, resposta: URLResponse?,  error:Error?) -> Void in
				
				if ( error == nil && dados != nil && dados!.count > 0) {
					
					do {
						
						let json = try JSONSerialization.jsonObject(with: dados!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary]
						
						
						if( self.resultType == SWConnectionResultStandard )
						{
                            //self.resultObject = SWResult(data: json!)
						}
						else
						{
							let res = SWResult()
							res.isTrue = true
							res.value = "true"
							res.message = "Success"
							res.title = "Generic Title"
							res.resultMessage = "Generic Message"
							res.resultCode = -1
							res.dataObject = json as AnyObject
							
							self.resultObject = res
						}
						
						if self.delegate != nil {
							self.delegate?.swconnection!(connection: self, dataSentAndLoadedSucessfully: self.resultObject!)
						}
						completion(true, self.resultObject!)
						
						
					}catch let error as NSError{
						
						completion(false, error)
						
						print("SWConnection GET: json error: \(error.localizedDescription)")
					}
					
				}
				else{
					print("SWConnection GET: Did not Received Data")
					completion(false, error as AnyObject)
				}
				
			}
			
			task!.resume()
		}
	}
	
}
