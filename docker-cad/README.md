GarnetFlow with CAD tools
-------------------------
# How to use it
Due to CAD tool restrictions, the docker image only has necessary tools to
run the CAD tools, but not the CAD tools themselves. To run the image simply
do
```
docker run -d -it --name [NAME] --mount type=bind,source=/cad,target=/cad,readonly keyiz/garnet-flow-cad bash
```
on any `/cad` mounted machine, where `[NAME]` refers to the container name.
To use any CAD tools, please follow this [link](https://vlsiweb.stanford.edu/mediawiki/index.php/Using_CAD_Tools)
(requires Stanford login).
