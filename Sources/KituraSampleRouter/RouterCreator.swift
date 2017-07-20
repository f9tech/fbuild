import Foundation
import Kitura
//import KituraMarkdown
import KituraMustache
//import KituraStencil // required for using StencilTemplateEngine
//import Stencil // required for adding a Stencil namespace to StencilTemplateEngine
import MongoKitten
import LoggerAPI

//import HeliumLogger
var Lemail = ""
var feed_email = ""
var pro_name = ""
var context1:[String:Any] = [
            "dashboard":""
        ] 
var count = 0

#if os(Linux)
    import Glibc
#endif
// Error handling example

enum SampleError: Error {
    case sampleError
}

let customParameterHandler: RouterHandler = { request, response, next in
    let id = request.parameters["id"] ?? "unknown"
    response.send("\(id)|").status(.OK)
    next()
}

class CustomParameterMiddleware: RouterMiddleware {
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        do {
            try customParameterHandler(request, response, next)
        } catch {
            Log.error("customParameterHandler returned error: \(error)")
        }

    }
}

extension SampleError: CustomStringConvertible {
    var description: String {
        switch self {
        case .sampleError:
            return "Example of error being set"
        }
    }
}

public struct RouterCreator {
    public static func create() -> Router {
        let router = Router()

        /**
         * RouterMiddleware can be used for intercepting requests and handling custom behavior
         * such as authentication and other routing
         */
        class BasicAuthMiddleware: RouterMiddleware {
            func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
                let authString = request.headers["Authorization"]
                Log.info("Authorization: \(String(describing: authString))")
                // Check authorization string in database to approve the request if fail
                // response.error = NSError(domain: "AuthFailure", code: 1, userInfo: [:])
                next()
            }
        }

        // Variable to post/put data to (just for sample purposes)
        var name: String?

        // This route executes the echo middleware
        router.all(middleware: BasicAuthMiddleware())

        router.all("/", middleware: StaticFileServer(path: "./public"))


/*router.get("/hello") { _, response, next in
            response.headers["Content-Type"] = "text/plain; charset=utf-8"
            let fName = name ?? "World"
            try response.send("Hello \(fName), from Kitura!").end()
        }

        // This route accepts POST requests
        router.post("/hello") {request, response, next in
            response.headers["Content-Type"] = "text/plain; charset=utf-8"
            name = try request.readString()
            try response.send("Got a POST request").end()
        }

        // This route accepts PUT requests
        router.put("/hello") {request, response, next in
            response.headers["Content-Type"] = "text/plain; charset=utf-8"
            name = try request.readString()
            try response.send("Got a PUT request").end()
        }

        // This route accepts DELETE requests
        router.delete("/hello") {request, response, next in
            response.headers["Content-Type"] = "text/plain; charset=utf-8"
            name = nil
            try response.send("Got a DELETE request").end()
        }

        router.get("/error") { _, response, next in
            Log.error("Example of error being set")
            response.status(.internalServerError)
            response.error = SampleError.sampleError
            next()
        }

        // Redirection example
        router.get("/redir") { _, response, next in
            try response.redirect("http://www.ibm.com/us-en/")
            next()
        }

        // Reading parameters
        // Accepts user as a parameter
        router.get("/users/:user") { request, response, next in
            response.headers["Content-Type"] = "text/html"
            let p1 = request.parameters["user"] ?? "(nil)"
            try response.send(
                "<!DOCTYPE html><html><body>" +
                    "<b>User:</b> \(p1)" +
                "</body></html>\n\n").end()
        }

        // Uses multiple handler blocks
        router.get("/multi", handler: { request, response, next in
            response.send("I'm here!\n")
            next()
            }, { request, response, next in
                response.send("Me too!\n")
                next()
        })
        router.get("/multi") { request, response, next in
            try response.send("I come afterward..\n").end()
        }

        router.get("/user/:id", allowPartialMatch: false, middleware: CustomParameterMiddleware())
        router.get("/user/:id", handler: customParameterHandler)

        // add Stencil Template Engine with a extension with a custom tag
        let _extension = Extension()
        // from https://github.com/kylef/Stencil/blob/master/ARCHITECTURE.md#simple-tags
        _extension.registerSimpleTag("custom") { _ in
            return "Hello World"
        }
        router.add(templateEngine: StencilTemplateEngine(extension: _extension))
*/

//********Registration


