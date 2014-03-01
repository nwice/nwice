#! /bin/bash
# publish all of www.nwice.com assets

~/nwice/scripts/github_atom_to_nwice.sh
~/nwice/scripts/generate_scripts_index.sh
~/nwice/scripts/nwice_to_s3.sh
~/nwice/scripts/nwice_scripts_plain_text.sh
