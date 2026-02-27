#!/bin/bash

HTML="tso.html"
JSON="tso-resources.json"
BACKUP="tso.html.bak"

if [ ! -f "$HTML" ]; then
  echo "Error: $HTML not found"
  exit 1
fi

if [ ! -f "$JSON" ]; then
  echo "Error: $JSON not found"
  exit 1
fi

cp "$HTML" "$BACKUP"

awk '
BEGIN { inblock=0 }
/<script id="seed-data" type="application\/json">/ {
  print "<script id=\"seed-data\" type=\"application/json\">"
  while ((getline line < "'$JSON'") > 0) print line
  print "</script>"
  inblock=1
  next
}
/<\/script>/ {
  if (inblock==1) {
    inblock=0
    next
  }
}
{
  if (inblock==0) print
}
' "$BACKUP" > "$HTML"

echo "Seed data embedded successfully."
echo "Backup saved as $BACKUP"
