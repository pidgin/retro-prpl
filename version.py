#!/usr/bin/env python3

# This script is run by meson to set the project version.

import os
import subprocess
import sys

from datetime import datetime, timezone


def run_git(cmd: str) -> str:
    full_cmd = ['git']

    source_dir = os.environ.get('MESON_SOURCE_ROOT', None)
    if source_dir is not None:
        full_cmd.extend(['-C', source_dir])

    full_cmd.extend(cmd.split())

    output = subprocess.check_output(full_cmd, encoding='utf-8')

    return output.strip()


def get_version() -> str:
    utc_dt = datetime.now(timezone.utc)
    day_dt = datetime(utc_dt.year, utc_dt.month, utc_dt.day, 0, 0, 0)
    max_age = day_dt.strftime('%s')
    commit = run_git(f'rev-list --max-age {max_age} --count HEAD')

    dirty = ''
    describe = run_git('describe --dirty --always')
    if describe.endswith('-dirty'):
        dirty = '-dirty'

    print(f'{utc_dt:%Y-%m-%d}_{commit}{dirty}')


def set_dist(version):
    meson_rewrite = os.environ['MESONREWRITE']
    meson_dist_root = os.environ['MESON_PROJECT_DIST_ROOT']

    args = [
        *meson_rewrite.split(),
        f'--sourcedir={meson_dist_root}',
        'kwargs',
        'set',
        'project',
        '/',
        'version',
        version,
    ]

    subprocess.check_output(args)


if len(sys.argv) < 2:
    print('expected one argument of "get-version" or "set-dist"')
    sys.exit(1)

if sys.argv[1] == 'get-version':
    get_version()
elif sys.argv[1] == 'set-dist':
    if len(sys.argv) != 3:
        print('no version specified')
        sys.exit(1)

    set_dist(sys.argv[2])
else:
    print(f'unknown command "{sys.argv[1]}"')
    sys.exit(1)
