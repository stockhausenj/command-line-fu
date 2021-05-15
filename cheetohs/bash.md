One-liner to handle return code of previous command.

```
[ ! $? -eq 0 ] && { echo "error with rsync"; exit 1; }
[[ -z "${v1}" && -z "${v2}" ]] && { echo "need v1 and v2"; exit 1; }
```

Get params.

```
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

```
name=${1:?"Error: parameter missing Name"}
age=${2:?"Error: parameter missing Age"}
```

Create default value for variable.

`name=${name:-Unknown}`
