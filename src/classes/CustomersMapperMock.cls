/**
 * Created by DvandeLindt on 20-12-2016.
 */

public with sharing class CustomerMappersMock implements ICustomersMapper {
    
    public Customers__x getCustomerById( String id ) {
        Customers__x customer = new Customers__x();
        return customer;
    }
    
    public List<Customers__x> getCustomersByRegion( String region ) {
        List<Customers__x> customers = new List<Customers__x>();
        return customers;
    }

}