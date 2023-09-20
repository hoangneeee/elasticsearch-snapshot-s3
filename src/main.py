import sys

from snapshot import *

if __name__ == '__main__':
    esm = ElasticsearchSnapshot()
    if len(sys.argv) == 2:
        arg: str = sys.argv[1]
        if arg == 'snapshot':
            esm.snapshot()
    else:
        esm.automated_snapshot()
