mkdir -p _site
echo '<!DOCTYPE html>'
echo '<html>'
cat head.html
echo '<body>'

while IFS=read -r line; do
	case $line in
		"### "*) echo -n "$line" | sed 's/## /<h3>/g' ; echo "</h3>" ;;
		"## "*) echo -n "$line" | sed 's/## /<h2>/g' ; echo "</h2>" ;;
		"# "*) echo -n "$line" | sed 's/## /<h1>/g' ; echo "</h1>" ;;
		"Written by"*) echo -n '<span class="info">'; echo -n $line; echo "</span>" ;;
		"=> Version"*) echo -n '<span class="info">'; echo -n $line | sed 's/=> /<a href="/' | sed 's/\t/">/'; echo "</a></span>" ;;
		"=> "*) echo -n echo -n $line | sed 's/=> /<a href="/' | sed 's/\t/">/'; echo "</a></span>" ;;
		*) [-z $line] && echo $line || echo "<p>$line</p>"
	esac
done < index.gmi > index.html

echo '</body>'
echo '</html>'
