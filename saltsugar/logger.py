import logging
import sys


def new_text_logger(name, stream=sys.stdout, level=logging.INFO):
    res = logging.getLogger(name)

    handler = logging.StreamHandler(stream=stream)
    handler.setFormatter(logging.Formatter(fmt="%(message)s"))

    res.addHandler(handler)
    res.setLevel(level)

    return res
