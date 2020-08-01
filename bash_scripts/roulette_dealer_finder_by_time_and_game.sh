while read line; do
	if [[ $4 == "roulette" ]]; then
		grep -E "$2".*"$3" | awk '{$1, $2, $5, $6}'
	elif
		[[ $4 == "blackjack" ]]
	then
		grep -E "$2".*"$3" | awk '{$1, $2, $3, $4}'
	elif
		[[ $4 == "texas hold em" ]]
	then
		grep -E "$2".*"$3" | awk '{$1, $2, $3, $4}'
	fi
done < "$1"_Dealer_schedule
