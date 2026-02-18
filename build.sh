#!/bin/sh

cp Cantarell-VF.woff2 _site/
cp cantarell.css _site/

echo '<!DOCTYPE html>'
echo '<html>'
cat head.html
echo '<body>'
code=0

while IFS= read -r line; do
  echo "$line" >/tmp/line

  # sed -i 's/ONUM/<code>ONUM<\/code>/' /tmp/line
  sed -i 's/onum/<code>onum<\/code>/' /tmp/line
  sed -i 's/lnum/<code>lnum<\/code>/' /tmp/line

  line=$(cat /tmp/line)

  case "$line" in
  "### "*)
    echo -n "$line" | sed 's/### /<h3>/g'
    echo "</h3>"
    ;;
  "## "*)
    echo -n "$line" | sed 's/## /<h2>/g'
    echo "</h2>"
    ;;
  "# "*)
    echo -n "$line" | sed 's/# /<h1>/g'
    echo "</h1>"
    ;;
  "Written by"*)
    echo -n '<span class="info">'
    echo -n "$line"
    echo "</span>"
    ;;
  "=> releases.tsv"*)
    echo -n "<span class=\"info\">$line" | sed 's/=> /<a href="/' | sed 's/\t/">/'
    echo "</span></a>"
    ;;
  "=> "*)
    echo -n "$line" | sed 's/=> /<a href="/' | sed 's/\t/">/'
    echo "</a>"
    ;;
  "\`\`\`code"*)
    echo "<code><pre>"
    code=1
    ;;
  "\`\`\`"*)
    echo "</pre></code>"
    code=0
    ;;
  "* "*)
    echo -n "$line" | sed 's/* /<li>/'
    echo "</li>"
    ;;
  *) echo "$line" ;;
  esac
done <index.gmi

echo '<br><br><span style="font-size: 75%">This site is set in a customized version of Cantarell v0.100. Feel free to play with the ONUM axis using developer tools.</span>'
echo '</body>'
echo '</html>'
