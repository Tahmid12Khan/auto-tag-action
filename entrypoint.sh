#!/bin/bash

git fetch --tags
tag=$(git tag --sort=creatordate | grep -i "RC-.*" | tail -1)

# remove "RC-" prefix
latest_tag="${tag//'RC-'}"
echo "latest tag -> $latest_tag"
#if there is no RC tag create a new one
if [[ -z "$latest_tag" ]]; then
  latest_tag='0.0.0'
fi

TEMP_IFS=$IFS
# temporary separator
IFS='.'

# separate based on periods
read -a tag_arr <<< $latest_tag
IFS=$TEMP_IFS

# max_version for sub versions
max_sub_version=100

# max parts for the version (0 based)
i=2
version_updated=0

while [[ $i -gt 0 ]]; do
  new_version=$((${tag_arr[$i]} + 1))
  if [[ $new_version -lt $max_sub_version ]]; then
    version_updated=1
    tag_arr[$i]=$new_version
    break
  fi
  tag_arr[$i]=0
  i=$(($i - 1))
done

if [[ $version_updated -eq 0 ]]; then
  tag_arr[$i]=$((${tag_arr[$i]} + 1))
  version_updated=1
fi

function join_by_using_single_character {
  local IFS="$1"
  shift
  echo "$*"
}

new_tag="RC-$(join_by_using_single_character '.' ${tag_arr[@]})"
echo "New tag -> $new_tag"

# create and push the new tag
git tag $new_tag
git push origin $new_tag
