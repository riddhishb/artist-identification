import sys

if len(sys.argv) != 2:
    print ("Wrong arguments. We need just 1.")
    sys.exit(0)

image = sys.argv[1]

dataString = "/* \n \
Performs confidence based edge detection. \n \
*/ \n \
 \n \
//Specify the edge detection parameters \n \
GradientWindowRadius = 2; \n \
MinimumLength = 5; \n \
NmxRank = 0.5; \n \
NmxConf = 0.5; \n \
NmxType = ARC; \n \
HysterisisHighRank = 0.9; \n \
HysterisisHighConf = 0.9; \n \
HysterisisHighType = BOX; \n \
HysterisisLowRank = 0.8; \n \
HysterisisLowConf = 0.8; \n \
HysterisisLowType = CUSTOM; \n \
CustomCurveHystLow = {(0.4,0.7), (0.6,0.3)}; \n \
 \n \
// Display progress \n \
DisplayProgress ON; \n \
\n \
//Load an image to perform edge detection \n \
Load('" + image + "', IMAGE); \n \
\n \
//Perform edge detection \n \
EdgeDetect; \n \
\n \
//Save the resulting edge map \n \
Save('edge_maps/" + image.split('/')[-1].split('.')[0] + ".pgm', PGM, EDGES); \n \
\n \
//done. \n \
"

with open('script_edison.ed', 'w') as f:
    f.write(dataString)

print(str(image.split('/')[-1].split('.')[0]) + ".pgm")
