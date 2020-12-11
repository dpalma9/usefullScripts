#!/usr/local/bin/bash

#**************
# CABECERA
#**************
# Descripcion: Script to refresh index patterns on Kibana.
# Version: 1.0
# Autor: Daniel Palma
# Fecha creacion/modificacion: 11 Dec 2020
# Entrada: None
# Salida: None
#**************
# FUNCIONS
get_indexPatterns (){
    indexPattern_List=`curl -s "${KIBANA_SERVER}:${KIBANA_PORT}/api/saved_objects/_find?fields=title&fields=type&per_page=10000&type=index-pattern" -u "${KIBANA_USER}:${KIBANA_PWD}"| jq '.saved_objects[].attributes.title'`
}

refresh_indexPatterns (){
    echo "Starting..."
    echo "Working for all index but the generic *"
    for index in $indexPattern_List
    do
        if [ "$index" != '"*"' ]; then
            echo "Index: $index"
            PATTERN=`echo "$index" | xargs`
	        PATTERN_ID="${PATTERN::-1}"
            FIELDS=$(curl -fs "${KIBANA_SERVER}:${KIBANA_PORT}/api/index_patterns/_fields_for_wildcard?pattern=$PATTERN&meta_fields=_source&meta_fields=_id&meta_fields=_type&meta_fields=_index&meta_fields=_score" -u "$KIBANA_USER:$KIBANA_PWD" -k -H "kbn-xsrf: true"| jq .fields -c - | jq -Ras . -)
            TEMP=$(mktemp)
            cat <<EOF > $TEMP
{
  "attributes": {
    "title": "$PATTERN",
    "timeFieldName":"@timestamp",
    "fields": $FIELDS
  }
}
EOF
            ## Chose global or space, you don't need both
            ## Update index at global level
            #curl -fs -X PUT "${KIBANA_SERVER}:${KIBANA_PORT}/api/saved_objects/index-pattern/$PATTERN_ID" -H "kbn-xsrf: true" -u "${KIBANA_USER}:${KIBANA_PWD}" -H "Content-Type: application/json" -d@$TEMP
            ## Update index at space level
            curl -fs -X PUT "${KIBANA_SERVER}:${KIBANA_PORT}/s/$PATTERN_ID/api/saved_objects/index-pattern/$PATTERN_ID" -H "kbn-xsrf: true" -u "${KIBANA_USER}:${KIBANA_PWD}" -H "Content-Type: application/json" -d@$TEMP
            rm $TEMP
        fi
    done
}

# MAIN
echo "Starting process..."
echo "Getting all index patterns"
get_indexPatterns

echo "Refresh all index patterns"
refresh_indexPatterns
