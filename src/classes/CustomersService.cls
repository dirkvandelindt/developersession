/**
 * Created by DvandeLindt on 20-12-2016.
 */

public with sharing class CustomersService {
    
    public static ICustomersMapper instance;
    
    public static ICustomersMapper getInstance() {
        if (instance == null)
        {
            if (Test.isRunningTest())
                instance = (ICustomersMapper) new CustomerMapperMock();
            else
                instance = (ICustomersMapper) new CustomerMapper();
        }
        
        return instance;
    }
    
    
    public Customers__x getCustomer( String id ) {
        Customers__x customer;
        
        if ( String.isBlank( id ) ) {
            customer = instance.getCustomerById( id );
        }
        
        return customer;
    }
}