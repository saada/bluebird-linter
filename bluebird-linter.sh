echo "Checking if any file uses native Promise without requiring bluebird..."
FAIL=
for f in $(grep -R '[^a-zA-Z]Promise' ./*.js | awk '{print $1}' | sed -e 's/\:.*//' | uniq)
do
  if ! grep -iq 'bluebird' "$f"
  then
    echo "$f should require('bluebird')" 1>&2
    FAIL=1
  fi
done

if [[ "$FAIL" -eq 1 ]]
then
  exit 1
else
  echo "Bluebird linting passed successfully"
fi
