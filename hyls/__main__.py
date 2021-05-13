import argparse
import logging

import hy

from .server import Server

logging.basicConfig(filename="/tmp/hyls.log", filemode="w", level=logging.DEBUG)
logging.getLogger('hyls')

def main():
    parser = argparse.ArgumentParser()
    parser.description = 'hy language server'

    parser.add_argument(
        '--version', action='store_true',
        help='Print version and exit'
    )

    args = parser.parse_args()

    if args.version:
        print('hy language server v0.0.7')
        return

    srv = Server()
    srv.start()

if __name__ == '__main__':
    main()
