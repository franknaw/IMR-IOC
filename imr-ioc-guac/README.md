### Apache Guacamole RESTFULL API

***
#### [Authenticating](./Auth.md) 
- This returns an "Auth Token" that is used as a parameter for all subsequent requests.
***
#### [Managing Users](./User.md)
***
#### [Managing Connections](./Connection.md)
***
#### Notes

Example showing how to create the connection ID encoding that is used as a unique connection identifier.  The '2' value is an example of the actual connection id.
- `printf '2\0c\0postgresql' | base64`

***
Example showing a "pre-signed" URL, this can be used by students for direct connections to connection resources.  This also needs to include the "Auth Token".
- `http://localhost:8080/guacamole/#/client/MgBjAHBvc3RncmVzcWw=?token=1A6C787FC5ABDA7AFA49E9BF07EE3B44B1DCA520D5EC51F8FBB8AF841391AF0B`
***

#### Group Concepts

Connection groups can contain n-number of connection groups, connections and sharing profiles.
 - https://guacamole.apache.org/doc/gug/administration.html#connections-and-connection-groups

User groups can contain n-number of users with group permissions. 
- https://guacamole.apache.org/doc/gug/administration.html#user-group-management

#### Other files
[Guacamole Postman File](./Guacamole.postman_collection.json)

[Guacapy Proof of Concept Work](./main.py)

[Guacapy Source Code](./guacapy_source.py)



