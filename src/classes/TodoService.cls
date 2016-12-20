/**
 * Service class for handling the security, transaction, errors and validation for the Selector class
 *
 * @author  Dirk van de Lindt <dvandelindt@deloitte.nl>
 * @created December 2016
 */
public with sharing class TodoService {
    
    public static String getTodoEndpoint(String externalIds) {
        String endpointUrl = 'https://';
        return endpointUrl;
    }
    
    
    public static ICustomersMapper instance;
    
    public static ICustomersMapper getInstance() {
        if ( instance == null ) {
            if ( Test.isRunningTest() )
                instance = ( ICustomersMapper ) new CustomersMapperMock();
            else
                instance = ( ICustomersMapper ) new CustomersMapper();
        }
        
        return instance;
    }
    
    
    public Customers__x getCustomer( String id ) {
        Customers__x customer;
        
        if ( String.isBlank( id ) ) {
            List<Customers__x> customers = instance.getCustomerById( id );
            if ( customers != null && customers.size() > 0 )
                customer = customers[0];
        }
        
        return customer;
    }
    
    
    public List<Customers__x> getAllCustomersFromSpain() {
        
        return instance.getCustomersByRegion( 'SP' );
    
    }
}