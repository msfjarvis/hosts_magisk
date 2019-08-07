ver=$(sed -n "s|^version=||p" module.prop)
name=$(sed -n "s|^id=||p" module.prop | sed "s| |-|g")
zip -r "$name"-"$ver".zip . -x ".git/*" "LICENSE" "deploy.sh" ".gitignore"

# Stolen from https://stackoverflow.com/a/12711853
for arg; do
    if [ "${arg}" == "--non-interactive" ]; then
        skip_push=true
    fi
done

[ -z "$skip_push" ] && adb wait-for-device push "$name"-"$ver".zip /sdcard/

