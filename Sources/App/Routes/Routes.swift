import Vapor
extension Droplet {
    func setupRoutes() throws {
        
        
        // resources with EmptyInitiable
        try resource("place", PlaceController.self)
    }
}
