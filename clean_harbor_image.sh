#!/bin/bash
# Author: dshowing
# harbor api 2.0



base_url="https://harbor.xxxxxxx.com/api/v2.0"

harbor_user="xxxx"
harbor_passwd="xxxx"
harbor_token="xxxxxxxx"


proj_file="/data/harbor_cleaner/project.txt"
repo_file="/data/harbor_cleaner/repository.txt"
tags_file="/data/harbor_cleaner/tags.txt"






function get_proj(){
    rm -f ${proj_file}

    curl -X 'GET' \
      "${base_url}/projects?page=1&page_size=100&with_detail=true" \
      -H "accept: application/json" \
      -H "authorization: Basic ${harbor_token}" \
      2>/dev/null | jq . | grep \"name\" | awk -F '"' '{print $4}' \
      > ${proj_file}
}


function get_repo(){
    rm -f ${repo_file}

    for proj in `cat ${proj_file}`; do
        curl -X 'GET' \
          "${base_url}/search?q=${proj}" \
          -H "accept: application/json" \
          -H "authorization: Basic ${harbor_token}" \
          2>/dev/null | jq . | grep repository_name | awk -F '"' '{print $4}' \
          >> ${repo_file}
    done
}


function get_tags(){
    # for repo in `cat ${repo_file} | grep windy`; do
    for repo in `cat ${repo_file}`; do
        rm -f ${tags_file}

        pr=$(echo $repo | awk -F '/' '{print $1}')
        re=$(echo $repo | awk -F '/' '{for (i=2;i<=NF;i++)printf("/%s", $i);print ""}' | cut -c 2-)
        for ((i=1;i>0;i++)); do
            t=$(curl -X 'GET' "${base_url}/projects/${pr}/repositories/${re}/artifacts?page=${i}&page-size=10&sort=push_time" -H "accept: application/json" -H "authorization: Basic ${harbor_token}" 2>/dev/null | jq . | grep \"name\")
            [[ "$t" = "" ]] && break
            curl -X 'GET' \
              "${base_url}/projects/${pr}/repositories/${re}/artifacts?page=${i}&page-size=10&sort=push_time" \
              -H "accept: application/json" \
              -H "authorization: Basic ${harbor_token}" \
              2>/dev/null | jq . | grep \"name\" | awk -F '"' '{print $4}' \
              >> ${tags_file}
        done

        [[ ! -f ${tags_file} ]] && touch ${tags_file}

        sed -i '1, 15d' ${tags_file}

        for tag in `cat ${tags_file}`; do
            curl -X 'DELETE' \
              "https://harbor.k8s.aixuexi.com/api/v2.0/projects/${pr}/repositories/${re}/artifacts/${tag}" \
              -H 'accept: application/json' \
              -H "authorization: Basic ${harbor_token}"
            echo "`date '+%Y-%m-%d %H:%M:%S'`    delete tag: harbor.k8s.aixuexi.com/${pr}/${re}:${tag}" >> /tmp/clean_harbor_image.log
        done

        echo "pr=$pr; re=$re"

    done
}



get_proj
get_repo
get_tags
