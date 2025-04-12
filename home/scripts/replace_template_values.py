#!/usr/bin/env python3

import json
import subprocess
from typing import Any, Dict

excludes = [
    'config',
    'version',
    'arch',
    'args',
    'command',
    'osRelease',
    'pathListSeparator',
    'pathSeparator'
]

def flatten(d: Dict[str, Any], parent_key: str = '', sep: str = '.') -> Dict[str, Any]:
    items: Dict[str, Any] = {}
    for k, v in d.items():
        new_key = parent_key + sep + k if parent_key else k
        if isinstance(v, dict):
            items.update(flatten(v, new_key, sep=sep))
        else:
            items[new_key] = v
    return items

def reverse_dict(d: Dict[str, Any]) -> Dict[str, Any]:
    """Reverses the keys and values of a dictionary."""
    reversed_dict = {}
    for k, v in d.items():
        if isinstance(v, list):
            for item in v:
                reversed_dict[item] = k
        else:
            reversed_dict[v] = k
    return reversed_dict

def run_command(command: str) -> str:
    """Executes a shell command and returns its output."""
    result = subprocess.run(command, shell=True, text=True, capture_output=True, check=True)
    return result.stdout

if __name__ == "__main__":
    print("Getting configuration...")
    command = "chezmoi data"
    configuration = json.loads(run_command(command))

    cf = configuration['chezmoi']['config']
    command = f'age -i {cf["age"]["identity"]} -d {cf["sourceDir"]}/home/encrypted_dot_secrets.age'
    configuration.update(json.loads(run_command(command)))

    for i in excludes:
        del(configuration['chezmoi'][i])

    flattened_config = flatten(configuration)
    reversed_config = reverse_dict(flattened_config)        
    for key, value in reversed_config.items():
        print(f"{key}: {value}")    

    command = f'find {flattened_config["chezmoi.sourceDir"]} -type f | grep -E ".tmpl$"'
    templates = run_command(command)

    # for template_file in templates.strip().split('\n'):
    #     with open(template_file, 'r') as file:
    #         content = file.read()

    #     for key, value in reversed_config.items():
    #         content = content.replace(key, value)

    #     with open(template_file, 'w') as file:
    #         file.write(content)
