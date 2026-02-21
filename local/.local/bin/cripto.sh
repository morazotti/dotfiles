#!/bin/bash
price=`curl -s brl.rate.sx/1BTC`
price=`printf "%.2f" $price`
last=`curl -s 'brl.rate.sx/BTC@1d?T' | grep "change" | awk -F\( '{printf $2}' | sed "s/)//g;s/%//g"`
date=`date +'%Y/%m/%d %T'`
printf "\xe2\x82\xbf %.2f / %.2f\n" $price $last
echo "P "$date" BTC "$price" BRL" >> /home/nicolas/.config/emacs/private/btc_price.db