      router.get("/register") { request, response, next in
            defer {
                next()
            }
        if let userName = request.queryParameters["user-name"] {
            if let email = request.queryParameters["user-email"] {
                if let ph = request.queryParameters["user-phone"] {
                    if let password = request.queryParameters["user-password"] {
                        if let type = request.queryParameters["type-of-customer"] {
                            if let servicetype = request.queryParameters["TypeOfService"] {
                     
            let server: Server!
            do{
                server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
                let database = server["fbuild"]
                /*if type == "serviceprovider" {
                    var t = database["serviceprovider-details"]
                } else if type == "supplier" {
                    var t = database["supplier-details"]
                } else {
                    var t = database["customer-details"]
                }
                let users = database["t"]*/
                let users = database[type]
                print("data base connected")
                var flag = 0
                let userDocument: Document = [
                "Name": userName,
                "email": email,
                "ph": ph,
                "password": password,
                "typeofservice": servicetype
                ]
                let result = try users.find(["email": email])
                 for x in result{
                           flag = 1
                }
                if  flag == 1 {
                    try response.send("emailexists").end()
                 } else {
                       try users.insert(userDocument)
                       try response.redirect("http://localhost:8080")
                }
                
              
              //try response.status(.OK).send("data inserted into database successfully").end()
              //try response.redirect("http://localhost:8080")
            }
            } 
                }
                    }
                }
            }

                        } else{
                        try response.status(.OK).send("Registration failed").end()
                             }
            }

//**login

 router.get("/login") { request , response, next in
            defer {
                next()
            }    
        let server: Server!

        if let useremail = request.queryParameters["user-email"]{
            if let password = request.queryParameters["user-password"]{
                if let type = request.queryParameters["type"]{
                    do{
                        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
                        let database = server["fbuild"]
                        //let customerdetails = database["customer-details"]
                        let users = database[type]
                        var flag = 0
                        let result = try users.find(["email": useremail, "password": password])
                        for x in result{
                            flag = 1
                        }
                        if  flag == 1 {
                                Lemail = useremail



let result = try users.find(["email": Lemail])
                  var inter = [[String: Any]]()
                  for y in result{
                  inter.append(["Name":y["Name"]!,"phonenumber":y["ph"]!,"email":y["email"]!]) 
            }
        context1 = [
            "dashboard":inter
        ]  
            
        try response.render("template",context:context1)           
     try response.render("dashboard", context: context1).end()               
    
  }
                     // try response.redirect("http://localhost:8080/dashboard")


                           // } 
                            else {
                                try response.redirect("http://localhost:8080/")
                           }
                    }
                }
            }
        } else{
             try response.status(.OK).send("login failed").end()
                } 
    }

        // Support for Mustache implemented for OSX only yet
        #if !os(Linux) || swift(>=3.1)
            router.setDefault(templateEngine: MustacheTemplateEngine())

            router.get("/dashboard") { _, response, next in
                defer {
                    next()
                }
                // the example from https://github.com/groue/GRMustache.swift/blob/master/README.md
                var context: [String: Any] = [
                    "name": "Arthur",
                    "date": Date(),
                    "realDate": Date().addingTimeInterval(60*60*24*3),
                    "late": true
                ]

                // Let template format dates with `{{format(...)}}`
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                context["format"] = dateFormatter
                print(context1)
                print(context1)
                try response.render("template",context:context1)
                try response.render("dashboard", context: context).end()
            }
        #endif

//************Select Provider TypeOfService
     
