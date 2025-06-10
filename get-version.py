#!/usr/bin/env python3

# This script is run by meson to set the project version.

import os
import subprocess

from datetime import datetime, timezone


def run_git(cmd: str) -> str:
    full_cmd = ['git']

    source_dir = os.environ.get('MESON_SOURCE_ROOT', None)
    if source_dir is not None:
        full_cmd.extend(['-C', source_dir])

    full_cmd.extend(cmd.split())

    output = subprocess.check_output(full_cmd, encoding='utf-8')

    return output.strip()


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
