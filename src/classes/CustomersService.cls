/**
 * Service class for handling the security, transaction, errors and validation for the Selector class
 *
 * @author  Dirk van de Lindt <dvandelindt@deloitte.nl>
 * @created December 2016
 */
public with sharing class CustomersService {
    
    public static ICustomersSelector instance;
    
    public static ICustomersSelector getInstance() {
        if ( instance == null ) {
            if ( Test.isRunningTest() )
                instance = ( ICustomersSelector ) new CustomersSelectorMock();
            else
                instance = ( ICustomersSelector ) new CustomersSelector();
        }
        
        return instance;
    }
    
    public Customers__x getCustomer( String id ) {
        Customers__x customer;
        
        if ( String.isBlank( id ) ) {
            List<Customers__x> customers = instance.selectCustomerById( id );
            if ( customers != null && customers.size() > 0 )
                customer = customers[0];
        }
        
        return customer;
    }
    
    public List<Customers__x> getAllCustomersFromSpain() {
        
        return instance.selectCustomersByRegion( 'SP' );
    
    }
}