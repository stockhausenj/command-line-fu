First line.

`#!/usr/bin/env bash`

Exit script when a command fails.

`set -o errexit`

Fail when accessing an unset variable.

`set -o nounset`

Fail when any of the commands in a pipe fail.

`set -o pipefail`

Debug mode.

```bash
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

TRACE=1 ./script.sh
```

Bash script template.
```bash
#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./script.sh arg-one arg-two

This is an awesome bash script to make your life better.

'
    exit
fi

cd "$(dirname "$0")"

main() {
    echo do awesome stuff
}

main "$@"
```

One-liner to handle return code of previous command.

```bash
[ ! $? -eq 0 ] && { echo "error with rsync"; exit 1; }
[[ -z "${v1}" && -z "${v2}" ]] && { echo "need v1 and v2"; exit 1; }
```

Get params.

```bash
usage() { echo "Usage: $0 [--name <string>]
                           [--age <int>]
                           (optional) [--country <string>] Default: United States" 1>&2; exit 1; }

while [ $# -gt 0 ] ; do
  case $1 in
    -n | --name) name="$2" ;;
    -a | --age) age="$2" ;;
    -c | --country) country="$2" ;;
    -u | --usage) usage ;;
  esac
  shift
done

if [ -z "${name}" ] || [ -z "${age}" ]; then
    usage
fi
```

Check positional arguments.

```bash
name=${1:?"Error: parameter missing Name"}
age=${2:?"Error: parameter missing Age"}
```

Create default value for variable.

`name=${name:-Unknown}`
