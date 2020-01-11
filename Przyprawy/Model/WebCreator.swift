//
//  WebCretor.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 03/02/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation

protocol WebCreatorDelegate {
    func webCreatorDataSource(forRow row: Int, forSection section: Int) -> ProductTable?
    func webCreatorNumberOfRows(forSection section: Int) -> Int
    func webCreatorNumberOfSections() -> Int
    func webCreatorHeaderForSection() -> [String]?
}
class WebCreator {
    struct WebColDescription {
        let header:      String
        let size:        String
        let rowContent:  String
        let footContent: String
    }
    struct SectionsDescription {
        var mainTitle = ""
        var sectionTitles = ["XXXX","YYYYY"]//[String]()
        init() {
            mainTitle = "Koszyk produktów"
            sectionTitles = ["Przyprawy","Warzywa","Owoce","AAAA","BBBB","CCCC","DDDD","EEE"]
        }
    }
    var delegate: WebCreatorDelegate?
    
    var sectionInfoWeb: SectionsDescription = SectionsDescription()
    var webColsDescription: [WebColDescription] = []
    var db : [ProductTable] = []
    
    var i = 0
    var lp = 0
    var pictWidth  = 50
    var pictHeight = 50
    var headHtml = ""
    var bodyHtml = ""
    var footerHtml = ""
    let headerFilds = {}
    let contentField = {}
    let polishLanguage: Bool
    var tableHeaderHtml = ""
    
    var footerTitle = "Footer of page"
    var endHtml = ""
    var adresatHtml = ""
    var pictHtml = ""
    var ccsStyleExt = ""
    
    let headers     = ["Lp", "Nazwa produktu", "Producent"]
    let sizes       = ["5", "75", "*"]
    var rowContents  = ["col1", "col2", "col3"]
    var footContents = ["-", "Razem", "-"]  //["-", "Razem produktów \(footerTitle)", "\(lp)"]
   
    var lang = "en"
    var telFrom   = ""   //"512589528"
    var emailFrom = ""   //"kurczewski7@gmail.com"
    var htmlTablesCollection: [String] = [String]()
    
    func setSectionsTitles()  -> [String] {
        var value: [String] = [String]()
//        let sectionCount=database.category.getTotalNumberOfSection()
//        for i in 0..<sectionCount {
//                let sectionName = database.category.getCategorySectionHeader(forSection: i)
//                value.append(sectionName)
//            }
        let sectionTitle = self.delegate?.webCreatorHeaderForSection()
        value = sectionTitle ?? ["ffff","GGGG","HHHH","IIII","JJJJ","KKKKK","LLLLL","MMMMM"]
//        {
//            value = sectionTitle
//        }
//        else {
//            value = ["ffff","GGGG","HHHH","IIII","JJJJ","KKKKK","LLLLL","MMMMM"]
//        }
        return value
    }
    
