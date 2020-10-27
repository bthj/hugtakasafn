#!/bin/bash
SCRIPTS_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SCRIPTS_DIR" ]]; then SCRIPTS_DIR="$PWD"; fi

mkdir -p $SCRIPTS_DIR/product
rm $SCRIPTS_DIR/product/*

echo "download web page as template"
curl https://www.stjornarradid.is/gogn/hugtakasafn/ | iconv -f utf-8 -t iso8859-1 > $SCRIPTS_DIR/product/stjrTemplateInput.html
curl https://www.stjornarradid.is/lisalib/assets/svgsprite/themes/Stjornarrad/template/svg > $SCRIPTS_DIR/product/stjr.svg

echo "add Google Analytics script tag and HTS specific CSS to template"
# https://stackoverflow.com/a/2512379/169858
sed  -e "/<\/body>/r $SCRIPTS_DIR/googleAnalyticsScriptTag.html" -e 'x;$G' $SCRIPTS_DIR/product/stjrTemplateInput.html | sed  -e "/<\/head>/r $SCRIPTS_DIR/htsStyle.html" -e 'x;$G' > $SCRIPTS_DIR/product/stjrTemplateInputWithGA.html


SRC_REPLACE_EXPRESSION='s/src="\(\/[^\/][^"]*\)"/src="\/\/www.stjornarradid.is\1"/g'
HREF_REPLACE_EXPRESSION='s/href="\(\/[^\/][^"]*\)"/href="\/\/www.stjornarradid.is\1"/g'
ACTION_REPLACE_EXPRESSION='s/action="\(\/[^\/][^"]*\)"/action="https:\/\/www.stjornarradid.is\1"/g'
USE_XLINK_REPLACE_EXPRESSION='s/<use xlink:href="[^#]*#/<use xlink:href="\/stjr\.svg#/g'

echo "prepare 'before' template part (before <iframe tag)"
# (https://www.reddit.com/r/bash/comments/6vg83v/removing_everything_after_match_to_end_of_file_in/dm01v3f/?utm_source=reddit&utm_medium=web2x&context=3)
sed '/<iframe/{s/\(.*\)<iframe.*/\1/;q}' $SCRIPTS_DIR/product/stjrTemplateInputWithGA.html > $SCRIPTS_DIR/product/stjrTemplateBefore.html
sed -i "$SRC_REPLACE_EXPRESSION" $SCRIPTS_DIR/product/stjrTemplateBefore.html
sed -i "$HREF_REPLACE_EXPRESSION" $SCRIPTS_DIR/product/stjrTemplateBefore.html
sed -i "$ACTION_REPLACE_EXPRESSION" $SCRIPTS_DIR/product/stjrTemplateBefore.html
sed -i "$USE_XLINK_REPLACE_EXPRESSION" $SCRIPTS_DIR/product/stjrTemplateBefore.html

echo "prepare 'after' template part (after iframe tag)"
# (https://stackoverflow.com/a/6482107/169858)
sed -n '/\(^.*iframe\)/,$p' $SCRIPTS_DIR/product/stjrTemplateInputWithGA.html | sed '1 s/.*<\/iframe>\(.*\)/\1/' > $SCRIPTS_DIR/product/stjrTemplateAfter.html
sed -i "$SRC_REPLACE_EXPRESSION" $SCRIPTS_DIR/product/stjrTemplateAfter.html
sed -i "$HREF_REPLACE_EXPRESSION" $SCRIPTS_DIR/product/stjrTemplateAfter.html
sed -i "$ACTION_REPLACE_EXPRESSION" $SCRIPTS_DIR/product/stjrTemplateAfter.html
sed -i "$USE_XLINK_REPLACE_EXPRESSION" $SCRIPTS_DIR/product/stjrTemplateAfter.html

echo "deploy under web root"
cp $SCRIPTS_DIR/product/stjrTemplateBefore.html $SCRIPTS_DIR/../web/hugtakasafn/www/
cp $SCRIPTS_DIR/product/stjrTemplateAfter.html $SCRIPTS_DIR/../web/hugtakasafn/www/
cp $SCRIPTS_DIR/product/stjr.svg $SCRIPTS_DIR/../web/hugtakasafn/www/

