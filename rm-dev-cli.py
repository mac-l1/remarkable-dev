#!/usr/bin/env python3

import click
import subprocess
import os

paths = {
    'projects': './projects/',
    'scripts': './scripts/',
    'docker': {
        'rm-qtcreator': './docker/rm-qtcreator/'
    }
}

#
# helpers
#

def docker_check():
    return True

#
# functions
#

def docker_build():
    # p = subprocess.Popen(['docker-compose', 'build'], cwd=paths['docker'][image])
    cwd = paths['docker']['rm-qtcreator']
    p = subprocess.Popen(['docker-compose', 'build'], cwd=cwd)
    p.wait()

def clone(url):
    name = url.split('/').pop()
    cwd = paths['projects'] + name
    os.mkdir(cwd)
    p = subprocess.Popen(['git', 'clone', url, 'src'], cwd=cwd)
    p.wait()
    return name

def build(project):
    # get the name of the project's *.pro file
    cwd = paths['projects'] + f'{project}/src'
    p = subprocess.Popen(['find . -name *.pro'], shell=True, stdout=subprocess.PIPE, cwd=cwd)
    p.wait()
    out,err = p.communicate()
    pro_file = out.strip()
    # build
    script = paths['scripts'] + 'qt-build.sh'
    path = os.path.abspath(paths['projects'])
    p = subprocess.Popen([script, path, project, pro_file])
    p.wait()

def prepare(project):
    # find manifest
    cwd = paths['projects'] + project + '/src'
    p = subprocess.Popen(['find . -name package-manifest.*'], shell=True, stdout=subprocess.PIPE, cwd=cwd)
    p.wait()
    out,err = p.communicate()
    manifest = out.strip().decode('UTF-8')
    # structure package
    cwd = paths['projects'] + project
    script = os.path.abspath(paths['scripts']) + '/ipk/prepare.py'
    p = subprocess.Popen(['python', script, f'src/{manifest}'], cwd=cwd)
    p.wait()

def package(project):
    script = paths['scripts'] + '/ipk/package.sh'
    path = os.path.abspath(paths['projects'])
    p = subprocess.Popen([script, path, project])
    p.wait()

def remove(project):
    path = paths['projects'] + project
    input(f'Press enter to ermanently delete {path} or ctrl+c to abort')
    os.system(f'sudo rm -rf {path}')

def upload(project):
    # temporary function to be replaced by an upload to the proper repo
    cwd = paths['projects'] + project
    p = subprocess.Popen(['find . -name *.ipk'], shell=True, stdout=subprocess.PIPE, cwd=cwd)
    p.wait()
    out,err = p.communicate()
    package = out.strip().decode('UTF-8')
    os.system(f'sudo mv {cwd}/{package} ./docker/opkg/html/snapshots')

#
# commands
#

@click.command(name='docker')
# @click.argument('image')
def docker_command():
    # """
    # Build the docker image for IMAGE. \n
    # Available images are: \n
    #   - rm-qtcreator \n
    #   - rm-emulated (soon)
    # """
    return docker()

@click.command(name='clone')
@click.argument('url')
# @click.option('--name', default='', help='directory name of cloned repo')
def clone_command(url):
    """
    Clones a reMarkable project at URL
    """
    return clone(url)

@click.command(name='build')
@click.argument('project')
def build_command(project):
    """
    Uses the rm-qtcreator container to build PROJECT as a reMarkable app
    """
    return build(project)

@click.command(name='prepare')
@click.argument('project')
def prepare_command(project):
    """
    Prepares a built app to be packaged
    """
    return prepare(project)

@click.command(name='package')
@click.argument('project')
def package_command(project):
    """
    Packages a built app into a .ipk package
    """
    return package(project)

@click.command()
@click.argument('url')
def clonepackage(url):
    """
    Clones, builds, prepares and packages a project
    """
    if docker_check() == False:
        docker()
    project = clone(url)
    build(project)
    prepare(project)
    package(project)

@click.command(name='remove')
@click.argument('project')
def remove_command(project):
    return remove(project)

@click.command(name='upload')
@click.argument('project')
def upload_command(project):
    """
    Uploads a package to the repository
    """
    return upload(project)

@click.group()
def cli():
    pass

cli.add_command(docker_command)
cli.add_command(clone_command)
cli.add_command(build_command)
cli.add_command(prepare_command)
cli.add_command(package_command)
cli.add_command(clonepackage)
cli.add_command(remove_command)
cli.add_command(upload_command)

if __name__ == '__main__':
    cli()
