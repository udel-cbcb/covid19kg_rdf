mkdir -p json/rlims.litcovid.medline/
perl split_json.pl json/rlims.litcovid.medline.aligned.json json/rlims.litcovid.medline/

mkdir -p json/efip.litcovid.medline/
perl split_json.pl json/efip.litcovid.medline.aligned.json json/efip.litcovid.medline/

mkdir -p json/mirtex.litcovid.medline/
perl split_json.pl json/mirtex.litcovid.medline.aligned.json json/mirtex.litcovid.medline/

mkdir -p json/rlims.cord19.medline/
perl split_json.pl json/rlims.cord19.medline.aligned.json json/rlims.cord19.medline/

mkdir -p json/efip.cord19.medline/
perl split_json.pl json/efip.cord19.medline.aligned.json json/efip.cord19.medline/

mkdir -p json/mirtex.cord19.medline/
perl split_json.pl json/mirtex.cord19.medline.aligned.json json/mirtex.cord19.medline/

mkdir -p json/rlims.cord19.pmc/
perl split_json.pl json/rlims.cord19.pmc.aligned.json json/rlims.cord19.pmc/

mkdir -p json/efip.cord19.pmc/
perl split_json.pl json/efip.cord19.pmc.aligned.json json/efip.cord19.pmc/

mkdir -p json/mirtex.cord19.pmc/
perl split_json.pl json/mirtex.cord19.pmc.aligned.json json/mirtex.cord19.pmc/

