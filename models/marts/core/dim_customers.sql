{{config(
    materialized ="table"

)}}

With customers as (
    Select *
    from {{ref('stg_customers')}}
),
orders as (
    Select *
    from {{ref('stg_orders')}}
),
                 
customer_order as (Select customer_id, min(order_date) as first_order, max(order_date) as most_rescent_order,
                        count(order_id) as no_of_orders
                        from orders group by 1),
final as (select c.customer_id,
              c.first_name,
              c.last_name,
              co.first_order,
              co.most_rescent_order,
              coalesce(co.no_of_orders,0)
             from customers as c
             join customer_order as co
             using(customer_id))
             
SELECT * 
from final