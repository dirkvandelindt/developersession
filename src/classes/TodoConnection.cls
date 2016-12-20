/**
 * Salesforce Datasource.Connection class
 *
 * @author  Dirk van de Lindt <dvandelindt@deloitte.nl>
 * @created December 2016
 */
public class TodoConnection extends DataSource.Connection
{
    public TodoConnection(DataSource.ConnectionParams connectionParams){}
    
    public override List<DataSource.Table> sync()
    {
        List<Datasource.Table> tables = new List<Datasource.Table>();
        List<Datasource.Column> columns = new List<Datasource.Column>();
        /*
        "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false
         */
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.url('DisplayUrl'));
        columns.add(DataSource.Column.text('userId', 255));
        columns.add(DataSource.Column.url('id'));
        columns.add(DataSource.Column.text('Title', 255));
        columns.add(DataSource.Column.boolean('Completed'));
        
        tables.add(DataSource.Table.get('Todo','Todos',
            'Todos from jsonplaceholder','Name', columns));
        return tables;
    }
    
    public override List<DataSource.TableResult> search(DataSource.SearchContext c)
    {
        return DataSource.SearchUtils.searchByName(c, this);
    }
    
    public override DataSource.TableResult query(DataSource.QueryContext c)
    {
        List<Map<String,Object>> rows = getRows(c);
        return DataSource.TableResult.get(c,rows);
    }
    
    private List<Map<String,Object>> getRows(DataSource.QueryContext c)
    {
        List<Map<String,Object>> rows = new List<Map<String,Object>>();
        
        if (c.tableSelection.filter != null)
        {
            // Restaurant detail retrieved by ExternalId
            if (c.tableSelection.filter.columnName == 'ExternalId')
            {
                String externalId = (String) c.tableSelection.filter.columnValue;
                
                List<Todo> todo = TodoService.getTodoByExternalIds(new List<String>{externalId});
                
                rows.add(getRowFromRestaurant(restaurants[0]));
            }
            else
            {
                DataSource.FilterType type = c.tableSelection.filter.type;
                
                // Restaurants retrieved by latitude and longitude
                if (type == DataSource.FilterType.AND_)
                {
                    List <DataSource.Filter> subfilters = c.tableSelection.filter.subfilters;
                    
                    Decimal latitude;
                    Decimal longitude;
                    
                    for (DataSource.Filter subfilter : subfilters)
                    {
                        if (subfilter.columnName == 'Latitude')
                            latitude = (Decimal) subfilter.columnValue;
                        if (subfilter.columnName == 'Longitude')
                            longitude = (Decimal) subfilter.columnValue;
                    }
                    
                    if (latitude != null && longitude != null)
                    {
                        List<Restaurant> restaurants =  TodoService.getRestaurantsByLocation(latitude,longitude);
                        for (Restaurant restaurant : restaurants)
                            rows.add(getRowFromRestaurant(restaurant));
                    }
                }
                // Restaurants retrieved by different ExternalIds
                else if (type == DataSource.FilterType.OR_)
                {
                    List <DataSource.Filter> subfilters = c.tableSelection.filter.subfilters;
                    List<String> externalIds = new List<String>();
                    
                    for (DataSource.Filter subfilter : subfilters)
                    {
                        if (subfilter.columnName == 'ExternalId')
                            externalIds.add((String) subfilter.columnValue);
                    }
                    
                    List<Restaurant> restaurants =  TodoService.getRestaurantsByExternalIds(externalIds);
                    for (Restaurant restaurant : restaurants)
                        rows.add(getRowFromRestaurant(restaurant));
                }
            }
        }
        
        return rows;
    }
    
    private Map<String,Object> getRowFromTodo(Todo todo)
    {
        Map<String,Object> row = new Map<String,Object>();
    
        row.put('ExternalId', todo.id);
        row.put('DisplayUrl', TodoService.getTodoEndpoint(todo.id));
        row.put('userId', todo.userId);
        row.put('Title', todo.title);
        row.put('Completed', todo.completed);
        return row;
    }
}