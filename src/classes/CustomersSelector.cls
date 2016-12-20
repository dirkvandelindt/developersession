/**
 * Selector class for handling all the query to the External Object
 *
 * @author  Dirk van de Lindt <dvandelindt@deloitte.nl>
 * @created December 2016
 */
public with sharing class CustomersSelector implements ICustomersSelector {
    public List<Customers__x> selectCustomerById( String id ) {
        return [
            SELECT Country__c, City__c, Address__c, CompanyName__c,
                ContactName__c, ContactTitle__c
            FROM Customers__x
            WHERE ExternalId = :id
        ];
    }
    
    public List<Customers__x> selectCustomersByRegion( String region ) {
        return [
            SELECT Country__c, City__c, Address__c, CompanyName__c,
                ContactName__c, ContactTitle__c
            FROM Customers__x
            WHERE Region__c = :region
        ];
    }
}