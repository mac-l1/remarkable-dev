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

@click.command()
@click.argument('image')
def docker(image):
    """
    Build the docker image for IMAGE. \n
    Available images are: \n
      - rm-qtcreator \n
      - rm-emulated (soon)
    """
    p = subprocess.Popen(['docker-compose', 'build'], cwd=paths['docker'][image])
    p.wait()

@click.command()
@click.argument('url')
# @click.option('--name', default='', help='directory name of cloned repo')
def clone(url):
    """
    Clones a reMarkable project at URL
    """
    p = subprocess.Popen(['git', 'clone', url], cwd=paths['projects'])
    p.wait()

@click.command()
@click.argument('project')
def build(project):
    """
    Uses the rm-qtcreator container to build PROJECT as a reMarkable app
    """
    # get the name of the project's *.pro file
    p = subprocess.Popen(['find . -name *.pro'], shell=True, stdout=subprocess.PIPE, cwd=paths['projects']+project)
    p.wait()
    out,err = p.communicate()
    pro_file = out.strip()
    # build
    p = subprocess.Popen([paths['scripts'] + 'qt-build.sh', os.path.abspath(paths['projects']), project, pro_file])
    p.wait()

@click.command()
@click.argument('project')
def prepare(project):
    """
    Prepares a built app to be packaged
    """
    p = subprocess.Popen(['python', os.path.abspath(paths['scripts']) + '/' + 'ipk-structure.py', 'manifest.yml'], cwd=paths['projects']+project)

@click.command()
@click.argument('project')
def package(project):
    """
    Packages a built app into a .ipk package
    """
    p = subprocess.Popen([paths['scripts'] + 'make-ipkg.sh', os.path.abspath(paths['projects']), project])

@click.command()
@click.argument('url')
def clone_package(url):
    """
    Clones, builds, prepares and packages a project
    """
    p = subprocess.Popen([paths['scripts'] + 'make-ipkg.sh', os.path.abspath(paths['projects']), project])

@click.group()
def cli():
    pass

cli.add_command(docker)
cli.add_command(clone)
cli.add_command(build)
cli.add_command(prepare)
cli.add_command(package)

if __name__ == '__main__':
    cli()
