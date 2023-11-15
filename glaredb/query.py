#!/usr/bin/env python3
from contextlib import contextmanager
import os
import glaredb
import timeit
import sys

@contextmanager
def suppress_stdout():
    with open(os.devnull, "w") as devnull:
        old_stdout = sys.stdout
        sys.stdout = devnull
        try:
            yield
        finally:
            sys.stdout = old_stdout

gdb = glaredb.connect()
query = sys.stdin.read()
print(query)

for try_num in range(3):
    start = timeit.default_timer()
    with suppress_stdout():
      try:
        result = gdb.sql(query).show()
      except Exception as e:
        continue
    end = timeit.default_timer()
    print(end - start)

print()
