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

if awk '
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
' "$BACKUP" > "$HTML"; then
  python3 - "$HTML" <<'PY'
import re
import sys

path = sys.argv[1]
with open(path, "r", encoding="utf-8") as f:
    text = f.read()

version_re = re.compile(r'(?m)^(\s*)const APP_VERSION = "(\d+)\.(\d+)";$')
match = version_re.search(text)

if match:
    old_version = f"{match.group(2)}.{match.group(3)}"
    new_version = f"{match.group(2)}.{int(match.group(3)) + 1}"
    replacement = f'{match.group(1)}const APP_VERSION = "{new_version}";'
    text = version_re.sub(replacement, text, count=1)
    print(f"Version bumped: {old_version} → {new_version}")
else:
    version_line = 'const APP_VERSION = "1.0";\n'
    debug_re = re.compile(r'(?m)^const DEBUG = ')
    debug_match = debug_re.search(text)
    if debug_match:
        text = text[:debug_match.start()] + version_line + text[debug_match.start():]
    else:
        data_re = re.compile(r'(?m)^let data = JSON\.parse\(localStorage\.getItem\("tsoData"\) \|\| "null"\);$')
        data_match = data_re.search(text)
        if data_match:
            text = text[:data_match.end()] + "\n" + version_line + text[data_match.end():]
        else:
            text = version_line + text
    print("Version initialized to 1.0")

with open(path, "w", encoding="utf-8") as f:
    f.write(text)
PY
else
  echo "Error: seed data embed failed"
  exit 1
fi

echo "Seed data embedded successfully."
echo "Backup saved as $BACKUP"