            router.get("/selectProviderType") { _, response, next in
                defer {
                    next()
                }
                // the example from https://github.com/groue/GRMustache.swift/blob/master/README.md
                var context: [String: Any] = [
                    "name": "Arthur",
                    "date": Date(),
                    "realDate": Date().addingTimeInterval(60*60*24*3),
                    "late": true
                ]

                // Let template format dates with `{{format(...)}}`
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                context["format"] = dateFormattertype

                try response.render("template",context:context1)
                try response.render("selectProviderType", context: context).end()
            }


//******invite-myteam

 router.get("/Invite-myteam") { request, response, next in
                defer {
                    next()
                }
                let pname = request.queryParameters["pro_name"] ?? ""
                pro_name = pname
                //print("heyyyyyyyyyyyyyyyyyyyyyyyyyyyy\(pro_name)")
                // the example from https://github.com/groue/GRMustache.swift/blob/master/README.md
                var context: [String: Any] = [
                    "name": "Arthur",
                    "date": Date(),
                    "realDate": Date().addingTimeInterval(60*60*24*3),
                    "late": true
                ]

                // Let template format dates with `{{format(...)}}`
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                context["format"] = dateFormatter

               try response.render("template",context:context1)
               try response.render("Invite-myteam", context: context).end()
            }


//***********Types Of Members

 router.get("/typesOfMembers") { _, response, next in
                defer {
                    next()
                }
                // the example from https://github.com/groue/GRMustache.swift/blob/master/README.md
                var context: [String: Any] = [
                    "name": "Arthur",
                    "date": Date(),
                    "realDate": Date().addingTimeInterval(60*60*24*3),
                    "late": true
                ]

                // Let template format dates with `{{format(...)}}`
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                context["format"] = dateFormatter

               try response.render("template",context:context1)
               try response.render("typesOfMembers", context: context).end()
            }            

        // router.get("/articles") { _, response, next in
        //     defer {
        //         next()
        //     }
        //     do {
        //         // the example from https://github.com/kylef/Stencil
        //         let context: [String: Any] = [
        //             "articles": [
        //                 [ "title": "Migrating from OCUnit to XCTest", "author": "Kyle Fuller" ],
        //                 [ "title": "Memory Management with ARC", "author": "Kyle Fuller" ],
        //             ]
        //         ]

        //         // we have to specify file extension here since Stencil is not the default engine
        //         try response.render("document.stencil", context: context).end()
        //     } catch {
        //         Log.error("Failed to render template \(error)")
        //     }
        // }


//******************************************************************************************************
            //getservice provider********************************************8


       router.get("/serviceprovider") { request, response, next in
            defer {
                next()
            }
        
        let server: Server!
        do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users = database["serviceprovider"]
        let type = request.queryParameters["x"]

        let result = try users.find(["TypeOfService": type])
                  var inter = [[String: Any]]()
                    count = 0
                  for x in result{
                    count = count+1
                  inter.append(["name":x["Name"]!,"phonenumber":x["PhoneNumber"]!,"id":String(x["_id"])!,"count":count]) 
            }
        let context:[String:Any] = [
            "sps":inter
        ]  
        print(context)               
     try response.render("template",context:context1)
     try response.render("serviceProviders", context: context).end()               
    
  }
  catch {
                Log.error("Failed to render template \(error)")
            }
}


