while read line; do
	if [[ $line == $1* ]] ; then
		x=$(echo "$line" | awk '{print $2}')
		y=$(echo "$line" | awk '{print $4}')
		cat "$1"_Dealer_schedule | grep -E "$x".*"$y" | awk '{print $1, $2, $5, $6}' >> dealers_working_during_losses
	fi
done <notes_player_analysis
