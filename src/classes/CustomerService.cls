/**
 * Created by DvandeLindt on 20-12-2016.
 */

public with sharing class CustomerService {
    
    public static ICustomerMapper instance;
    
    public static ICustomerMapper getInstance() {
        if (instance == null)
        {
            if (Test.isRunningTest())
                instance = (ICustomerMapper) new CustomerMapperMock();
            else
                instance = (ICustomerMapper) new CustomerMapper();
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