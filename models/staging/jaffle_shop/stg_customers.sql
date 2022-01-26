
With customers as
 (SELECT id as customer_id, first_name, last_name
from {{source('jaffle_shop', 'customers')}})

Select *
from customers