    init(polishLanguage: Bool, telFrom: String, emailFrom: String)  {
        self.polishLanguage = Setup.polishLanguage
        self.telFrom = telFrom
        self.emailFrom = emailFrom
        lang = polishLanguage ? "pl" : "en"
        sectionInfoWeb.sectionTitles = setSectionsTitles()
        db=database.product.array

        //let allTitles = self.delegate?.webCreatorTitlesOfSerctions()
        //print("allTitles: \(allTitles ?? ["default value"])")
        //?? ["title0","title1","title2","title3"]
        
        self.i = 0
        self.lp = 0
        for i in 0..<headers.count {
            self.addWebCol(header: headers[i], size: sizes[i], rowContent: rowContents[i], footContent: footContents[i])
        }
                
        headHtml+="""
             <!DOCTYPE html><html lang=\"\(lang)\">\n
             <head><title>Products</title><meta charset=\"utf-8\">\n<style>\n
             table {width:100%;} \ntable, th, td {  border: 1px solid black;   border-collapse: collapse;  text-align: center;  }\n
             th {padding: 5px;text-align: center;}\n
             td {padding: 5px;text-align: left;}\n
             img {width: 100px; height: 100px;}\n
             table tr:nth-child(even) {   background-color: #eee;  }\n
             table tr:nth-child(odd)  {   background-color:#fff;   }\n
             table th                 {   background-color: powderblue;  }\n
             table#t02 table, th, td, thead, tfoot\n
             {\n
                 border: 0px solid yelow;\n
                 text-align: left;\n
            }\n
             table#t01 thead {  color:black;}\n
             table#t01 tfoot {  color:blue; }\n
            """
        
        if ccsStyleExt.count > 0 {
            headHtml+="\n\(ccsStyleExt)\n"
        }
        headHtml += """
            </style>\n
            </head>\n
            <body>\n
            """
 
        // <a href="sms:1-111-1111;body=I made it!">Send location via SMS</a>
        endHtml+="<a href=\"tel:\(telFrom)\">Tel:  \(telFrom)</a><br/>\n"
        endHtml+="<a href=\"sms://\(telFrom)\">Sms:  \(telFrom)</a><br/>\n"
        endHtml+="<a href=\"mailto:\(emailFrom)\">eMail:  \(emailFrom)</a><br/>\n"
        
        //"mailto://\(email)?cc=\(cc)&subject=\(subject)&body=\(body)"
        endHtml += """
            </body>
            </html>
            """
    }
    func addWebCol(header: String, size: String, rowContent: String, footContent: String) {
        let value: WebColDescription = WebColDescription(header: header, size: size, rowContent: rowContent, footContent: footContent)
        webColsDescription.append(value)
    }
    func craateHtmlTable(idTable: Int,  forSection section: Int, extraTitle: String = "") {
        var aTitle: String = "Section title"
        var tableHeaderHtml = ""
        var tableBodyHtml = ""
        var tableFooterHtml = ""
        
        aTitle = sectionInfoWeb.sectionTitles[section]  //[section] //sectionInfoWeb
        //aTitle = "SSSSSS"
        tableHeaderHtml="<table id=\"t0\(idTable)\" style=\"background-color:powderblue; border-style: solid; border-width: 1px;\">\n"
        tableHeaderHtml+="<caption><b>\(aTitle) \(extraTitle)</b></caption>\n"
        tableHeaderHtml+="<tr style=\"background-color:LightSeaGreen;\">"
        for tmp in webColsDescription {
            tableHeaderHtml+="<th style=\"width:\(tmp.size)%; background-color:LightSeaGreen;\">\(tmp.header)</th>" //powderblue
        }
        tableHeaderHtml+="</tr>\n"
        
        tableBodyHtml = getRowData(forSection: section)
        // ["-", "Razem produktów \(footerTitle)", "\(lp)"]
        tableFooterHtml += """
            <tfoot>\n
            <tr>\n
            """

        for tmp in webColsDescription {
            tableFooterHtml+="<th style=\"width:\(tmp.size)%; background-color:powderblue;\">\(tmp.footContent)</th>\n"
        }
        tableFooterHtml += """
            </tr>\n
            </tfoot>\n
            </table>
            """
        self.htmlTablesCollection.append(tableHeaderHtml + tableBodyHtml + tableFooterHtml)
    }

    func getRowData(forSection section: Int) -> String {
    var tableBodyHtml = ""
    var evenStyle = ""
        let numOfRows = self.delegate?.webCreatorNumberOfRows(forSection: section)
        print("getRowData:\(numOfRows!), section:\(section)")
    for i in 0..<numOfRows! {
        if let prod = self.delegate?.webCreatorDataSource(forRow: i, forSection: section) {
            evenStyle = i % 2 == 0 ? "LightCyan": "white"
            tableBodyHtml+="<tr style=\"background-color:\(evenStyle);\">"
            tableBodyHtml+="<td  style=\"text-align: center;\">\(i+1)</td>"
            tableBodyHtml+="<td>\(prod.productName ?? "brak")</td>"
            tableBodyHtml+="<td>\(prod.producent ?? "nie ma")</td>"
            tableBodyHtml+="</tr>\n"
            }
        }
        return tableBodyHtml
    }
    func getFullHtml() -> String{
        let sectionsCount = self.delegate?.webCreatorNumberOfSections() ?? 1
        for i in 0..<sectionsCount {
            craateHtmlTable(idTable: i+1, forSection: i)
        }
        var value = headHtml+pictHtml+tableHeaderHtml
        for tmp in htmlTablesCollection {
            value += tmp
        }
        value += footerHtml + adresatHtml + endHtml
    
        print(value)
        //print("headHtml:\(headHtml)")
        //print("tableHewaderHtml:\(tableHeaderHtml)")
        return value
    }
    func getFullSms(myPhoneNumber tel: String, myEmail eMail: String)  -> String {
        let sectionsCount = self.delegate?.webCreatorNumberOfSections() ?? 1
        var fullSmsText = ""
        for i in 0..<sectionsCount {
            fullSmsText += getOneSectionSms(forSection: i)
        }
        fullSmsText += "tel:\(tel)\n"
        fullSmsText += "mailto:\(eMail)\n"
        fullSmsText += "sms:\(tel)\n"

        return fullSmsText
    }
    func getOneSectionSms(forSection section: Int) -> String {
        //var smsText = "     \(sectionInfoWeb.sectionTitles[section])\n"
        var smsText = "smsText"
        let numOfRows = self.delegate?.webCreatorNumberOfRows(forSection: section)
        for i in 0..<numOfRows! {
            if let prod = self.delegate?.webCreatorDataSource(forRow: i, forSection: section) {
                smsText+="\(i+1)  \(prod.productName ?? "brak")\n"
            }
        }
        return smsText

    }
    func setCcsStyle(newStyleExtension style: String) {
        self.ccsStyleExt = style
    }
}
