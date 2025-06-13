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
    commit_hash = os.environ.get('GITHUB_SHA', None)
    dt = None
    if commit_hash is not None:
        iso8601 = run_git(f'show --no-patch --format=%cI {commit_hash}')
        dt = datetime.fromisoformat(iso8601)
    else:
        commit_hash = run_git('describe --dirty --always')
        dt = datetime.now(timezone.utc)

    utc_dt = dt.astimezone(timezone.utc)

    print(f'{utc_dt:%Y-%m-%d}-{commit_hash}')


def set_dist(version):
    meson_rewrite = os.environ['MESONREWRITE']
    meson_dist_root = os.environ['MESON_PROJECT_DIST_ROOT']

    args = meson_rewrite.split()
    args += [
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
