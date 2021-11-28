# WEEK 1

- How many users do we have?

`select count(distinct user_id) from "stg_users";`
**130**

- On average, how many orders do we receive per hour?

Assuming 10 orders with null creation date are valid, so they were received within two existing data dates, then:

`select count(distinct order_id) / ceiling(extract(epoch from max(created_at_utc)-min(created_at_utc))/3600) from "stg_orders";`
**around 8.34 orders per hour**

- On average, how long does an order take from being placed to being delivered?

`select avg(delivered_at_utc - created_at_utc) avg_time_from_order_creation_to_delivery from "stg_orders" where created_at_utc is not null and delivered_at_utc is not null;`
**{ "days": 3, "hours": 22, "minutes": 13, "seconds": 10, "milliseconds": 504.451 }**

- How many users have only made one purchase? Two purchases? Three+ purchases?

Assuming 10 orders with null creation date are valid, then:

`select case when orders > 2 then '3+' else cast(orders as varchar) end as orders_per_user, count(distinct user_guid) users from (select user_guid, count(distinct order_id) orders from "stg_orders" group by 1) orders_per_user group by 1;`
**1 purchase: 25 users, 2 purchases: 22 users, 3+ purchases: 81 users**

- On average, how many unique sessions do we have per hour?

Assuming the session starts on the first session event time and is assigned to this day only
and we have full events data for four days from '2021-02-09' to '2021-02-12' (there are single sessions for rest of days)
and we include all hours from these four days (i.e. 96 hours), then:

`select count(distinct session_guid) / (ceiling(extract(epoch from max(session_started_at_utc)-min(session_started_at_utc ))/3600/24)*24) from (select session_guid, min(created_at_utc) session_started_at_utc from "stg_events" group by 1) sessions where date(session_started_at_utc) between '2021-02-09' and '2021-02-12';`
**around 10.10 sessions per hour**