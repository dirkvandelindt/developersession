/**
 * Mock class for simulating the External Object
 *
 * @author  Dirk van de Lindt <dvandelindt@deloitte.nl>
 * @created December 2016
 */
public with sharing class CustomersSelectorMock implements ICustomersSelector {
    
    public List<Customers__x> selectCustomerById( String id ) {
        List<Customers__x> customers = new List<Customers__x>();
        customers.add(
            new Customers__x(
                Address__c = 'Gustav Mahlerlaan 304',
                City__c = 'Amsterdam',
                Country__c = 'Netherlands'
            )
        );
        return customers;
    }
    
    public List<Customers__x> selectCustomersByRegion( String region ) {
        List<Customers__x> customers = new List<Customers__x>();
        customers.add(
            new Customers__x(
                Address__c = 'Gustav Mahlerlaan 304',
                City__c = 'Amsterdam',
                Country__c = 'Netherlands',
                Region__c = 'SP'
            )
        );
        
        customers.add(
            new Customers__x(
                Address__c = 'Street 2',
                City__c = 'City 2',
                Country__c = 'Netherlands',
                Region__c = 'AM'
            )
        );
        return customers;
    }
}