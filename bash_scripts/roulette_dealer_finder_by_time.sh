while read line;do
	grep -E "$2".*"$3" | awk '{print $1, $2, $5, $6}' >> dealers_working_during_losses
done< "$1"_Dealer_schedule
