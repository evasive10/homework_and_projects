#!/usr/bin/python3

import argparse
import requests
import validators
import yaml
from urllib.parse import urlparse
from bs4 import BeautifulSoup
from bs4 import Comment

parser = argparse.ArgumentParser(description='The Achilles HTML Vulnerability Analyzer Version 1.0')

parser.add_argument('-v', '--version', action='version', version='%(prog)s 1.0')
parser.add_argument('url', type=str, help='The URL of the HTML to analyze')
parser.add_argument('--config', help='Path to configuration file')
parser.add_argument('-o', '--output', help='Report file path')

args = parser.parse_args()

config = {'forms': True, 'comments': True, 'passwords': True}

if args.config:
    print('Using config file: ' + args.config)
    config_file = open(args.config, 'r')
    config_from_file = yaml.safe_load(config_file)
    if config_from_file:
        config = { **config, **config_from_file }

report = ''

url = "http://" + args.url

if validators.url(url):
    result_html = requests.get(url).text
    parsed_html = BeautifulSoup(result_html, 'html.parser')
    
    forms           = parsed_html.find_all("form")
    comments        = parsed_html.find_all(string=lambda text:isinstance(text,Comment))
    password_inputs = parsed_html.find_all('input', { 'name' : 'password' })

    if config['forms']:
        for form in forms:
            if form.get('action').find('https') < 0 and (urlparse(url).scheme != 'https'):
                form_is_secure = False
                report += 'Form Issue: Insecure form action ' + form.get('action') + ' found in document\n'

    if config['comments']:
        for comment in comments:
            if comment.find('key: ') > -1:
                report += 'Comment Issue: Key is found in the HTML comments, please remove\n'

    if config['passwords']:
        for password_input in password_inputs:
            if password_input.get('type') != 'password':
                report+= 'Input Issue: Plaintext password input found. Please change to password type input\n'

else:
    print("Invalid URL")


if(report ==''):
    report += 'No issues found in HTML document'
else:
    header = 'Vulnerability Report is as follows\n'
    header += '=' * 35 + '\n'
    report = header + report

if args.output:
    f = open(args.output, 'w')
    f.write(report)
    f.close
    print('Report saved to: ' + args.output)
else:
    print(report)
