#!/bin/bash

# 'Autobrew' is being used by more and more packages these days
# to grab static libraries from Homebrew bottles. These bottles
# are fetched via Homebrew's --force-bottle option which grabs
# a bottle for the build machine which may not be macOS 10.9.
# Also, we want to use conda packages (and shared libraries) for
# these 'system' dependencies. See:
# https://github.com/jeroen/autobrew/issues/3
export DISABLE_AUTOBREW=1

# R refuses to build packages that mark themselves as Priority: Recommended
mv DESCRIPTION DESCRIPTION.old
grep -va '^Priority: ' DESCRIPTION.old > DESCRIPTION
# shellcheck disable=SC2086
${R} CMD INSTALL --build . ${R_ARGS}

# Add more build steps here, if they are necessary.
mkdir -p ${PREFIX}/bin
cp scripts/calder ${PREFIX}/bin
chmod 755 ${PREFIX}/bin/calder

# See
# https://docs.conda.io/projects/conda-build
# for a list of environment variables that are set during the build process.
