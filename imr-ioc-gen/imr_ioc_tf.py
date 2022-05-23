import json
from typing import List

# sandbox guacamole
guac_app = "174.16.32.150"
guac_d = "174.16.33.254"


class NetInterface:
    def __init__(self, ips, ids):
        self.ips = ips
        self.ids = ids


ni1_pair_list: List[NetInterface] = []
ni2_pair_list: List[NetInterface] = []


def read_file():
    f = open('../imr-ioc-ni/ni_ips.json')
    data = json.load(f)
    f.close()
    return data


def parse_ni(ip_list, id_list):
    ni_pair_list: List[NetInterface] = []
    for a, b, c, d in zip(ip_list[0::2], ip_list[1::2], id_list[0::2], id_list[1::2]):
        ni_pair_list.append(NetInterface([str(a), str(b)], [str(c), str(d)]))

    return ni_pair_list


def generate_tf_ioc(ni_list):
    tf_ioc_payload = open('./template/ec2-tf-ioc-template.txt', 'r').read()

    idx = 1
    for ni in ni_list:
        tf_payload = tf_ioc_payload
        tf_payload = tf_payload.replace("REPLACE_IP1", str(ni.ips[0]))
        tf_payload = tf_payload.replace("REPLACE_IP2", str(ni.ips[1]))
        tf_payload = tf_payload.replace("REPLACE_NI_ID1", str(ni.ids[0]))
        tf_payload = tf_payload.replace("REPLACE_NI_ID2", str(ni.ids[1]))
        tf_payload = tf_payload.replace("REPLACE_IDX", str(idx))
        tf_payload = tf_payload.replace("GUAC_APP", str(guac_app))
        tf_payload = tf_payload.replace("GUAC_D", str(guac_d))

        idx += 1
        print(tf_payload)
        print("\n")


def print_ni():
    for x in ni1_pair_list:
        print(x.ips)
        print(x.ids)

    for x in ni2_pair_list:
        print(x.ips)
        print(x.ids)


# Json file created by terraform output -json > ni_ips.json
if __name__ == '__main__':
    # just use "aws_network_interface" from "172.16.17.0/22"
    # CDM will use ""172.16.16.0/22""
    ni1_pair_list = parse_ni(read_file()["eni_1_ips"]["value"], read_file()["eni_1_ids"]["value"])
    generate_tf_ioc(ni1_pair_list)
    # ni2_pair_list = parse_ni(read_file()["ani_2_ips"]["value"], read_file()["ani_2_ids"]["value"])
    # generate_tf_ioc(ni2_pair_list)
    # print_ni()
