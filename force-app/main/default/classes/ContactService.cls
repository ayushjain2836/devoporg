@RestResource(urlMapping='/ContactServices/*')
global class ContactService {
    @HttpGet
    global static String getContactById() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        // Get the contact ID from the URL
        String contactId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        // Query the contact by ID
        Contact contact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id = :contactId LIMIT 1];
        // Handle case where contact is not found
        if (contact == null) {
            res.statusCode = 404;
            return 'Contact not found';
        }
        res.addHeader('Content-Type', 'application/json');
        return JSON.serialize(contact);
    }
}