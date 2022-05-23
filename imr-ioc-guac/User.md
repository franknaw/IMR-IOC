#### Create User - POST
- POST
- https://sandbox-train.foosource.net/guacamole/api/session/data/postgresql/users
- Json payload
```json
{
    "username": "newUser",
    "password": "newPass",
    "attributes": {
        "disabled": "",
        "expired": "",
        "access-window-start": "",
        "access-window-end": "",
        "valid-from": "",
        "valid-until": "",
        "timezone": null,
        "guac-full-name": "",
        "guac-organization": "",
        "guac-organizational-role": ""
    }
}
```
- Response
```json
{
    "username": "newUser",
    "password": "newPass",
    "attributes": {
        "guac-organizational-role": "",
        "guac-full-name": "",
        "expired": "",
        "access-window-start": "",
        "guac-organization": "",
        "access-window-end": "",
        "disabled": "",
        "valid-until": "",
        "valid-from": ""
    }
}
```
#### Update User
- PUT
- https://sandbox-train.foosource.net/guacamole/api/session/data/postgres/users/{{username}}
```json
{
    "username": "newUser",
    "attributes": {
        "guac-email-address": null,
        "guac-organizational-role": null,
        "guac-full-name": null,
        "expired": "",
        "timezone": null,
        "access-window-start": "",
        "guac-organization": null,
        "access-window-end": "",
        "disabled": "",
        "valid-until": "",
        "valid-from": ""
    }
}
```
- Response `1`

#### Delete User
- DELETE
```
https://sandbox-train.foosource.net/guacamole/api/session/data/postgres/users/newUser
```
- Response `1`

#### Assign User to Connections
- PATCH
- {{baseURL}}/api/session/data/{{dataSource}}/users/{{username}}/permissions
```json
[
    {
        "op": "add",
        "path": "/connectionPermissions/{{connection}}",
        "value": "READ"
    },
      {
        "op": "add",
        "path": "/connectionPermissions/{{connection}}",
        "value": "READ"
    }
]
```
- Response `1`

#### Revoke User from Connections
- PATCH
- {{baseURL}}/api/session/data/{{dataSource}}/users/{{username}}/permissions
```json
[
    {
        "op": "remove",
        "path": "/connectionPermissions/{{connection}}",
        "value": "READ"
    },
    {
        "op": "remove",
        "path": "/connectionPermissions/{{connection}}",
        "value": "READ"
    }
]
```
- Response `1`
