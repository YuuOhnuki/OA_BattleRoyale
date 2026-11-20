#!/usr/bin/env python3
"""Management book generator entry point. Usage: py -3 scripts/gen_admin_book.py <repo>."""
import runpy
from pathlib import Path
runpy.run_path(str(Path(__file__).with_name('gen_admin_terminal_book.py')),run_name='__main__')
