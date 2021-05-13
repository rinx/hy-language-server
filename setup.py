from setuptools import setup

with open('README.md', 'r') as f:
    long_description = f.read()

setup(
    name='hy-language-server',
    version='0.0.7',
    author='Rintaro Okamura',
    author_email='rintaro.okamura@gmail.com',
    description='hy language server using Jedhy',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/rinx/hy-language-server',
    packages=['hyls'],
    python_requires='>=3.6',
    install_requires=[
        'argparse',
        'hy @ git+ssh://git@github.com/hylang/hy',
        'pygls',
        'jedhy @ git+ssh://git@github.com/rinx/jedhy@update/hy-1.0a1'
    ],
    entry_points={
        'console_scripts': [
            'hyls=hyls.__main__:main'
        ]
    }
)
