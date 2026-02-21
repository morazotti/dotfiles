#!/bin/python

DEFAULT_PWRD_FILE = "/home/nicolas/.passwords.csv.gpg"

import os, csv
from pprint import pprint as pp

def get_pwrd_list(encrypted_pwrd_list=DEFAULT_PWRD_FILE):
    pwrd_file = get_unencrypted_pwrd_str(encrypted_pwrd_list)
    with open(pwrd_file,'r') as file:
        pwrd_list = [line for line in csv.reader(file)]
    os.system("shred -un 5 {}".format(pwrd_file))
    return(pwrd_list)

def get_unencrypted_pwrd_str(encrypted_pwrd_list):
    os.system("gpg -v {}".format(encrypted_pwrd_list))
    return(encrypted_pwrd_list[:-4])

def get_dict_list_user(pwrd_list):
    all_pwrd_dict = []
    for pwrd in pwrd_list:
        important_pwrd_fields = get_username_pwrd_domain(pwrd)
        print(important_pwrd_fields)
        pwrd_dict={
            "username":important_pwrd_fields[1],
            "password":important_pwrd_fields[2],
            "domain":important_pwrd_fields[-3]
        }
        all_pwrd_dict.append(pwrd_dict)
    return all_pwrd_dict

def get_username_pwrd_domain(domain_user_id):
    return (domain_user_id)

pwrd_list = get_pwrd_list()
pwrd_dict = get_dict_list_user(pwrd_list)
