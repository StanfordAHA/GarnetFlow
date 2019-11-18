awk '{gsub("lakelib", "commonlib", $0); print}' $1
