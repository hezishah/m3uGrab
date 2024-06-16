curl -sH \
-X 'GET' \
-H 'Sec-Fetch-Site: cross-site' \
-H 'Accept: */*' \
-H 'Origin: https://iframe.mediadelivery.net' \
-H 'Sec-Fetch-Dest: empty' \
-H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
-H 'Sec-Fetch-Mode: cors' \
-H 'Host: vz-97222014-46e.b-cdn.net' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15' \
-H 'Referer: https://iframe.mediadelivery.net/' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Connection: keep-alive' $1 | gunzip > filelist.txt

rm all.ts

while read p; do
  if [[ $p != \#* ]] then
      bash curl.sh $(dirname $1) $p
      echo "$(dirname $1)/$p"
  fi
done <filelist.txt

ffmpeg -i all.ts -acodec copy -vcodec copy all.mp4

