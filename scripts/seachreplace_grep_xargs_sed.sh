#! /bin/bash
grep -lr -e 'word' * | xargs sed -i 's/word/replace/g'