//complete details of sp******************************************************************


       router.get("/specificSp") { request, response, next in
            defer {
                next()
            }
            let id = request.queryParameters["id"] ?? ""        
        let server: Server!
        do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users = database["serviceprovider"]
        let users2 = database["members"]
        let result = try users.find(["_id": ObjectId("\(id)")])              
                  //"id": String(y["_id"])!
                  print(id)
                  var inter = [[String: Any]]()
                  var inter2 = [[String: Any]]()
                  for x in result{
                  let semail = x["Email"]
                  let result2 = try users2.find(["S_email": semail])
                  for y in result2{
                  let review = y["Review"]
                  print(review!)
                  inter2.append(["review":review!])
                  
                  }
                  inter.append(["name":x["Name"]!,"phonenumber":x["PhoneNumber"]!,"email":x["Email"]!,"img":x["Image"]!,"TypeOfService":x["TypeOfService"]!,"idd":id]) 
                
            }
        let context:[String:Any] = [
            "sspd":inter,
            "sspd2":inter2
        ]  
        print(context)
                       
        print(context)
        print(context)               
     try response.render("template",context:context1)
     try response.render("sspd", context: context).end()                   
  }
  catch {
                Log.error("Failed to render template \(error)")
            }
}



//******************************************Invite
router.get("/invite") { request, response, next in
            defer {
                next()
            }
            let id = request.queryParameters["id"] ?? ""
            print(id)
        
       let server: Server!
        do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users = database["serviceprovider"]
        let users2 = database["members"]
        var flag = 0
        let result = try users.find(["_id": ObjectId("\(id)")])
                  for x in result{
                  let semail = x["Email"]
        let userDocument: Document = [
        "Name": pro_name,
        "U_email": Lemail,
        "S_email": semail,
        "Req_status": "0",
        "Review": ""       
        ]

        let result2 = try users2.find(["S_email": semail , "U_email": Lemail])
                 for y in result2{
                           flag = 1
                }
                if  flag == 0 {
                    try users2.insert(userDocument)
                    
                 } 
                       //try response.send("alreadyexists").end()
                       try response.render("template",context:context1)
                       try response.redirect("http://localhost:8080/selectProviderType")

} 
}
} 




// my team*********************************************************************************

     router.get("/myTeam") { _, response, next in
            defer {
                next()
            }
        
        let server: Server!

        do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users1 = database["members"]
        let users2 = database["serviceprovider"]
       // print(Lemail)

        let result = try users1.find(["U_email": Lemail])
                  var inter = [[String: Any]]()
                  var inter2 = [[String: Any]]()
                  print(Lemail)
                  count = 0
                  for x in result{
                    count = count+1
                  //inter.append(["member_email":x["S_email"]!, "status":x["Req_status"]!]) 
                  var member_email = x["S_email"]
                  var result2 = try users2.find(["Email": member_email])
                  for y in result2{
                    //print(y)

                  inter2.append([/*"id": String(y["_id"])!*/"count":count,"provider_name": y["Name"]!, "PhoneNumber": y["PhoneNumber"]!, "TypeOfService": y["TypeOfService"]!])
                  }
            }
        let context:[String:Any] = [
            "myteam":inter2
        ]  
        print(context)               
     try response.render("template",context:context1)
     try response.render("myteam", context: context).end()               
    
  }
  catch {
                Log.error("Failed to render template \(error)")
            }
}



//********Create Project


        router.get("/createProject") { request, response, next in
            defer {
                next()
            }
    if let pname = request.queryParameters["name"] {
        if let ctype = request.queryParameters["ctype"] {
            if let area = request.queryParameters["area"] {
                if let location = request.queryParameters["location"] {                 
    let server: Server!
    do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users = database["projects"]
        var flag=0
        print("data base connected")
        let userDocument: Document = [
        "Name": pname,
        "Type": ctype,
        "Area": area,
        "Location": location,
        "P_Status": "0",
        "U_email": Lemail       
        ]
        let result = try users.find(["Name": pname])
                 for x in result{
                           flag = 1
                }
                if  flag == 0 {
                    try users.insert(userDocument)
                    
                 } else {
                       try response.send("alreadyexists").end()
                       try response.render("template",context:context1)
                       try response.redirect("http://localhost:8080")
                }
       
      try response.redirect("http://localhost:8080/dashboard")
}
    } 
    }
       }
           } 
  }





