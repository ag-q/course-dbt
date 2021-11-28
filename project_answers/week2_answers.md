# WEEK 2

- What is our user repeat rate?

`select count(distinct case when orders > 1 then user_guid else null end)::float/ count(distinct user_guid)::float as repeat_rate from (select user_guid, count(distinct order_id) orders from "stg_orders" group by 1) orders_per_user;`
**0.8046875**

- What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Examples of good indicators of a user who will likely purchase again: number of orders already made, how recent a last order has been made, website visits after a purchase and time spend on the website. The most obvious sign there will be no future purchase would be account deletion or some kind of complain made by a user (unfortunately not available in our data). Usually users who made a purchase around eg. Christmas are likely to be one-time customers as well.
I would definitely export user orders data from the database and make a binary logistic regression model to answer that question honestly.

- Explain the marts models you added. Why did you organize the models in the way you did?
In the core folder I added all available data into users, orders & products tables - I added order items table to make it possible to join tables for users who do not have access to deeper project layers.
In the marketing folder I added all users characteristics I could find in the data to make it easier for the marketing team to know their customers.
In the product folder I added all events associated with specific product.