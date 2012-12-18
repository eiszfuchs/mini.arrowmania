#!/bin/bash

echo --------------------------------------------------------------------------------

FLEX4=~/Library/Flex

# delete it, that fixes build problems (Oh yeah. I'm serious.)
rm bin/arrowmania.swf

${FLEX4}/bin/mxmlc -library-path+=${FLEX4}/frameworks/libs/ -source-path+=${FLEX4}/frameworks/projects/framework/src/ -load-config ${FLEX4}/frameworks/flex-config.xml -load-config obj/maniaMac.xml -source-path+=src/ -output bin/arrowmania.swf -debug=false -incremental=true -benchmark=false -static-link-runtime-shared-libraries=true -optimize=true

# ${FLEX4}/bin/fdb bin/arrowmania.swf

echo --------------------------------------------------------------------------------
