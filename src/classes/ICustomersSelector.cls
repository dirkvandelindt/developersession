/**
 * Interface class for methods definition required in the Selector and SelectorMock
 *
 * @author  Dirk van de Lindt <dvandelindt@deloitte.nl>
 * @created December 2016
 */
public interface ICustomersSelector {

    List<Customers__x>  selectCustomerById( String id );
    List<Customers__x>  selectCustomersByRegion( String region );

}