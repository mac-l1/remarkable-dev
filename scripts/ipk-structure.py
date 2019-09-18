import sys
import os
import yaml

manifest = sys.argv[1]

stream = open(manifest, 'r')
manifest = yaml.safe_load(stream)

try:
    os.rmdir('ipkbuild')
except:
    pass

os.mkdir('ipkbuild')
os.mkdir('ipkbuild/control')
os.mkdir('ipkbuild/data')

debian_binary = open('ipkbuild/debian-binary', 'w+')
debian_binary.write('2.0')
debian_binary.close()

control = open('ipkbuild/control/control', 'w+')
content = f"""
Package: {manifest['info']['package-name']}
Version: {manifest['info']['version']}
Architecture: armv7-3.2
Maintainer: {manifest['info']['maintainer']}
Description: {manifest['info']['description']}
Priority: optional
"""
control.write(content)

def package_data(folder, path):
    for key in folder:
        if isinstance(folder[key], dict):
            new_path = path + f'{key}/'
            os.mkdir(new_path)
            package_data(folder[key], new_path)
        elif isinstance(folder[key], str):
            os.system(f'cp {folder[key]} {path + key}')
        else:
            # unhandled, should throw
            print(key, type(folder[key]))

package_data(manifest['data'], 'ipkbuild/data/')
