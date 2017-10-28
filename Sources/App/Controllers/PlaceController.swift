import Vapor
import HTTP

final class PlaceController: ResourceRepresentable {
    
    /// When users call 'GET' on '/place'
    /// it should return an index of all available place
    func index(req: Request) throws -> ResponseRepresentable {
        return try Place.all().makeJSON()
    }
    
    /// When consumers call 'POST' on '/place' with valid JSON
    /// create and save the post
    func create(request: Request) throws -> ResponseRepresentable {
        let place = try request.place()
        try place.save()
        return place
    }
    
    /// When the consumer calls 'GET' on a specific resource, ie:
    /// '/place/13rd88' we should show that specific post
    func show(req: Request, place: Place) throws -> ResponseRepresentable {
        return place
    }
    
    /// When the consumer calls 'DELETE' on a specific resource, ie:
    /// 'place/l2jd9' we should remove that resource from the database
    func delete(req: Request, place: Place) throws -> ResponseRepresentable {
        try place.delete()
        return Response(status: .ok)
    }
    
    
    /// When a user calls 'PUT' on a specific resource, we should replace any
    /// values that do not exist in the request with null.
    /// This is equivalent to creating a new Place with the same ID.
    func replace(req: Request, place: Place) throws -> ResponseRepresentable {
        // First attempt to create a new Place from the supplied JSON.
        // If any required fields are missing, this request will be denied.
        let new = try req.place()
        
        // Update the place with all of the properties from
        // the new place
        place.name = new.name
        try place.save()
        
        // Return the updated place
        return place
    }
    
    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<Place> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: replace,
            destroy: delete
        )
    }
}

extension Request {
    /// Create a post from the JSON body
    /// return BadRequest error if invalid
    /// or no JSON
    func place() throws -> Place {
        guard let json = json else { throw Abort.badRequest }
        return try Place(json: json)
    }
}

extension PlaceController: EmptyInitializable { }
