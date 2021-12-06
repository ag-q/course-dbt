# WEEK 3

- What is our overall conversion rate?

`select count(distinct case when checkout_events > 0 then session_guid else null end)::float / count(distinct case when page_view_events > 0 then session_guid else null end)::float from "int_session_events";`

**around 75.76%**

- What is our conversion rate by product?

As there are cases when product conversion rate is greater than 100%, I wonder if this is the right approach. I calculated conversion rate as follows:
1. Check if there are cases when there is no add to cart event after last delete from cart event - it means this product did not make it to the checkout.
2. Add information about checkouts in a session to a product_guid - assume that all products added and not deleted from cart are in the checkout step if one exists.
3. Count distinct session ids for page_views with product id (a) and for checkouts for non-deleted products (b).
4. Divide b/a.

`select product_name, checkout_sessions::float/product_page_view_sessions::float product_checkout_rate from "fact_product_events";`

**Bird of Paradise: 1.14, Pilea Peperomioides: 1.13, Arrow Head: 1.11, String of pearls: 1.09, Majesty Palm: 1.09, Angel Wings Begonia: 1.08, Orchid: 1.08, Monstera: 1.07, Money Tree: 1.03, Pink Anthurium: 1.03, ZZ Plant: 1.03, Cactus: 0.97, Dragon Tree: 0.95, Peace Lily: 0.94, Calathea Makoyana: 0.93, Bamboo: 0.93, Snake Plant: 0.91, Boston Fern: 0.91, Aloe Vera: 0.89, Jade Plant: 0.88, Devil's Ivy: 0.87, Spider Plant: 0.87, Birds Nest Fern: 0.85, Pothos: 0.81, Fiddle Leaf Fig: 0.81, Philodendron: 0.79, Rubber Plant: 0.79, Ficus: 0.75, Ponytail Palm: 0.68, Alocasia Polly: 0.67**





