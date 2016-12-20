/**
 * Created by DvandeLindt on 20-12-2016.
 */

public interface ICustomersMapper {
    
    Customers__x            getCustomerById( String id );
    List<Customers__x>      getCustomersByRegion( String region );

}