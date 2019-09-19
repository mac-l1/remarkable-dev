import sys
import os
# TODO dirtily symlinked
import parse

manifest = sys.argv[1]
ext = manifest.split('.').pop()
stream = open(manifest, 'r').read()
manifest = parse.parse(stream, ext)

print('cleaning previous package if existing')
os.system('rm -r pkg')

print('preparing structure')
os.mkdir('pkg')
os.mkdir('pkg/control')
os.mkdir('pkg/data')

print('writing debian-binary file')
debian_binary = open('pkg/debian-binary', 'w+')
debian_binary.write('2.0')
debian_binary.close()

print('writing control file')
control = open('pkg/control/control', 'w+')
content = f"""\
Package: {manifest['info']['package-name']}
Version: {manifest['info']['version']}
Architecture: armv7-3.2
Maintainer: {manifest['info']['maintainer']}
Description: {manifest['info']['description']}
Priority: optional
"""

if manifest['info']['depends']:
    content += f"Depends: {manifest['info']['depends']}"

control.write(content)

def package_data(folder, path):
    for key in folder:
        if isinstance(folder[key], dict):
            new_path = path + f'{key}/'
            print('creating directory', new_path)
            os.mkdir(new_path)
            package_data(folder[key], new_path)
        elif isinstance(folder[key], str):
            print('installing file', folder[key])
            os.system(f'cp -r {folder[key]} {path + key}')
        else:
            # unhandled, should throw
            print(key, type(folder[key]))

package_data(manifest['data'], 'pkg/data/')
