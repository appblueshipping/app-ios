
//  BaseService.swift
//  tracking
//
//  Created by Jonatha Lima on 22/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit
import Foundation

enum BaseServiceError: Error {
	case Empty
	case NetworkError
}
class BaseService: NSObject, SWConnectionDelegate {
    
    //Base URL
	static let BASE_URL   =  "http://www.blueshipping.com.br/index.php/wp-json/wp/v2/"

    //Alert Titles and Messages
    static let networErrorTitle     = "Sem acesso à internet"
    static let networErrorMessage   = "Conecte-se à internet e tente novamente."
    static let serverErrorTitle     = "Sem acesso ao servidor"
    static let serverErrorMessage   = "Erro ao acessar o servidor. Tente novamente mais tarde."
    
    var window: UIWindow?    
    var ACTION_FUNCTION_NAME_TAG = ""
    
    static let RESULT_CODE_POSTIVE                 = 1
    static let RESULT_CODE_NO_DATA                 = 2
    static let RESULT_CODE_INCOMPLETE_REQUEST_DATA = 3
    static let RESULT_CODE_SQL_ERROR               = 4
    static let RESULT_CODE_SERVER_ERROR            = 5	
    static let RESULT_CODE_INVALID_TOKEN           = 6
    static let RESULT_CODE_AUTHENTICATION_FAIL     = 7
    static let RESULT_CODE_APP_VERSION_OLD         = 8
    static let RESULT_CODE_INVALID_REQUEST_DATA    = 9
    static let RESULT_CODE_RECORD_ALREADY_EXISTS   = 10
    
    override init () {
        super.init()
    }
	
	//MARK: - POST SWConnection.CONTENT_JSON
    func createPOSTSWConnection(url: String, variables: NSDictionary) -> SWConnection {
        
        let connection        = SWConnection(url: url, identifier: "")
        connection.delegate   = self
        connection.variables  = variables
        connection.sendMethod = "POST"
        connection.headerContentType = SWConnection.CONTENT_JSON
		connection.resultType = SWConnectionResultStandard
        connection.logger     = SWConnection.LogLevel.Verbose
        
        return connection
    }
	
	func createPOSTDefaultSWConnection(url: String, connectionId: String, variables: NSDictionary) -> SWConnection {
		
		let connection        = SWConnection(url: url, identifier: connectionId)
		connection.delegate   = self
		connection.variables  = variables
		connection.headerContentType  = SWConnection.CONTENT_JSON
		connection.sendMethod = "POST"
		connection.resultType = SWConnectionResultStandard
		connection.logger     = SWConnection.LogLevel.Verbose
		
		return connection
	}
	
	//MARK: - POST headerContentType
    func createPOSTSWConnection(url: String, variables: NSDictionary, headerContentType:String) -> SWConnection {
        
        let connection        = SWConnection(url: url, identifier: "")
        connection.delegate   = self
        connection.variables  = variables
        connection.sendMethod = "POST"
        connection.headerContentType = headerContentType
        connection.logger     = SWConnection.LogLevel.Verbose
        
        return connection
    }
	
	//MARK: - GET
    func createGETDefaultSWConnection(url: String, variables: NSDictionary) -> SWConnection {
        
        let connection        = SWConnection(url: url, identifier: "")
        connection.delegate   = self
        connection.variables  = variables
        connection.sendMethod = "GET"
		connection.resultType = SWConnectionResultGeneric
        connection.logger     = SWConnection.LogLevel.Verbose
        
        return connection
    }
	
	
	//MARK: - PUT
	func createPUTDefaultSWConnection(url: String, variables: NSDictionary) -> SWConnection {
		
		let connection        = SWConnection(url: url, identifier: "")
		connection.delegate   = self
		connection.variables  = variables
		connection.sendMethod = "PUT"
		connection.resultType = SWConnectionResultStandard
		connection.logger     = SWConnection.LogLevel.Verbose
		
		return connection
	}
	
	
    func swconnection(connection: SWConnection, dataSendAndLoadFail error: Error) {
        print("Error: \(error)")
    }

    func swconnection(connection: SWConnection, dataSentAndLoadedSucessfully result: SWResult) {
		
        print("Service Name: \(ACTION_FUNCTION_NAME_TAG) Result Code: \(String(describing: result.resultCode)) , Result Message:  \(String(describing: result.resultMessage)), Result Data: \(String(describing: result.dataObject))")
	
    }
}
