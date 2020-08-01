cat logA.txt | sed s/INCORRECT_PASSWORD/ACCESS_DENIED/ > Update1_Combined_Access_Logs.txt
cat Update1_Combined_Access_Logs.txt | awf -F" " '{print $4, $6}' > Update2_Combined_Access_Logs.txt
