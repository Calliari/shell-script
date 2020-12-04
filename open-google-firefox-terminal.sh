# Open a website from terminal
open -a Google\ Chrome --new --args -incognito "http://www.example.com"
open -a Firefox --args -private -new-tab -url "http://www.boostrap.com";

# loop and open all sites listes in the array
websites=(
www.example.com
www.boostrap.com
www.bbc.co.uk
)

# GOOGLE incognito
for website in ${websites[@]}
do
  echo "$website"
  open -a Google\ Chrome --new --args -incognito "http://$website"
done


# FIREFOX private
for website in ${websites[@]}
do
  echo "$website"
  open -a Firefox --args -private -new-tab -url "http://$website";
done