//*******************************************************reviews/feedback

 router.get("/reviews") { request, response, next in
            defer {
                next()
            }
            let id = request.queryParameters["id"] ?? ""
             print(id)
        
        let server: Server!

        do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users1 = database["members"]
        let users2 = database["serviceprovider"]

         // //let result = try users1.find(["U_email": "durgadevichaganti457@gmail.com"])
         //          var inter1 = [[String: Any]]()
                     var inter2 = [[String: Any]]()
         //          for x in result{
         //          inter1.append(["Review":x["Review"]!])
         //          var Review = x["Review"]
         //          print(Review!) 
         //         // var member_email = x["S_email"]
         //          //print(member_email!)
         //          print(id)
                   var result2 = try users2.find(["_id": ObjectId("\(id)")])

                  print("Hey Iam here!!!!!!!")
                  print(result2)
                  for y in result2{
                 var f = String(y["Email"])!
                 feed_email = f
                 print(f)
                 print(feed_email)
                  
                  inter2.append(["provider_name": y["Name"]!, "PhoneNumber": y["PhoneNumber"]!, "TypeOfService": y["TypeOfService"]!,"email":y["Email"]!])
                 
                  
                  }
            
        let context:[String:Any] = [
            "reviews":inter2
        ]  
        print(context)     
        try response.render("template",context:context1)          
     try response.render("teamMember", context: context).end()               
    
  }
  catch {
                Log.error("Failed to render template \(error)")
            }
}


//*****************Current Projects**********************





       router.get("/currentProjects") { _, response, next in
            defer {
                next()
            }
        
        let server: Server!
        do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users = database["projects"]
        let result = try users.find(["U_email": Lemail, "P_Status": "0"])
                  var inter = [[String: Any]]()
                  count = 0
                  for x in result{
                    count = count+1
                  inter.append(["project_name": x["Name"]!,"Type": x["Type"]!,"count":count]) 
            }
        let context:[String:Any] = [
            "currentprojects":inter
        ]  
        print(context)
        try response.render("template",context:context1)               
     try response.render("currentprojects", context: context).end()               
    
  }
  catch {
                Log.error("Failed to render template \(error)")
            }
}

//*****************Previous Projects**********************




       router.get("/previousProjects") { _, response, next in
            defer {
                next()
            }
        
        let server: Server!
        do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users = database["projects"]
        let result = try users.find(["U_email": Lemail, "P_Status": "1"])
                  var inter = [[String: Any]]()
                  count = 0
                  for x in result{
                    count = count+1
                  inter.append(["project_name": x["Name"]!,"Type": x["Type"]!,"count":count]) 
            }
        let context:[String:Any] = [
            "previousprojects":inter
        ]  
        print(context) 
        try response.render("template",context:context1)              
     try response.render("previousprojects", context: context).end()               
    
  }
  catch {
                Log.error("Failed to render template \(error)")
            }
}


//******************************************Specific Project Details*************


router.get("/specificProject") { _, response, next in
            defer {
                next()
            }
        
        let server: Server!
        do{
        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
        let database = server["fbuild"]
        let users = database["projects"]
        let result = try users.find(["Name": "devika"])
                  var inter = [[String: Any]]()
                  for x in result{
                  inter.append(["Name":x["Name"]!,"Type":x["Type"]!,"Area":x["Area"]!,"Location":x["Location"]!,"Project_status":x["P_Status"]!]) 
            }
        let context:[String:Any] = [
            "specificproject":inter
        ]  
        print(context)       
        try response.render("template",context:context1)        
     try response.render("specificproject", context: context).end()               
    
  }
  catch {
                Log.error("Failed to render template \(error)")
            }
}

//**************************************User Profile
 


router.get("/profile") { request , response, next in
            defer {
                next()
            }    
        let server: Server!

       
                    do{
                        server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
                        let database = server["fbuild"]
                        //let customerdetails = database["customer-details"]
                        let users = database["customer"]
                    

let result = try users.find(["email": Lemail])
                  var inter = [[String: Any]]()
                  for y in result{
                  inter.append(["Name":y["Name"]!,"phonenumber":y["ph"]!,"email":y["email"]!]) 
            }
        let context:[String:Any] = [
            "profile":inter
        ]  
        print(context)               
        try response.render("template",context:context1)
     try response.render("profile", context: context).end()               
    
  }

}


