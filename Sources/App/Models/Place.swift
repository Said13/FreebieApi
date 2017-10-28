import Vapor
import FluentProvider
import HTTP

final class Place: Model {
    let storage = Storage()
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(row: Row) throws {
        name = try row.get("name")
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("name", name)
        return row
    }
}

/// MARK: Fluent Preparation
extension Place: Preparation {
    
    // prepares a table in the database
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string("name")
        }
    }
    
    // deletes the table from the database
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

/// MARK: JSON
extension Place: JSONConvertible {
    
    convenience init(json: JSON) throws {
        self.init(
            name: try json.get("name")
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Place.idKey, id)
        try json.set("name", name)
        return json
    }
}

extension Place: ResponseRepresentable { }

