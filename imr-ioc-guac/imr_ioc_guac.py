import json
import guacapy


def add_connection_group():
    conn_group = {
        {"parentIdentifier": "ROOT",
         "name": "iaas-099 (Test)",
         "type": "ORGANIZATIONAL",
         "attributes": {"max-connections": "", "max-connections-per-user": ""}}
    }
    client.add_connection_group(conn_group)


def add_connection():
    conn = {
        {"name": "Test IOC DC",
         "parentIdentifier": "ROOT",
         "protocol": "rdp",
         "attributes": {"max-connections": "", "max-connections-per-user": ""},
         "activeConnections": 0,
         "parameters": {
             "port": "3389",
             "enable-menu-animations": "true",
             "enable-desktop-composition": "true",
             "hostname": "iaas-067-mgt01.vcloud",
             "color-depth": "32",
             "enable-font-smoothing": "true",
             "ignore-cert": "true",
             "enable-drive": "true",
             "enable-full-window-drag": "true",
             "security": "any",
             "password": "XXX",
             "enable-wallpaper": "true",
             "create-drive-path": "true",
             "enable-theming": "true",
             "username": "foo",
             "console": "true",
             "disable-audio": "true",
             "domain": "iaas-067-mgt01.vcloud",
             "drive-path": "/var/tmp",
             "disable-auth": "",
             "server-layout": "",
             "width": "",
             "height": "",
             "dpi": "",
             "console-audio": "",
             "enable-printing": "",
             "preconnection-id": "",
             "enable-sftp": "",
             "sftp-port": ""}}
    }
    client.add_connection(conn)


def add_user(username, passwd):
    user = {
        "username": username,
        "password": passwd,
        "attributes": {
            "disabled": "",
            "expired": "",
            "access-window-start": "",
            "access-window-end": "",
            "valid-from": "",
            "valid-until": "",
            "timezone": ""
        }
    }
    client.add_user(user)
    get_user(user)


def get_connections():
    conn = client.get_connections()
    print(json.dumps(conn))


def get_users():
    usrs = client.get_users()
    print(json.dumps(usrs))


def get_user(user):
    usr = client.get_user(user)
    print(json.dumps(usr))


def delete_user(user):
    usr = client.delete_user(user)
    print(json.dumps(usr))


def init_guac():
    url = "guacamole"
    hostname = "localhost:8080/"
    user = "someuser"
    passwd = "somepass"

    # initialize guacamole connection
    return guacapy.Guacamole(url_path=url, username=user, password=passwd, hostname=hostname,
                             method='http', verify=True)


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    client = init_guac()
    #get_users()
    get_user("testusr")
    get_connections()
    # add_user("foo", "foo")
    # delete_user("testusr")
