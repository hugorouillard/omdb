#!/bin/sh

set -eu

fixture_version="$(mysql --host=db --user=root --database=omdb --skip-column-names --batch \
    --execute="SELECT Value FROM cache WHERE Attribute = 'dev_fixture_version'" 2>/dev/null || true)"

if [ "$fixture_version" = "1" ]; then
    echo "Development fixtures are already loaded."
    exit 0
fi

echo "Loading development fixtures..."
mysql --host=db --user=root --database=omdb < /fixtures/dev-fixtures.sql
echo "Development fixtures loaded."
