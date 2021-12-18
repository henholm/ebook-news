#!/usr/bin/env bash
# Update Calibre-fetched news

notifier=/usr/local/bin/terminal-notifier
calibre_folder="/Users/$USER/Calibre Library/calibre/"
dropbox_folder="/Users/$USER/Dropbox/dropbox_books"
echo "Searching for news epubs in $calibre_folder. Copying to $dropbox_folder if any are found."

# Delete from Calibre if older than 5 days.
# find $calibre_folder -mtime +5 -type d -delete
find "$calibre_folder" -mtime +5 -type d -print

# Delete The Economist, FAZ, Le Monde, and 人民日报 from Dropbox if older than 5 days.
# find $dropbox_folder \( -name "*The Economist*" -o -name "*Le Monde*" -o -name "*FAZ*" -o -name "*人民日报*" \) -mtime -5 -type f -delete
find "$dropbox_folder" \( -name "*The Economist*" -o -name "*Le Monde*" -o -name "*FAZ*" -o -name "*Ren Min Ri Bao*" \) -mtime -5 -type f -print

# If new news exist, add them to Dropbox. Use -print0 and -0 to handle paths containing spaces.
# find "$calibre_folder" \( -name "*The Economist*.epub" -o -name "*Le Monde*.epub" -o -name "*FAZ*.epub" -o -name "*Ren Min Ri Bao*.epub" \) -type f -print0 | xargs -0 cp "$dropbox_folder"
# to_copy_array=$(find "$calibre_folder" \( -name "*The Economist*.epub" -o -name "*Le Monde*.epub" -o -name "*FAZ*.epub" -o -name "*Ren Min Ri Bao*.epub" \) -type f)
to_copy_array=()
while IFS=  read -r -d $'\0'; do
    to_copy_array+=("$REPLY")
done < <(find "$calibre_folder" \( -name "*The Economist*.epub" -o -name "*Le Monde*.epub" -o -name "*FAZ*.epub" -o -name "*Ren Min Ri Bao*.epub" \) -type f -print0)

# Use the -u / --update flag to only copy if source file does not exist in destination folder, or if source file is newer than existing file in destination folder.
cp -u "${to_copy_array[@]}" "$dropbox_folder"
echo "Copied ${#to_copy_array} news epubs to Dropbox."

$notifier -title "Update News" -subtitle "Removing old Calibre News / Adding new news to Dropbox" -message "Completed"

now=$(date)
echo "Cron job to update news completed at $now"