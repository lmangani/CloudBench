#!/usr/bin/env python3
from contextlib import contextmanager
import os
import timeit
import sys
from datafusion import SessionContext

@contextmanager
def suppress_stdout():
    with open(os.devnull, "w") as devnull:
        old_stdout = sys.stdout
        sys.stdout = devnull
        try:
            yield
        finally:
            sys.stdout = old_stdout

db = SessionContext()

query = sys.stdin.read()
print(query)

for try_num in range(3):
    start = timeit.default_timer()
    with suppress_stdout():
      try:
        result = db.sql(query).collect()
      except Exception as e:
        continue
    end = timeit.default_timer()
    print(end - start)
