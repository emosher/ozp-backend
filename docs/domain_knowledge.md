## The life of a submitted listing
Description on how listings get submitted.    
API endpoint: ````/api/listing````

* User: A User submits a listing    
    * State    
        * User: Submitted Listing    
        * Org Steward: Needs Action (Approve Listing or return listing to user)    
        * Admin: Pending    
* Org Steward: An Org Steward will approve user's listing or return back to the user with a comment)    
    * State: If Approved    
        * User: Pending    
        * Org Steward: Org Approved    
        * Admin: Needs Action    
    * State: If Returned to the user    
        * User: Needs Action    
        * Org Steward: Returned    
        * Admin: Returned    
* Admin: An admin will approve or reject listing for a org    
    * State: If approved the listing will be published   
        * User: Done    
        * Org Steward: Org Approved    
        * Admin: Admin Approved (Listing Published)    
    * State: If rejected    
        * User: Needs Action    
        * Org Steward: Returned   
        * Admin: Returned    

````
                           Submitted
 +--------+                Listing     +---------------------+
 |  USER  +------------------------->  |  ORG STEWARD/ADMIN  |
 +---+----+                            +---+----+------------+
     ^           Rejected Listing          |    |
     +---------------------+---------------+    |
                           ^                    |
                           |          Approved  |
                Approved   |          Listing   |
+-----------+   Listing   ++-------+            |
|Published  | <-----------+  ADMIN | <----------+
+-----------+             +--------+
````
