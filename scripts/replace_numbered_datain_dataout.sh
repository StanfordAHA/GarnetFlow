awk '{gsub("datain0", "datain.0", $0); print}' $1 > /tmp/dout_tmp.json
awk '{gsub("dataout0", "dataout", $0); print}' /tmp/dout_tmp.json