//******************feed back******************88
router.get("/feedback") { request, response, next in
            defer {
                next()
            }
    if let fb = request.queryParameters["feedback"]{


    
            let server: Server!

        do{
            server = try Server("mongodb://durgadevi197:devi@ds155132.mlab.com:55132/fbuild")
            let database = server["fbuild"]
            let users = database["members"]
            print("db connected")
          
  try users.update(["S_email":feed_email,"U_email":Lemail],to:["$set": ["Review": fb]])
     

     try response.redirect("http://localhost:8080/myTeam")               
    
  }
}
else {
    try response.status(.OK).send("failure").end()
}
}




                       // try response.redirect("http://localhost:8080/dashboard")


                           // } 
      


        // router.get("/articles_subdirectory") { _, response, next in
        //     defer {
        //         next()
        //     }
        //     do {
        //         // the example from https://github.com/kylef/Stencil
        //         let context: [String: Any] = [
        //             "articles": [
        //                 [ "title": "Migrating from OCUnit to XCTest", "author": "Kyle Fuller" ],
        //                 [ "title": "Memory Management with ARC", "author": "Kyle Fuller" ],
        //             ]
        //         ]

        //         // we have to specify file extension here since Stencil is not the default engine
        //         try response.render("subdirectory/documentInSubdirectory.stencil", context: context).end()
        //     } catch {
        //         Log.error("Failed to render template \(error)")
        //     }
        // }

        // router.get("/articles_include") { _, response, next in
        //     defer {
        //         next()
        //     }
        //     do {
        //         // the example from https://github.com/kylef/Stencil
        //         let context: [String: Any] = [
        //             "articles": [
        //                 [ "title": "Migrating from OCUnit to XCTest", "author": "Kyle Fuller" ],
        //                 [ "title": "Memory Management with ARC", "author": "Kyle Fuller" ],
        //             ]
        //         ]

        //         // we have to specify file extension here since Stencil is not the default engine
        //         try response.render("includingDocument.stencil", context: context).end()
        //     } catch {
        //         Log.error("Failed to render template \(error)")
        //     }
        // }

        // router.get("/custom_tag_stencil") { _, response, next in
        //     defer {
        //         next()
        //     }
        //     do {
        //         // we have to specify file extension here since Stencil is not the default engine
        //         try response.render("customTag.stencil", context: [:]).end()
        //     } catch {
        //         Log.error("Failed to render template \(error)")
        //     }
        // }

        // Add KituraMarkdown as a TemplateEngine
        // router.add(templateEngine: KituraMarkdown())

        // router.get("/docs") { _, response, next in
        //     try response.render("/docs/index.md", context: [String:Any]())
        //     response.status(.OK)
        //     next()
        // }

        // router.get("/docs/*") { request, response, next in
        //     if request.urlURL.path != "/docs/" {
        //         try response.render(request.urlURL.path, context: [String:Any]())
        //         response.status(.OK)
        //     }
        //     next()
        // }*/

        // Handles any errors that get set
        router.error { request, response, next in
            response.headers["Content-Type"] = "text/plain; charset=utf-8"
            let errorDescription: String
            if let error = response.error {
                errorDescription = "\(error)"
            } else {
                errorDescription = "Unknown error"
            }
            try response.send("Caught the error: \(errorDescription)").end()
        }

        // A custom Not found handler
        router.all { request, response, next in
            if  response.statusCode == .unknown  {
                // Remove this wrapping if statement, if you want to handle requests to / as well
                let path = request.urlURL.path
                if  path != "/" && path != ""  {
                    try response.status(.notFound).send("Route not found in Sample application!").end()
                }
            }
            next()
        }

        return router
    }
}



